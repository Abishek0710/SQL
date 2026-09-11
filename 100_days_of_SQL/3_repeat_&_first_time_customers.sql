/*
You are working on an e-commerce platform (Amazon-like).

Every day:

Customers place orders

Some customers are new (first-time buyers)

Some customers are repeat buyers

🎯 Goal

For each day, find:

Number of new customers

Number of repeat customers

🧱 Table Structure

CREATE TABLE customer_orders (
    order_id INTEGER,
    customer_id INTEGER,
    order_date TEXT,      -- YYYY-MM-DD
    order_amount INTEGER
);

input data:

order_id	customer_id	 order_date	 order_amount
1	            100	     2023-01-01	    500
2	            200	     2023-01-01	    700
3	            300	     2023-01-01	    400
4	            100	     2023-01-02	    600
5	            400	     2023-01-02	    800
6	            500	     2023-01-02	    300
7	            100	     2023-01-03	    900
8	            400	     2023-01-03	    200
9	            600	     2023-01-03	    1000


Expected Output
order_date	new_customers	repeat_customers
2023-01-01	        3	        0
2023-01-02	        2	        1
2023-01-03	        1	        2
*/

--solution
with first_visit as
(select customer_id, min(order_date) as visit
from customer_orders
group by customer_id)

select co.order_date, 
sum(case when co.order_date=fv.visit then 1 else 0 end) as new_customers,
sum(case when co.order_date!=fv.visit then 1 else 0 end ) as repeat_customers
from customer_orders as co
inner join first_visit as fv on co.customer_id = fv.customer_id
group by co.order_date;
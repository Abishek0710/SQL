/*
You are given two tables:

products – contains product prices

customer_budget – contains customer budgets

Each customer can buy multiple products, but:

📜 Rules

A customer can buy as many products as possible within their budget

Products must be selected in increasing order of cost

If a customer cannot afford all products, always pick cheaper products first

Output:

customer_id

budget

number_of_products_bought

list_of_products (comma-separated, sorted by cost)

🗃️ Table Schemas

CREATE TABLE products (
    product_id VARCHAR(20),
    cost INT
);
 
CREATE TABLE customer_budget (
    customer_id INT,
    budget INT
);


Input data:
product_id	cost
P1	        300
P2	        500
P3	        700
P4	        900
P5	        1200


customer_id	budget
100	        400
200	        800
300	        1500
400	        200
500	        1000
600	        1800
700	        300
800	        2500


Expected Output:

customer_id	budget	no_of_products	list_of_products
100	        400	            1	        P1
200	        800	            2	        P1,P2
300	        1500	        3	        P1,P2,P3
400	        200	            0	        null
500	        1000	        2	        P1,P2
600	        1800	        3	        P1,P2,P3
700	        300	            1	        P1
800	        2500	        4	        P1,P2,P3,P4
*/


with cte as(
Select *,
sum(cost) over(order by cost asc) as running_cost
from products
)

select cb.customer_id, cb.budget, count(c.product_id) as no_of_products,
GROUP_CONCAT(c.product_id, ',') AS list_of_products from cte as c 
left join customer_budget cb on cb.budget >= c.running_cost
group by cb.customer_id, cb.budget
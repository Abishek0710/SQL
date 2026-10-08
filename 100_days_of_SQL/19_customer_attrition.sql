/*
You are given a transactions table containing customer orders.

Customer churn for a month is defined as:

Customers who placed at least one order in the previous month but did not place any order in the current month.

Important rules

Churn is calculated month-over-month

The last month in data cannot have churn (no future month to compare)

Customers may place multiple orders in a month, but should be counted once

Result should show month-wise churned customer count

🗂 Table Schema

CREATE TABLE transactions (
    order_id INTEGER,
    cust_id INTEGER,
    order_date DATE,
    amount INTEGER
);

Input data:

order_id	cust_id	    order_date	    amount
1	            1	    2023-12-05	    500
2	            2	    2023-12-10	    300
3	            3	    2023-12-15	    700
4	            1	    2024-01-03	    400
5	            2	    2024-01-10	    600
6	            4	    2024-01-12	    800
7	            5	    2024-01-20	    200
8	            1	    2024-02-02	    900
9	            2	    2024-02-05	    300
10	            5	    2024-02-10	    500
11	            2	    2024-03-01	    400
12	            6	    2024-03-05	    1000
13	            7	    2024-03-10	    450
14	            2	    2024-04-02	    700
15	            7	    2024-04-05	    600
16	            1	    2024-02-20	    300
17	            2	    2024-01-25	    200
18	            4	    2024-01-28	    150
19	            6	    2024-03-18	    500
20	            7	    2024-04-15	    250
21	            8	    2024-01-08	    400
22	            9	    2024-02-14	    550
23	            10	    2024-03-22	    350
24	            11	    2024-04-25	    900


Expected Output:

month_date	churned_customers
01	            2
02	            3
03	            2
04	            3
12	            1
*/


Select strftime('%m', prev_month.order_date) as month_date,
count(distinct prev_month.cust_id) as churned_customers from transactions prev_month
left join transactions this_month on prev_month.cust_id = this_month.cust_id
AND datediff(this_month.order_date, prev_month.order_date) = 1
WHERE this_month.cust_id IS NULL
GROUP BY STRFTIME('%m', prev_month.order_date)


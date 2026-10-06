/*

You are given:

An orders table with order-wise product purchases

A products table with product names

Your task:

👉 Find all unique pairs of products that were purchased together in the same order and count how many times each pair was bought together.

Important Rules

Only consider products within the same order

Each pair should be unique and unordered

(A, B) is the same as (B, A)

Orders with only one product should be ignored

Output should contain:

Product 1

Product 2

Number of times bought together

🗄️ Table Schemas

CREATE TABLE orders (
    order_id INTEGER,
    customer_id INTEGER,
    product_id INTEGER
);
 
CREATE TABLE products (
    id INTEGER,
    name TEXT
);


Input data:
orders table:
order_id	customer_id	product_id
1	        101	            1
1	        101	            2
1	        101	            3
2	        102	            1
2	        102	            2
3	        103	            1
4	        104	            2
4	        104	            3
5	        105	            1
5	        105	            3
6	        106	            1
6	        106	            2
6	        106	            3
7	        107	            2
8	        108	            1
8	        108	            4
9	        109	            1
9	        109	            2
10	        110	            3
10	        110	            5

products table:

id	        name
1	        Phone
2	        Screen Guard
3	        Phone Cover
4	        Power Bank
5	        Earphones

Expected Output:

pair	                    purchase_freq
Phone Phone Cover	            3
Phone Power Bank	            1
Phone Screen Guard	            4
Phone Cover Earphones	        1
Screen Guard Phone Cover	    3

*/

SELECT
    pr1.name || ' ' || pr2.name AS pair,      -- use || for string concatenation in SQLite
    COUNT(*) AS purchase_freq
FROM orders o1
JOIN orders o2 ON o1.order_id = o2.order_id
JOIN products pr1 ON pr1.id = o1.product_id
JOIN products pr2 ON pr2.id = o2.product_id
WHERE o1.product_id < o2.product_id
GROUP BY pr1.name, pr2.name;
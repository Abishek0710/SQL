/*

You are given an int_orders table containing order details.

Each salesperson can have multiple orders.

👉 Task

For each salesperson, return the complete row corresponding to the highest order amount they have sold.

❌ Restrictions (Very Important)

You CANNOT use:

Subqueries

CTEs

Window functions (rank, row_number, etc.)

Temporary tables

✅ You CAN use:

JOIN

GROUP BY

HAVING

🗂 Table Schema

CREATE TABLE int_orders (
    order_number INTEGER NOT NULL,
    order_date DATE NOT NULL,
    cust_id INTEGER NOT NULL,
    salesperson_id INTEGER NOT NULL,
    amount REAL NOT NULL
);

Input:

order_number	order_date	    cust_id	salesperson_id	amount
1	            2024-01-01	    101	        1	        500
2	            2024-01-02	    102	        2	        1800
3	            2024-01-03	    103	        2	        2400
4	            2024-01-04	    104	        2	        2100
5	            2024-01-05	    105	        3	        600
6	            2024-01-06	    106	        3	        450
7	            2024-01-07	    107	        3	        720
8	            2024-01-08	    108	        4	        900
9	            2024-01-09	    109	        4	        850
10	            2024-01-10	    110	        5	        1000
11	            2024-01-11	    111	        5	        950
12	            2024-01-12	    112	        5	        1200
13	            2024-01-13	    113	        6	        400
14	            2024-01-14	    114	        7	        300
15	            2024-01-15	    115	        7	        650
16	            2024-01-16	    116	        7	        720
17	            2024-01-17	    117	        8	        1500
18	            2024-01-18	    118	        9	        200
19	            2024-01-19	    119	        9	        350
20	            2024-01-20	    120	        10      	1100
21	            2024-01-21	    121	        10      	1300
22	            2024-01-22	    122	        10      	1250
23	            2024-01-23	    123	        11      	800
24	            2024-01-24	    124	        12      	2200
25	            2024-01-25	    125	        13      	700


Expected Output:
order_number	order_date	    cust_id	salesperson_id	amount
1	            2024-01-01	    101	        1	        500
3	            2024-01-03	    103	        2	        2400
7	            2024-01-07	    107	        3	        720
8	            2024-01-08	    108	        4	        900
12	            2024-01-12	    112	        5	        1200
13	            2024-01-13	    113	        6	        400
16	            2024-01-16	    116	        7	        720
17	            2024-01-17	    117	        8	        1500
19	            2024-01-19	    119	        9	        350
21	            2024-01-21	    121	        10      	1300
23	            2024-01-23	    123	        11      	800
24	            2024-01-24	    124	        12      	2200
25	            2024-01-25	    125	        13      	700
            

*/


Select o1.order_number,o1.order_date,o1.cust_id, o1.salesperson_id, o2.amount from int_orders o1
inner join int_orders o2
on o1.salesperson_id  = o2.salesperson_id 
group by o1.order_number,o1.order_date,o1.cust_id, o1.salesperson_id
having o1.amount >= max(o2.amount);
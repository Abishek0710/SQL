/*

A customer is considered retained in a given month if:

The customer placed at least one order in the current month AND also placed at least one order in the immediately previous month.

Important notes

Retention is calculated month over month

First month has no retention (no previous month to compare)

Multiple orders by the same customer in a month are counted only once

📦 Input Table

CREATE TABLE transactions (
    order_id INTEGER,
    cust_id INTEGER,
    order_date DATE,
    amount INTEGER
);

Input data:

order_id	cust_id	    order_date	    amount
1	            1	    2024-01-05	    500
2	            2	    2024-01-08	    300
3	            3	    2024-01-10	    700
4	            4	    2024-01-15	    400
5	            1	    2024-01-20	    200
6	            1	    2024-02-02	    600
7	            2	    2024-02-05	    450
8	            3	    2024-02-07	    800
9	            5	    2024-02-10	    300
10	            1	    2024-02-18	    150
11	            2	    2024-03-03	    500
12	            3	    2024-03-07	    900
13	            6	    2024-03-10	    400
14	            2	    2024-03-15	    250
15	            2	    2024-04-01	    700
16	            3	    2024-04-04	    600
17	            7	    2024-04-06	    350
18	            3	    2024-04-10	    200
19	            8	    2024-04-14	    450
20	            2	    2024-04-20	    100


Expected Output:

month_date	returning_customers
01	            0
02	            3
03	            2
04	            2

*/


SELECT

    STRFTIME('%m', this_month.order_date) AS month_date,

    COUNT(DISTINCT last_month.cust_id) AS returning_customers

FROM transactions AS this_month

LEFT JOIN transactions AS last_month

    ON this_month.cust_id = last_month.cust_id

    AND (

        (CAST(STRFTIME('%Y', this_month.order_date) AS INTEGER) - CAST(STRFTIME('%Y', last_month.order_date) AS INTEGER)) * 12 +

        (CAST(STRFTIME('%m', this_month.order_date) AS INTEGER) - CAST(STRFTIME('%m', last_month.order_date) AS INTEGER))

    ) = 1

GROUP BY STRFTIME('%m', this_month.order_date);


/*

You are given a stores sales table.

Each store reports sales quarter-wise

Every store is closed for exactly one quarter due to maintenance

Hence, for each store one quarter is missing

👉 Write an SQL query to find the missing quarter for each store.

🧱 Table Schema

CREATE TABLE stores (
    store   VARCHAR(10),
    quarter VARCHAR(10),
    amount  INT
); 


input data:

Store	Quarter	Amount
S1	    Q1	    1000
S1	    Q2	    1200
S1	    Q4	    1500
S2	    Q1	    900
S2	    Q3	    1100
S2	    Q4	    1300
S3	    Q1	    800
S3	    Q2	    900
S3	    Q3	    950
S4	    Q2	    1400
S4	    Q3	    1350
S4	    Q4	    1600
S5	    Q1	    2000
S5	    Q2	    1800
S5	    Q3	    1700

Expected Output
Store	q_no
S1	    Q3
S2	    Q2
S3	    Q4
S4	    Q1
S5	    Q4
*/

SELECT store,'Q' || (10 - SUM(CAST(SUBSTR(quarter, -1) AS INTEGER))) AS q_no
FROM stores
GROUP BY store;
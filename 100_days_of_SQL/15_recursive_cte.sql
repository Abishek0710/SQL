/*

You are given a table that contains sales periods for products, along with average daily sales.

Each row represents:

A product

A start date

An end date

Average daily sales during that period

📋 Input Table

CREATE TABLE sales 
( 
    product_id INT, 
    period_start DATE, 
    period_end DATE, 
    average_daily_sales INT 
);
🧠 Problem Requirement

For each product, calculate total sales per year.

⚠️ Important catch:

A single period may span multiple years

Sales must be split year-wise

You cannot simply do:

DATEDIFF(period_end, period_start) * average_daily_sales
That only works when the entire period is within one year ❌

Input:

product_id	period_start	period_end	average_daily_sales
1	        2019-01-25	    2019-02-28	    100
2	        2018-12-01	    2020-01-31	    10
3	        2019-01-01	    2020-01-31	    1
4	        2020-03-01	    2020-03-31	    50
5	        2020-11-15	    2021-02-15	    20
6	        2021-01-01	    2021-12-31	    5
7	        2017-06-10	    2017-06-20	    200
8	        2017-12-20	    2018-01-10	    75
9	        2018-05-01	    2019-04-30	    30
10	        2019-12-01	    2020-12-31	    12
11	        2020-01-10	    2020-01-20	    300
12	        2020-06-01	    2021-06-01	    25
13	        2021-11-01	    2022-02-28	    15
14	        2022-01-01	    2022-12-31	    40
15	        2022-09-01	    2023-03-31	    18
16	        2016-01-01	    2016-12-31	    8
17	        2016-11-15	    2017-02-15	    60
18	        2017-03-01	    2018-03-01	    22
19	        2018-07-01	    2018-07-31	    90
20	        2019-04-15	    2021-04-14	    14
21	        2021-08-01	    2021-08-15	    500
22	        2022-05-01	    2022-05-31	    110
23	        2020-02-28	    2020-03-01	    1000
24	        2019-06-01	    2019-06-30	    45
25	        2023-01-01	    2023-01-31	    70


Expected Output:
product_id	report_year	    total_amount
1	        2019	        3500
2	        2018	        310
2	        2019	        3650
2	        2020	        310
3	        2019	        365
3	        2020	        31
4	        2020	        1550
5	        2020	        940
5	        2021	        920
6	        2021	        1825
7	        2017	        2200
8	        2017	        900
8	        2018	        750
9	        2018	        7350
9	        2019	        3600
10	        2019	        372
10	        2020	        4392
11	        2020	        3300
12	        2020	        5350
12	        2021	        3800
13	        2021	        915
13	        2022	        885
14	        2022	        14600
15	        2022	        2196
15	        2023	        1620
16	        2016	        2928
17	        2016	        2820
17	        2017	        2760
18	        2017	        6732
18	        2018	        1320
19	        2018	        2790
20	        2019	        3654
20	        2020	        5124
20	        2021	        1456
21	        2021	        7500
22	        2022	        3410
23	        2020	        3000
24	        2019	        1350
25	        2023	        2170
*/





WITH RECURSIVE r_cte(dates, max_date) AS (

    SELECT MIN(period_start) AS dates, MAX(period_end) AS max_date  

    FROM sales



    UNION ALL



    SELECT DATE(dates, '+1 day'), max_date

    FROM r_cte

    WHERE dates < max_date

)



SELECT

    s.product_id,

    STRFTIME('%Y', r.dates) AS report_year,

    SUM(s.average_daily_sales) AS total_amount

FROM r_cte r

JOIN sales s

    ON r.dates BETWEEN s.period_start AND s.period_end

GROUP BY s.product_id, STRFTIME('%Y', r.dates)

ORDER BY s.product_id, STRFTIME('%Y', r.dates);
/*
The Pareto Principle (80/20 rule) states that 80% of outcomes often come from 20% of causes.

In retail analytics, this commonly translates to:

80% of total sales come from 20% of the products

You are given an orders table containing sales transactions for multiple products across several years.

🎯 Objective

Write a SQL query to identify the top 20% of products that cumulatively contribute to at least 80% of total sales.

📋 Table Structure

CREATE TABLE orders (
    order_id   VARCHAR(14),
    order_date DATE,
    product_id VARCHAR(15),
    sales      NUMERIC(9,4)
);



Input data:

order_id	        order_date	    product_id	        sales
CA-2020-152156	    2020-11-08	    FUR-BO-10001798	    261.96
CA-2020-152156	    2020-11-08	    FUR-CH-10000454	    731.94
CA-2020-138688	    2020-06-12	    OFF-LA-10000240	    14.62
US-2019-108966	    2019-10-11	    FUR-TA-10000577	    957.577
US-2019-108966	    2019-10-11	    OFF-ST-10000760	    22.368
CA-2018-115812	    2018-06-09	    FUR-FU-10001487	    48.86
CA-2018-115812	    2018-06-09	    OFF-AR-10002833	    7.28
CA-2018-115812	    2018-06-09	    TEC-PH-10002275	    907.152
CA-2018-115812	    2018-06-09	    OFF-BI-10003910	    18.504
CA-2018-115812	    2018-06-09	    OFF-AP-10002892	    114.9
CA-2018-115812	    2018-06-09	    FUR-TA-10001539	    1706.18
CA-2018-115812	    2018-06-09	    TEC-PH-10002033	    911.424
CA-2021-114412	    2021-04-15	    OFF-PA-10002365	    15.552
CA-2020-161389	    2020-12-05	    OFF-BI-10003656	    407.976
US-2019-118983	    2019-11-22	    OFF-AP-10002311	    68.81
US-2019-118983	    2019-11-22	    OFF-BI-10000756	    2.544
CA-2018-105893	    2018-11-11	    OFF-ST-10004186	    665.88
CA-2018-167164	    2018-05-13	    OFF-ST-10000107	    55.5
CA-2018-143336	    2018-08-27	    OFF-AR-10003056	    8.56
CA-2018-143336	    2018-08-27	    TEC-PH-10001949	    213.48


Expected Output

product_id	        product_sales	    running_sales	    total_sales
TEC-MA-10000822	    8159.95	            8159.95	            38149.87280000001
FUR-BO-10004834	    3083.43	            11243.38	        38149.87280000001
FUR-CH-10000454	    2683.7799999999997	13927.16	        38149.87280000001
FUR-TA-10000577	    2002.207	        15929.367	        38149.87280000001
FUR-CH-10004287	    1740.06	            17669.427	        38149.87280000001
FUR-TA-10001539	    1706.18	            19375.607	        38149.87280000001
FUR-BO-10002545	    1158.751	        20534.358	        38149.87280000001
OFF-AR-10002671	    1113.02	            21647.378	        38149.87280000001
TEC-PH-10004977	    1097.54	            22744.918	        38149.87280000001
FUR-CH-10004063	    1058.126	        23803.044	        38149.87280000001
TEC-PH-10002447	    1029.95	            24832.994000000002	38149.87280000001
TEC-PH-10004536	    944.93	            25777.924000000003	38149.87280000001
TEC-PH-10002033	    911.424	            26689.348	        38149.87280000001
TEC-PH-10002275	    907.152	            27596.5	            38149.87280000001
OFF-ST-10003656	    902.3059999999999	28498.806	        38149.87280000001
FUR-BO-10002613	    899.136	            29397.942	        38149.87280000001
OFF-AP-10001058	    839.43	            30237.372	        38149.87280000001
FUR-CH-10000513	    831.936	            31069.308	        38149.87280000001
FUR-TA-10001768	    787.53	            31856.838	        38149.87280000001
OFF-ST-10004186	    665.88	            32522.718	        38149.87280000001
FUR-TA-10004534	    617.7	            33140.418	        38149.87280000001
TEC-PH-10003273	    503.96	            33644.378	        38149.87280000001
TEC-AC-10004659	    408.744	            34053.121999999996	38149.87280000001
OFF-BI-10003656	    407.976	            34461.098	        38149.87280000001
FUR-CH-10004698	    396.802	            34857.9	            38149.87280000001
TEC-PH-10000215	    384.45	            35242.35	        38149.87280000001
TEC-PH-10000486	    371.168	            35613.518	        38149.87280000001
FUR-CH-10003817	    340.144	            35953.662	        38149.87280000001
TEC-AC-10000844	    339.96	            36293.621999999996	38149.87280000001
FUR-CH-10003968	    319.41	            36613.032	        38149.87280000001
FUR-CH-10000863	    301.96	            36914.992	        38149.87280000001
FUR-CH-10001146	    294.539	            37209.530999999995	38149.87280000001
OFF-ST-10000991	    275.928	            37485.458999999995	38149.87280000001
FUR-BO-10001798	    261.96	            37747.418999999994	38149.87280000001
OFF-ST-10002974	    243.992	            37991.41099999999	38149.87280000001

*/


with sales_of_products as
(select product_id, sum(sales) as product_sales
from orders
group by product_id
),
running_cal as
(select product_id, product_sales,
sum(product_sales) over(order by product_sales desc rows between unbounded preceding and 0 preceding) as running_sales,
0.8*sum(product_sales) over() as total_sales
from sales_of_products)

select * from running_cal where running_sales<=total_sales;
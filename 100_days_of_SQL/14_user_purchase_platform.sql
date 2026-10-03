/*

You are given a table spending that records user purchase history on an e-commerce platform.

Each record contains:

user_id – ID of the user

spend_date – Date of purchase

platform – Platform used (mobile or desktop)

amount – Amount spent

A user can make purchases from:

Mobile only

Desktop only

Both mobile and desktop on the same day

🔍 Task

Write an SQL query to find, for each spend_date, the following three metrics:

Mobile Only

Total number of users who purchased only on mobile

Total amount spent by those users

Desktop Only

Total number of users who purchased only on desktop

Total amount spent by those users

Both Platforms

Total number of users who purchased on both mobile and desktop

Total amount spent by those users (mobile + desktop)

⚠️ Important:

Every date must return exactly 3 rows: mobile_only, desktop_only, both

Even if a category has zero users, it must still appear

🧱 Table Definition

CREATE TABLE spending 
(
    user_id INT,
    spend_date DATE,
    platform VARCHAR(10),
    amount INT
);



Input Data:

user_id	spend_date	platform	amount
1	    2019-07-01	mobile	    100
1	    2019-07-01	desktop	    100
2	    2019-07-01	mobile	    150
3	    2019-07-01	desktop	    200
4	    2019-07-01	mobile	    50
4	    2019-07-01	desktop	    75
5	    2019-07-02	mobile	    100
6	    2019-07-02	desktop	    100
7	    2019-07-02	mobile	    80
7	    2019-07-02	desktop	    120
8	    2019-07-02	mobile	    60
9	    2019-07-03	desktop	    300
10	    2019-07-03	desktop	    200
11	    2019-07-03	mobile	    90
11	    2019-07-03	desktop	    110
12	    2019-07-03	mobile	    40
13	    2019-07-04	mobile	    70
14	    2019-07-04	mobile	    30
15	    2019-07-04	desktop	    90
15	    2019-07-04	mobile	    60
16	    2019-07-05	desktop	    200
17	    2019-07-05	desktop	    180
18	    2019-07-05	mobile	    120
18	    2019-07-05	desktop	    80


Expected result

spend_date	platform	total_amount	total_users
2019-07-01	mobile	        150	        1
2019-07-01	desktop	        200	        1
2019-07-01	both	        325	        2
2019-07-02	mobile	        160	        2
2019-07-02	desktop	        100	        1
2019-07-02	both	        200	        1
2019-07-03	mobile	        40	        1       
2019-07-03	desktop	        500	        2
2019-07-03	both	        200	        1
2019-07-04	mobile	        100	        2
2019-07-04	both	        150	        1
2019-07-05	desktop	        380	        2
2019-07-05	both	        200	        1

*/


with all_spend as (
    select spend_date, user_id, max(platform) as platform, sum(amount) as amount from spending
    group by spend_date, user_id having count(distinct platform) = 1 --- to get only one platform users
    union all
    select spend_date, user_id, 'both' as platform, sum(amount) as amount from spending
    group by spend_date, user_id having count(distinct platform) = 2 --- to get users who purchased on both platforms
    union all
    select distinct spend_date, null as user_id, 'both' as platform, 0 as amount from spending --- to get the dates where no user purchased on both platforms
)
select spend_date, platform, sum(amount) as total_amount, count(distinct user_id) as total_users
from all_spend
group by spend_date, platform
order by spend_date, platform desc

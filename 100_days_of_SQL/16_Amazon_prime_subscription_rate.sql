/*

You are given two tables:

Users table – contains user signup information

Events table – contains user activity history

Objective

👉 Find the fraction (ratio) of users who:

Accessed Amazon Music, and

Upgraded to Prime membership (event type = 'P') within 30 days of signing up

Important Notes

Consider only users who accessed Amazon Music

Prime purchase must happen within 30 days of the user’s join_date

Output should be a single value (conversion rate)

🗄️ Table Schemas

CREATE TABLE users (
    user_id INTEGER,
    name VARCHAR(20),
    join_date TEXT
);
 
CREATE TABLE events (
    user_id INTEGER,
    type VARCHAR(10),      -- 'M' = Amazon Music, 'P' = Prime, others = Pay, etc.
    access_date TEXT
);


Input data:

users table:
user_id	name	join_date
1	    Aman	2022-01-01
2	    Neha	2022-01-05
3	    Ravi	2022-01-10
4	    Pooja	2022-01-15
5	    Ankit	2022-01-20
6	    Kiran	2022-01-25
7	    Sonal	2022-02-01
8	    Deepak	2022-02-05
9	    Mehul	2022-02-10
10	    Isha	2022-02-15

Events table:
user_id	type	access_date
1	    Music	2022-01-03
2	    Music	2022-01-06
3	    Music	2022-01-12
4	    Music	2022-01-18
5	    Music	2022-01-22
6	    Music	2022-01-30
7	    Music	2022-02-02
1	    P	    2022-01-20
2	    P	    2022-02-20
3	    P	    2022-01-25
5	    P	    2022-03-01
6	    P	    2022-02-10
8	    P	    2022-02-20
9	    P	    2022-03-01

Expected Output:

total_users	users_within_30_days	percentage_within_30_days
7	                 3	                42.857142857142854


*/


select count(*) as total_users,
COUNT(DISTINCT CASE WHEN (julianday(e.access_date) - julianday(u.join_date)) <= 30  THEN u.user_id END) AS users_within_30_days,
1.0 * COUNT(DISTINCT CASE WHEN (julianday(e.access_date) - julianday(u.join_date)) <= 30 THEN u.user_id END)/ COUNT(DISTINCT u.user_id) * 100 AS percentage_within_30_days
from users u
left join events e on u.user_id = e.user_id and type = 'P' 
where u.user_id in(select user_id from events where type = 'Music');
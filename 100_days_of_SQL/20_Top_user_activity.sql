/*

You are given a table that tracks user activities.
Each activity has a start date and end date.

Important conditions:

Activities for a user do not overlap

A user can have one or multiple activities

If a user has only one activity → return that activity

If a user has multiple activities → return the second most recent activity

“Most recent” is determined by endDate

🗂 Table Schema

CREATE TABLE UserActivity (
    username    VARCHAR(20),
    activity    VARCHAR(20),
    startDate   DATE,
    endDate     DATE
);

Input data:

username	activity	startDate	endDate
Alice	    swimming	2022-02-12	2022-02-20
Alice	    dancing	    2022-02-21	2022-02-23
Alice	    travel	    2022-02-24	2022-02-28
Bob	        reading	    2022-01-01	2022-01-10
Charlie	    gaming	    2022-03-01	2022-03-05
Charlie	    cooking	    2022-03-06	2022-03-10
David	    gym	        2022-01-01	2022-01-05
David	    music	    2022-01-06	2022-01-10
David	    cycling	    2022-01-11	2022-01-20
David	    travel	    2022-01-21	2022-01-25
Eva	        yoga	    2022-04-01	2022-04-30
Frank	    study	    2022-05-01	2022-05-03
Frank	    work	    2022-05-04	2022-05-10
Grace	    art	        2022-06-01	2022-06-05
Grace	    dance	    2022-06-06	2022-06-10
Grace	    travel	    2022-06-11	2022-06-15
Henry	    coding	    2022-07-01	2022-07-20

Expected Output:

username	activity	startDate	endDate	    total_activities	rnk
Alice	    dancing	    2022-02-21	2022-02-23	    3	            2
Bob	        reading	    2022-01-01	2022-01-10	    1	            1
Charlie	    gaming	    2022-03-01	2022-03-05	    2	            2
David	    cycling	    2022-01-11	2022-01-20	    4	            2
Eva	        yoga	    2022-04-01	2022-04-30	    1	            1
Frank	    study	    2022-05-01	2022-05-03	    2	            2
Grace	    dance	    2022-06-06	2022-06-10	    3	            2
Henry	    coding	    2022-07-01	2022-07-20	    1	            1

*/

with daterange as(
Select *,
count(*) over(partition by username) as total_activities, 
rank()  over(partition by username order by startDate desc) as rnk 
from UserActivity)

select * from daterange
where total_activities =1 or rnk =2
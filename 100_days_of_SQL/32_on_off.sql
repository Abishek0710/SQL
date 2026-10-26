/*

You are given a system event table where the status of a system is checked every minute.

status = 'on' → system is active

status = 'off' → system is inactive

👉 Task

Write an SQL query to identify all login–logout sessions with:

Login time → when status turns on

Logout time → when status turns off

Active duration count → number of consecutive minutes system stayed on

📌 Rules to Observe

A new session starts when on appears after an off

Consecutive on events belong to same session

Each session ends at the next off

Count includes only on minutes

📋 Table Schema

CREATE TABLE event_status (
    event_time VARCHAR(10),
    status VARCHAR(10)
);

Input data:
event_time	status
10:01	    on
10:02	    on
10:03	    on
10:04	    off
10:05	    off
10:07	    on
10:08	    on
10:09	    on
10:10	    off
10:11	    on
10:12	    off
10:15	    off
10:16	    on
10:17	    on
10:18	    off
10:20	    on
10:21	    off
10:23	    off
10:24	    on


Expected Output
login	logout	on_count
10:01	10:05	4
10:07	10:10	3
10:11	10:15	2
10:16	10:18	2
10:20	10:23	2
10:24	10:24	0

*/

with cte as
(
select *, sum(case when status = 'on' and prev_status ='off' then 1 else 0 end) over (order by event_time) as group_key
from
(
Select *,
lag(status,1,status) over( order by event_time asc) as prev_status
from event_status
) as A
)

select min(event_time) as login, max(event_time) as logout, count(1)-1 as on_count
from cte 
group by group_key

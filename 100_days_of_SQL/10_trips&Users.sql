/*

You are given two tables:

Trips – contains trip information

Users – contains user details (clients and drivers)

Definitions:

A trip can have one of the following statuses:

completed

cancelled_by_driver

cancelled_by_client

A trip is valid only if both the client and the driver are NOT banned

The cancellation rate for a given day is:

cancellation rate = 
(cancelled trips with unbanned client & driver) 
/ 
(total trips with unbanned client & driver)
🎯 Task

Write a SQL query to find the cancellation rate for each day
📅 From 2013-10-01 to 2013-10-03

🧱 Table Structures (Given)

CREATE TABLE Trips (
    id INT,
    client_id INT,
    driver_id INT,
    city_id INT,
    status VARCHAR(50),
    request_at VARCHAR(50)
);
 
CREATE TABLE Users (
    users_id INT,
    banned VARCHAR(50),
    role VARCHAR(50)
);

Input:

Trips:
id	client_id	driver_id	city_id	    status	                request_at
1	    1	        10	       1	    completed	            2013-10-01
2	    2	        11	       1	    cancelled_by_driver	    2013-10-01
3	    3	        12	       6	    completed	            2013-10-01
4	    4	        13	       6	    cancelled_by_client	    2013-10-01
5	    1	        10	       1	    completed	            2013-10-02
6	    2	        11	       6	    completed	            2013-10-02
7	    3	        12	       6	    completed	            2013-10-02
8	    2	        12	       12	    completed	            2013-10-03
9	    3	        10	       12	    completed	            2013-10-03
10	    4	        13	       12	    cancelled_by_driver	    2013-10-03

Users:
users_id	banned	role
1	        No	    client
2	        Yes	    client
3	        No	    client
4	        No	    client
10	        No	    driver
11	        No	    driver
12	        No	    driver
13	        No	    driver


Expected Output:

request_at	    cancelled_trip_count	total_trips	    cancelled_percent
2013-10-01	    1	                        3	        33.33333333333333
2013-10-02	    0	                        2	        0
2013-10-03	    1	                        2	        50
*/


select request_at, 
count(case when status in ('cancelled_by_driver','cancelled_by_client') then 1 else Null end) as cancelled_trip_count,
count(1) as total_trips,
1.0*count(case when status in ('cancelled_by_driver','cancelled_by_client') then 1 else Null end)/count(1) * 100 as cancelled_percent
from trips t 
join users d on t.client_id = d.users_id
join users c on t.client_id = c.users_id
where d.banned = 'No' and c.banned = 'No'
group by request_at
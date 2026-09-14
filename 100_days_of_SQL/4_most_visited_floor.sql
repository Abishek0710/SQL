/*
A company allows only one entry per employee per day.
However, employees found a loophole:
they can enter multiple times using different email IDs.

You are given an entries table that logs:

employee name

address

email used

floor visited

resource used

🎯 Your task is to write an SQL query that returns:

For each person:

Total number of visits

Most visited floor

List of distinct resources used

🧱 Table Structure

CREATE TABLE entries ( 
    name VARCHAR(20),
    address VARCHAR(20),
    email VARCHAR(30),
    floor INT,
    resources VARCHAR(20)
);


Input data:
name	address	        email	    floor	   resources
A	    Delhi	    a1@gmail.com	 1	        CPU
A	    Delhi	    a2@gmail.com	 1	        Desktop
A	    Delhi	    a3@gmail.com	 2	        CPU
B	    Mumbai	    b1@gmail.com	 2	        Desktop
B	    Mumbai	    b2@gmail.com	 2	        Monitor
B	    Mumbai	    b3@gmail.com	 3	        Desktop
C	    Pune	    c1@gmail.com	 3	        CPU
C	    Pune	    c2@gmail.com	 3	        CPU
C	    Pune	    c3@gmail.com	 3	        Monitor
C	    Pune	    c4@gmail.com	 1	        Keyboard
D	    Chennai	    d1@gmail.com	 4	        Desktop
D	    Chennai	    d2@gmail.com	 4	        Desktop
E	    Bangalore	e1@gmail.com	 5	        CPU
E	    Bangalore	e2@gmail.com	 5	        CPU
E	    Bangalore	e3@gmail.com	 5	        Monitor
E	    Bangalore	e4@gmail.com	 2	        Desktop
E	    Bangalore	e5@gmail.com	 5	        CPU
F	    Hyderabad	f1@gmail.com	 1	        Mouse
F	    Hyderabad	f2@gmail.com	 1	        Keyboard
F	    Hyderabad	f3@gmail.com	 1	        CPU
F	    Hyderabad	f4@gmail.com	 2	        Desktop
F	    Hyderabad	f5@gmail.com	 1	        Monitor


Expected result:

name	most_visited_floor	total_visits	used_resources
A	            1	            3	            CPU,Desktop
B	            2	            3	            Desktop,Monitor
C	            3	            4	            CPU,Monitor,Keyboard
D	            4	            2	            Desktop
E	            5	            5	            CPU,Monitor,Desktop
F	            1	            5	            Mouse,Keyboard,CPU,Desktop,Monitor



    
*/


with most_visited as
(select name, floor, count(1) as times_visited from entries
group by name)
,
distinct_res as
(select distinct name, resources from entries )
,
used as
(select name, group_concat(resources, ',' ) as used_res from distinct_res group by name)

select m.name, m.floor as most_visited_floor, m.times_visited as total_visits , u.used_res as used_resources 
from most_visited as m
inner join used as u
on m.name = u.name




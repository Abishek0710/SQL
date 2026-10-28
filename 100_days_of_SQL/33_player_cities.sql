/*

You are given a table players_location that stores player names and the city they belong to.

👉 Task

Write an SQL query to pivot the data such that:

Each city becomes a separate column

Player names under each city are sorted alphabetically

Rows are aligned properly even if cities have different counts of players

📋 Table Schema

CREATE TABLE players_location (
    name VARCHAR(20),
    city VARCHAR(20)
);


Input data:

name	    city
Rahul	    Bangalore
Mayank	    Bangalore
Anuj	    Bangalore
Rohit	    Mumbai
Sachin	    Mumbai
Surya	    Mumbai
Ishan	    Mumbai
Virat	    Delhi
Pant	    Delhi
Shaw	    Delhi
Dhoni	    Ranchi
Jadeja	    Ranchi
Gill	    Chandigarh
Arshdeep	Chandigarh
Hardik	    Baroda
KL Rahul	Bangalore
Pujara	    Rajkot
Ashwin	    Chennai
Gaikwad	    Pune


Expected Output:
Bangalore	    Mumbai	    Delhi
Anuj	        Ishan	    Pant
KL Rahul	    Rohit	    Shaw
Mayank	        Sachin	    Virat
Rahul	        Surya	    null
*/


select 
max(case when city = 'Bangalore' then name end) as Bangalore,
max(case when city = 'Mumbai' then name end) as Mumbai,
max(case when city = 'Delhi' then name end) as Delhi
from(
Select *,
rank() over(partition by city order by name asc) as group_key
from players_location
)
group by group_key
;
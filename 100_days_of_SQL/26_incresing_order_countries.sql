/*
You are given a table that stores daily Covid cases city-wise.

Each row represents:

a city

a date

the number of Covid cases on that date

👉 Task
Write a SQL query to find cities where Covid cases are increasing continuously every day.

✅ Rules

The number of cases must strictly increase day-by-day

Even a single decrease or same value breaks the sequence

The logic should work dynamically for any number of days per city

🧱 Table Schema

CREATE TABLE covid (
    city VARCHAR(50),
    days DATE,
    cases INT
);


Input data:
city	    days	        cases
Delhi	    2020-01-01	    100
Delhi	    2020-01-02	    200
Delhi	    2020-01-03	    300
Mumbai	    2020-01-01	    100
Mumbai	    2020-01-02	    100
Mumbai	    2020-01-03	    120
Chennai	    2020-01-01	    100
Chennai	    2020-01-02	    150
Chennai	    2020-01-03	    140
Bangalore	2020-01-01	    100
Bangalore	2020-01-02	    120
Bangalore	2020-01-03	    110
Bangalore	2020-01-04	    130
Pune	    2020-01-01	    50
Pune	    2020-01-02	    75
Pune	    2020-01-03	    120
Pune	    2020-01-04	    180
Kolkata	    2020-01-01	    90
Kolkata	    2020-01-02	    90
Kolkata	    2020-01-03	    95
BANGALORE	2022-01-01	    100
BANGALORE	2022-01-02	    300
BANGALORE	2022-01-03	    200
BANGALORE	2022-01-04	    400




Expected Output:
city
Delhi
Pune


*/




with ranking as
(Select *,
rank() over(partition by city order by days) as rnk_days,
rank() over(partition by city order by cases) as rnk_cases,
rank() over(partition by city order by days) - rank() over(partition by city order by cases) as diff
from covid
)


select city from ranking
group by city 
having count(distinct diff) = 1 and avg(diff) = 0;
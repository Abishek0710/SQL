/*
You are given an employee table containing employee details across multiple departments.

🎯 Objective

Write an SQL query to:

Return employee details with the 3rd highest salary in each department

If a department has fewer than 3 employees, return the employee with the lowest salary in that department

📋 Input Table Structure

CREATE TABLE emp (
    emp_id INTEGER,
    emp_name TEXT,
    salary INTEGER,
    manager_id INTEGER,
    emp_age INTEGER,
    dep_id INTEGER,
    dep_name TEXT,
    gender TEXT
);


Input data:
emp_id	emp_name	salary	manager_id	emp_age	dep_id	dep_name	gender
1	    Ankit	    14300	    4	        39	100	    Analytics	Female
2	    Mohit	    14000	    5	        48	200	    IT	        Male
3	    Vikas	    12100	    4	        37	100	    Analytics	Female
4	    Rohit	    7260	    2	        16	100	    Analytics	Female
5	    Mudit	    15000	    6	        55	200	    IT	        Male
6	    Agam	    15600	    2	        14	200	    IT	        Male
7	    Sanjay	    12000	    2	        13	200	    IT	        Male
8	    Ashish	    7200	    2	        12	200	    IT	        Male
9	    Mukesh	    7000	    6	        51	300	    HR	        Male
10	    Rakesh	    8000	    6	        50	300	    HR	        Male
11	    Akhil	    4000	    1	        31	500	    Ops	        Male


Expected Output:
emp_id	emp_name	salary	dep_id	dep_name	rn	cnt
4	    Rohit	    7260	100	    Analytics	3	3
2	    Mohit	    14000	200	    IT	        3	5
9	    Mukesh	    7000	300	    HR	        2	2
11	    Akhil	    4000	500	    Ops	        1   1

*/

select * from 
(
Select *,
rank() over(partition by dep_id order by salary desc) as rn,
count(*) over(partition by dep_id) as cnt
from emp)
where rn = 3 or (rn<3 and rn=cnt)
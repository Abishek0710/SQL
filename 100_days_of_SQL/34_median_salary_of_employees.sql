/*

You are given an employee table that stores employee salary information across multiple companies.

👉 Definition of Median

If the number of employees in a company is odd, the median is the middle salary after sorting.

If the number of employees is even, the median is the average of the two middle salaries.

🎯 Objective

Write an SQL query to find the median salary for each company.

📋 Table Schema

CREATE TABLE employee (
    emp_id INTEGER,
    company TEXT,
    salary INTEGER
);

Input data:
emp_id	company	    salary
1	        A	    2341
2	        A	    341
3	        A	    15
4	        A	    15314
5	        A	    451
6	        A	    513
7	        B	    15
8	        B	    13
9	        B	    1154
10	        B	    1345
11	        B	    1221
12	        B	    234
13	        C	    2345
14	        C	    2645
15	        C	    2645
16	        C	    2652
17	        C	    65

Expected Output:
company	median_salary
A	        482
B	        694
C	        2645

*/


select company, avg(salary) as median_salary
from(
Select *,
row_number() over(partition by company order by salary asc) as rn,
count(*) over(partition by company) as total_count
from employee 
)
where rn between total_count*1.0/2 and total_count*1.0/2 + 1
group by company
;
/*
You are given an emp table that stores employee details including salary.

Task:
Write SQL queries to calculate the median salary of employees.

You must:

Handle both odd and even number of records

Solve it using:

Method 1: Generic SQL (works in all databases)

Method 2: PERCENTILE_CONT() (database-specific)

👉 Assume no built-in MEDIAN function exists.

🧱 Table Structure (Given)

CREATE TABLE emp
(
    emp_id INT,
    emp_name VARCHAR(20),
    department_id INT,
    salary INT,
    manager_id INT,
    emp_age INT
);


Input data:

emp_id	emp_name	department_id	salary	manager_id	emp_age
1	    Amit	        10	        25000	    101	       25
2	    Rohit	        10	        30000	    101	       26
3	    Sumit	        10	        28000	    101	       27
4	    Neha	        20	        35000	    102	       28
5	    Pooja	        20	        40000	    102	       29
6	    Karan	        20	        42000	    102	       30
7	    Rahul	        30	        18000	    103	       24
8	    Ankit	        30	        20000	    103	       25
9	    Riya	        30	        22000	    103	       26
10	    Mehul	        40	        60000	    104	       35
11	    Sonal	        40	        62000	    104	       36
12	    Nitin	        40	        65000	    104	       37
13	    Kriti	        50	        48000	    105	       32
14	    Vikas	        50	        50000	    105	       33
15	    Deepak	        50	        52000	    105	       34
16	    Arjun	        60	        70000	    106	       40
17	    Sneha	        60	        72000	    106	       41
18	    Manish	        60	        74000	    106	       42
19	    Isha	        70	        26000	    107	       27
20	    Tina	        70	        28000	    107	       28
21	    Raj	            70	        30000	    107	       29
22	    Naveen	        80	        36000	    108	       31
23	    Payal	        80	        38000	    108	       32
24      Suresh	        80	        40000	    108	       33
25	    Mohit	        90	        45000	    109	       34


Expected Output:

department_id	median_salary
10	            28000
20	            40000
30	            20000
40	            62000
50	            50000
60	            72000
70	            28000
80	            38000
90	            45000

*/



WITH ordered_salaries AS (
  SELECT 
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary) AS rn,
    COUNT(*) OVER (PARTITION BY department_id) AS cnt
  FROM emp
)
SELECT 
    department_id,
    AVG(salary) AS median_salary
FROM ordered_salaries
WHERE rn IN ( (cnt + 1) / 2, (cnt + 2) / 2 )   
GROUP BY department_id



/*

You are given an employee table where:

Each employee has a manager_id

manager_id refers to emp_id of the same table

👉 Write a SQL query to find employees whose salary is greater than their manager’s salary.

This is a self join scenario because:

One column (manager_id) references another column (emp_id) of the same table

🧱 Table Structure

CREATE TABLE emp
(
   emp_id INT,
   emp_name VARCHAR(10),
   salary INT,
   manager_id INT
);

Input:
emp_id	emp_name	salary	manager_id
1	    Ankit	    60000	    10
2	    Rahul	    75000	    10
3	    Amit	    50000	    10
4	    Neha	    82000	    11
5	    Priya	    90000	    11
6	    Ravi	    45000	    12
7	    Sunil	    65000	    12
8	    Karan	    72000	    13
9	    Vikas	    68000	    13
10	    Rohit	    70000	    15
11	    Mohit	    85000	    15
12	    Suresh	    60000	    16
13	    Deepak	    75000	    16
14	    Pooja	    78000	    16
15	    Aakash	    80000	    18
16	    Nitin	    70000	    18
17	    Ritika	    88000	    18
18	    Sanjay	    90000	    null
19	    Divya	    65000	    18
20	    Manish	    95000	    18

Expected Output

emp_id	emp_name	manager_name	salary	manager_salary
2	    Rahul	        Rohit	     75000	    70000
5	    Priya	        Mohit	     90000	    85000
7	    Sunil	        Suresh	     65000	    60000
11	    Mohit	        Aakash	     85000	    80000
13	    Deepak	        Nitin	     75000	    70000
14	    Pooja	        Nitin	     78000	    70000
20	    Manish	        Sanjay	     95000	    90000
*/


select e.emp_id, e.emp_name, m.emp_name as manager_name, e.salary, m.salary as manager_salary 
from emp as e
inner join emp as m on e.manager_id = m.emp_id
where e.salary > m.salary;
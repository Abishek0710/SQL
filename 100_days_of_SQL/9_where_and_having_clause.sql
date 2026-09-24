/*
You are given an employee table containing employee salary information.

Answer the following:

Using WHERE clause
→ Fetch all employees whose salary is greater than 5000

Using HAVING clause
→ Fetch those manager_id for which the average salary of employees reporting to that manager is greater than 10,000

Explain why WHERE works in case 1 and HAVING is required in case 2.

🧱 Table Structure (Given)

CREATE TABLE emp
(
    emp_id INT,
    emp_name TEXT,
    salary INT,
    manager_id INT
);


Input data:
emp_id	emp_name	salary	    manager_id
1	    Amit	    5000	    100
2	    Rohit	    7000	    100
3	    Neha	    12000	    100
4	    Pooja	    15000	    100
5	    Rahul	    8000	    200
6	    Ankit	    9000	    200
7	    Karan	    9500	    200
8	    Nitin	    10000	    200
9	    Suman	    20000	    300
10	    Rakesh	    18000	    300
11	    Priya	    22000	    300
12	    Sneha	    24000	    300
13	    Deepak	    6000	    400
14	    Vikas	    6500	    400
15	    Sonu	    7000	    400
16	    Monu	    7500	    400
17	    Ishita	    16000	    500
18	    Akash	    17000	    500
19	    Meena	    18000	    500
20	    Nikhil	    19000	    500
21	    Kriti	    4000	    600
22	    Sahil	    4500	    600
23	    Yash	    4800	    600
24	    Komal	    5000	    600

Expected Output

manager_id	    avg_salary
100	            11333.333333333334
300	            21000
500	            17500


*/


select m.manager_id as manager_id, avg(e.salary) as avg_salary from emp e
inner join emp m on e.emp_id = m.emp_id
where e.salary > 5000
group by 1
having avg(e.salary) > 10000;
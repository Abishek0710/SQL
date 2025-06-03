use namastesql;


# WIndow function with Aggregation


select * from orders;



with dep as
( select dept_id, avg(salary) as avg_dep_salary
from employee
group by dept_id) 
select e.* , d.avg_dep_salary 
from employee e
inner join dep d
where e.dept_id = d.dept_id;

# the above query can be done easily using window function without making use of sub queries

select *,
avg(salary) over(partition by dept_id ) as avg_salary # when using window function along with aggregation order by is not mandatory
from employee
where dept_id =100;
# when we use order by we get different results

select *,
count(salary) over(partition by dept_id ) as avg_salary # when using window function along with aggregation order by is not mandatory
from employee
where dept_id =100;


select *,
sum(salary) over(partition by dept_id ) as avg_salary # when using window function along with aggregation order by is not mandatory
from employee
where dept_id =100;


# when we use order by it will give running aggregation
select *,
sum(salary) over(partition by dept_id order by emp_id ) as running_sum # when using window function along with aggregation order by is not mandatory
from employee;

select *,
avg(salary) over(partition by dept_id order by emp_id ) as running_avg # when using window function along with aggregation order by is not mandatory
from employee;


select *,
sum(salary) over(partition by dept_id order by salary desc) as runningsalary
from employee;
# here we can see some difference if we use any order by column which is having duplicates
# if there is any records that have duplicates in order by col it will consider that as one and gives the result
# whenever we have a order by with aggregation in window function we can consider it will give running aggregation


select *,
sum(salary) over(order by salary desc) as runningsalary
from employee;

# Always use unique column fro order by while doing aggregation with window function


# ROLLING AGGREGATION

select *,
sum(salary) over(order by emp_id rows between 2 preceding and current row) as rolling_salary
from employee;

#rows between 2 preceding and current row - this gives sum of previous 2 rows and current row other rows are not considered


select *,
sum(salary) over(order by emp_id rows between 1 preceding and 1 following) as rolling_salary
from employee;

#rows between 1 preceding and 1 following - sum of rows between 1 previous and 1 next row


select *,
sum(salary) over(order by emp_id rows between 5 following and 10 following) as rolling_salary
from employee;

#rows between 5 following and 10 following - sum between 5th row from cureent row and 10 th row from current row


select *,
sum(salary) over(partition by dept_id order by emp_id rows between 1 preceding and 1 following) as rolling_salary
from employee;


# unbounded

select *,
sum(salary ) over(order by emp_id) as running_sum,
sum(salary) over(order by emp_id rows between unbounded preceding and current row) as rolling_sum
from employee;
# both of the expressions are same

select *,
sum(salary ) over(order by emp_id) as running_sum,
sum(salary) over(order by emp_id rows between unbounded preceding and unbounded following) as total_salary_sum
from employee;



select *, 
sum(salary) over(partition by dept_id order by emp_id rows between unbounded preceding and current row) as rolling_sum
from employee;


# first_value and last_value function

select *,
first_value(salary) over(partition by dept_id order by salary) as first_val,
last_value(salary) over(partition by dept_id order by salary) as last_val
from employee;

# first and last will compare with next rows and if it is greater or small it will display that
# this wiork based on comparing row by row


select *,
first_value(salary) over(partition by dept_id order by salary asc) as first_val,
first_value(salary) over(partition by dept_id order by salary desc) as last_val
from employee;


select *,
first_value(salary) over(partition by dept_id order by salary asc) as first_val,
first_value(salary) over(partition by dept_id order by salary desc) as last_val,
last_value(salary) over(partition by dept_id order by salary rows between unbounded preceding and unbounded following) as last_rolling_val
from employee;


select order_id, sales,
sum(sales) over(order by order_id) as running_sales,
sum(sales) over(order by order_id rows between unbounded preceding and current row) as rolling_sales,
sum(sales) over(order by order_id, row_id) as run_sales 
from orders;






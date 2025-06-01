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













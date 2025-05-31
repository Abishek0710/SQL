 
#Window functions

use namastesql;

#query to print, emppname, salary and dep id of highest salaried employee in each department

select * from employee;

# row number function

with cte as (
select * ,
row_number() over(partition by dept_id order by salary desc) as rn # generates row number based on salary desc
from employee) 
select emp_name, dept_id, salary from cte
where rn <=1;



# Rank function
select *,
row_number() over(order by salary desc),
rank() over(order by salary desc) 
from employee; 



# dense rank function

select * ,
rank() over( order by salary desc) as rnk, # generates row number based on salary desc
dense_rank() over(order by salary desc) as denserank
from employee;


# fetch the top 5 selling products on each category in orders tbl

with categ_product_sales as 
(
select product_id, category, sum(sales) as total_sales
from orders
group by product_id, category)

,rank_sales as 
(select *,
dense_rank() over(partition by  category order by total_sales desc) as rnk
from  categ_product_sales)
select * from rank_sales
where rnk<=5;


# lead function

select *,
lead(salary,2, salary) over(order by salary asc) as lead_emp # it gives the salary of 2nd next row
from employee;

# lead(salary,2, salary) fetch the salary of 2nd next row if there is no row then takes the salary itself


select *,
lead(salary,1) over(partition by dept_id order by salary asc) as lead_emp 
from employee;


#Lag function
# lag is similar to lead but in lag it fetches previous values

select *,
lag(salary,1) over(partition by dept_id order by salary desc) as lag_emp,
lead(salary,1) over(partition by dept_id order by salary desc) as lead_emp 
from employee;


select *,
lag(salary,1, 1) over(partition by dept_id order by salary desc) as lag_emp,
lead(salary,1,1) over(partition by dept_id order by salary desc) as lead_emp 
from employee;


# first value function
# it gives the first value of the partition
select *,
first_value(salary) over(partition by dept_id order by salary desc) as first_val
from employee;



select *,
last_value(salary) over(partition by dept_id order by salary asc) as first_val
from employee;

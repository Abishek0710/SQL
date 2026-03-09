 
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


# Rank function
select *,
row_number() over(partition by dept_id  order by salary desc) as rownumber_fn,
rank() over(partition by dept_id  order by salary desc)  as Rank_fn

from employee; 


# dense rank function

select * ,
rank() over( order by salary desc) as rnk, # generates row number based on salary desc
dense_rank() over(order by salary desc) as denserank
from employee;

select *,
row_number() over(partition by dept_id  order by salary desc) as rownumber_fn,
rank() over(partition by dept_id  order by salary desc)  as Rank_fn,
dense_rank() over(partition by dept_id  order by salary desc) as denserank
from employee; 


# Row_number  --  No duplicates in the numbering, even if values are the same
# Rank        --  Skips the next ranks if there's a tie, Also assigns same rank to ties
# dense_rank  --  Does NOT skip the next rank, Also assigns same rank to ties


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




#---------------------------------------------------------------------------------------------------------------------------------------


# Window functions

select * from employee;

# We need top 2 employee from each dept baes on salary

#select dept_id, max(salary) from employee
#group by dept_id

select *, row_number() over(order by salary desc) as rn
from employee;  # this creates a column rn with row number on the order of salary


select *, row_number() over(partition by dept_id order by salary desc, emp_name asc) as rn
from employee;  # this creates a column rn with row number on the order of salary with a window of dept_id
# eacch dept is a window here and eaach window will hve its own row number


# We need top 2 employee from each dept baes on salary

select * from 
( select * , row_number() over( partition by dept_id order by salary desc, emp_name asc) as rn
from employee) as A
where rn <= 2;

# get the 3rd highest salaried employee

select * from 
( select * , row_number() over(order by salary desc, emp_name asc) as rn
from employee) as A
where rn = 3;


select *, 
row_number() over(partition by dept_id order by salary) as rn, 		# wont allow duplicate row number
rank() over(partition by dept_id order by salary) as rnk, 	   		# allows duplicates and skips the next rank
dense_rank() over(partition by dept_id order by salary) as d_rnk	# allows duplicates but does not skips the next rank
from employee;


select *,
rank() over(partition by dept_id order by salary desc, emp_age asc) as rnk, 	   		
dense_rank() over(partition by dept_id order by salary desc,emp_age asc) as d_rnk
from employee;



select * from orders;

# top 5 selling products in each category

select * from
(select category, product_id, product_name, sales ,
dense_rank() over(partition by category order by sales) as d_rnk
from orders) as A
where d_rnk <=5;

# the above is wrong because we need to group by based on product to find the total sales and then on top of that we have to create window
# row number, rank, dense rank works only on row level by its own it wont do any aggregation

# step1 -> find sum of sales in each product in category
# step2 -> apply rank function to provide rank for highest sold product based on sum of sales
# step3 -> find the top sold product in each category

with cat_sales as
(select category, product_id, sum(sales) as total_sales
from orders
group by category, product_id)
,rnk_sales as
(select *,
rank() over(partition by category order by total_sales desc) as rnk
from cat_sales)
select * from rnk_sales where rnk<=5;

# alternative approach

select * from 
(select category, product_id,
rank() over(partition by  category order by sum(sales) desc) as rnk
from orders
group by category, product_id) as a
where rnk<=5;



# LEAD function

select emp_id, salary,
lead(emp_id,1) over(order by salary desc) as lead_emp_id
from employee;  # it gives the next value of the column specified in lead function
# here lead(emp_id,1) is it gives next value of emp_id if 2 it skpis 2 rows and displays next row

select emp_id, salary,
lead(emp_id,2) over(order by salary desc) as lead_emp_id
from employee; 

select emp_id, salary,dept_id,
lead(emp_id,1) over(partition by dept_id order by salary desc) as lead_emp_id
from employee; 


select emp_id, salary,dept_id,emp_age,
lead(emp_id,1,emp_age) over(partition by dept_id order by salary desc) as lead_emp_id
from employee; 
# lead(emp_id,1,emp_age) here lead_emp_id displays the next row value of emp_id if there is no next row it fills the row with emp_age value of same row

# LAG function


# LAG is opposite is lead it takes previous value instead of next value
select emp_id, dept_id, salary, emp_age,
lag(emp_id,1) over(partition by dept_id order by salary asc) as lag_emp_id
from employee;




/*
#Questions

1- write a query to print 3rd highest salaried employee details for each department (give preferece to younger employee in case of a tie). 
In case a department has less than 3 employees then print the details of highest salaried employee in that department.

2- write a query to find top 3 and bottom 3 products by sales in each region.

3- Among all the sub categories..which sub category had highest month over month growth by sales in Jan 2020.

4- write a query to print top 3 products in each category by year over year sales growth in year 2020.

5- create below 2 tables 

create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;

write a query to get start time and end time of each call from above 2 tables.Also create a column of call duration in minutes.  Please do take into account that
there will be multiple calls from one phone number and each entry in start table has a corresponding entry in end table.





6-https://www.namastesql.com/coding-problem/64-penultimate-order

7-https://www.namastesql.com/coding-problem/26-dynamic-pricing

8-https://www.namastesql.com/coding-problem/76-amazon-notifications */


/*
1- write a query to print 3rd highest salaried employee details for each department (give preferece to younger employee in case of a tie). 
In case a department has less than 3 employees then print the details of highest salaried employee in that department.*/

select * from 
(select *,
rank() over(partition by dept_id order by salary desc, emp_age asc) as rnk,
count(*) over(partition by dept_id order by salary desc) as dept_count
from employee) as A
WHERE (dept_count > 3 AND rnk = 3)
  OR (dept_count < 3 AND rnk = 1);

select * from orders;


#2- write a query to find top 3 and bottom 3 products by sales in each region.

select * from 
(select region, product_id, sum(sales) total_sales,
 rank() over (partition by region order by sum(sales) desc) as sale_rnk_desc,
 rank() over(partition by region order by sum(sales) asc) as sale_rnk_asc
 from orders
 group by region,product_id) as A
 where sale_rnk_desc <=3 or sale_rnk_asc <=3
 order by region,total_sales desc;


# 3- Among all the sub categories..which sub category had highest month over month growth by sales in Jan 2020.

select sub_category, year(order_date) as order_year, month(order_date) as order_month,  sum(sales) as tsales
from orders
group by sub_category, year(order_date), month(order_date)
order by sub_category, order_year, order_month, tsales desc




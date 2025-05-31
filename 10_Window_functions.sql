 
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



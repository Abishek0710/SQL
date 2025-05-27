use namastesql;

select * from employee;
select * from dept;



# Group_Concat
# This function concatenates strings from multiple rows into a single string, often used with GROUP BY 

select dept_id, group_concat(emp_name order by emp_name desc) as concat_name
from employee
group by dept_id;



# Date Functions
# year(date column) gives the year part
select order_id, order_date, year(order_date) as year 
from orders
where year(order_date) = 2020;


# year(date column) gives the year part
select order_id, order_date, month(order_date) as month , dayofweek( order_date) as week, dayofyear(order_date) as yearday, day( order_date) as day
from orders
where year(order_date) = 2020;


select order_date,  dayname(order_date)as day, monthname(order_date) as monthname 
from orders;


# Adding days, month or week to a date column
select order_id, order_date, 
date_add(order_date, interval 5 day) as order_date_add_5, 
date_add(order_date, interval -1 month) as order_date_sub_month,
date_add(order_date, interval -1 week) as order_date_sub_week
from orders;



select order_id, order_date, ship_date,
datediff(order_date,ship_date) as date_diff
from orders;


# differnce between two dates
select order_id, order_date, ship_date,
datediff(order_date,ship_date) as date_diff
from orders;


# difference between dates
# we can use month, day and year in this ffunction
select order_id, order_date, ship_date,
timestampdiff(day,order_date,ship_date) as month_diff
from orders 
order by month_diff desc;



# Case statement 
#syntax
#case -> when  then -> when then -> else -> end
select order_id, profit,
case
when profit < 100 then 'Low profit'
when profit >100 and profit < 250 then 'Moderate profit'
when profit > 250 and profit < 500 then 'High profit'
else 'Very High profit'
end as profit_category
from orders






use namastesql;

select * from orders ;

#updating some columns null
set sql_safe_updates = 0;
update orders
set city = null
where order_id in ('CA-2020-161389', 'US-2020-108504');


# fettching null records in city
select * from orders
where city is null; # we cannot use city = null because we cannot compare using null, null is unknown value;



# Aggregation

#count query
select count(*) from orders;

# sum of a column, min of a column, max of a column, average of a column
select count(*) as tot_count, 
sum(profit) as total_profit,
min(profit) as min_profit, 
max(profit) as max_profit, 
avg(profit) as avg_profit 
from orders; # here we are getting total values
# if we want all these values based on columns we use group by


# Group By
# we want count, min, max , sum, average all for each state we use group by
# so that all these values groups based on some column
select  state, count(*) as tot_count, 
sum(profit) as total_profit,
min(profit) as min_profit, 
max(profit) as max_profit, 
avg(profit) as avg_profit 
from orders 
group by state; 
# in group by we will use column that are not aggregated
# usually group by column are categorical columns


# we can group based on combinations as well
select region,category, sum(sales) as tot_sales
from orders
group by region, category;


# interview qn
select region,category, sum(sales) as tot_sales
from orders
group by region; # this will give error as we should include columns that are used in select in group by
# we have 2 non aggregated columns here so we need to include those two in group by else we will get error.


# interview qn
select region,category, sum(sales) as tot_sales
from orders
group by region, category,tot_sales; 
# this will also give error as we cannot group on aggregated column


select region,category, sum(sales) as tot_sales
from orders
where profit>50
group by region, category;


select region,category, sum(sales) as tot_sales
from orders
where profit>50
group by region, category
order by tot_sales desc 
limit 5;


# consider we want total sales based on each sub category where profit is greater than 50 and sum(sales) should be greater than 10000
select region,category, sum(sales) as tot_sales
from orders
where profit>50
group by region, category # in group by we will use column that are not aggregated
having sum(sales) > 10000 # in having we can use aggregated fn or column in select
order by tot_sales desc;
# In having we will use mostly aggregated column 
# order of execution for the above query is FROM  --> WHERE --> GROUP BY --> HAVING -->	SELECT --> ORDER BY
# so aggregated columns cannot be used in where clause so we use aggregated columns in having
# Having and group by both are filter methods but the order of execution is different


select region,category, sum(sales) as tot_sales
from orders
where profit>50 and sum(sales) > 10000
group by region, category 
order by tot_sales desc; # This will give error as we cannot use aggregated column in where



select sub_category, sum(sales) as total_sales
from orders
where order_date > '2020-01-01'
group by sub_category
order by total_sales desc;


select sub_category, sum(sales) as total_sales
from orders
where order_date > '2020-01-01'
group by sub_category
having sum(sales) > 10000
order by total_sales desc;
# Here only sub categories with sum(sales) > 10000 is displayed


# fetching count of all records in a table
select count(*) from orders;

select count(city) from orders; # if there is any null in city column it is not counted


select  city, avg(sales) as average_sales 
from orders
group by city 
order by average_sales desc;
# average(sales) = total sales in the city/ total no of records in that city 
# if there is any null value in any record of city it is not included in total number of records


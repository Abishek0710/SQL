#select and where

use namastesql;

# Renaming table
Rename table namastesql.superstore_orders to namastesql.orders;


select * from orders limit 5;

# limiting select by 5
select * from orders 
order by order_date desc 
limit 5;


# selecting distinct values in columns
select distinct  ship_mode, segment from orders;


# selecting distinct rows which are not duplicated from entire table
select distinct * from orders;


# filtering only the first class records using where clause
select * from orders 
where ship_mode = 'First Class';


# filtering based on date column
select * from orders 
where Order_Date = '11/8/2020';


# filtering based on quantity greater than 5
select Customer_ID, quantity  from orders 
where quantity >= 5 
order by quantity desc 
limit 5;


# For numerical, float and date columns we can use operators
select distinct * from orders 
where order_date > '5/13/2018' 
order by order_date desc;


# filtering based on between condition
select * from orders 
where order_date between '9/25/2018' and '9/7/2020';


select * from orders 
where quantity between 3 and 10 
order by quantity desc;


# filtering with in condition
select customer_id, ship_mode from orders 
where ship_mode in ('First Class','Standard Class');  # will display records only with first and standard class


select customer_id, ship_mode,quantity from orders 
where quantity in (3,8) order by quantity desc;


# filtering with not in
select customer_id, ship_mode,quantity from orders 
where quantity not in (3,8) order by quantity desc; # this will display records other than 3 and 8


# while filterng a string column with opertors it will compare using ASCII value
select distinct ship_mode from orders 
where ship_mode > 'First Class';


# filtering based on multiple conditions with and operator
select customer_id, ship_mode,quantity, segment from orders 
where ship_mode = 'First Class' and segment = 'Consumer';


# filtering using or operator
select customer_id, ship_mode,quantity, segment from orders 
where ship_mode = 'First Class' or segment = 'Consumer';
# or filter will increase data wheareas and filter decreases data


select * from orders;


# creating new columns and giving alias
select segment, profit, sales, profit/sales as ratio from orders
where segment = 'Corporate' order by 4 desc; # 4 is fourth column


select segment, profit, sales, quantity, sales * quantity as Total from orders
where segment = 'Corporate' order by 5 desc; # 5 is fourth column


# getting current date 
select segment, profit, sales, quantity, current_date() as current_Dte from orders;


# pattern matching using like operator


#fetching records where product id column contains FUR 
select order_id, ship_date, product_id, product_name from orders
where product_id like '%FUR%';


#fetching records where customer name starts with C
select order_id, ship_date, customer_name, product_id, product_name from orders
where customer_name like 'C%';


#fetching records where customer name ends with e
select order_id, ship_date, customer_name, product_id, product_name from orders
where customer_name like '%e';


#fetching records where customer name starts with C and ends with e inbetween can be anything
select order_id, ship_date, customer_name, product_id, product_name from orders
where customer_name like 'C%e' or customer_name like 'S%t';


# fetching records where customer name starts with C and ends with e inbetween can be anything
# when we dont want to worry about case sensitivity we use upper or lower
select order_id, ship_date, customer_name, product_id, product_name from orders
where lower(customer_name) like 'c%e' or lower(customer_name) like 's%t';


# fetching records where customer name starts with any character but second character is 'l' and ends with any chaaracter
select order_id, ship_date, customer_name, product_id, product_name from orders
where lower(customer_name) like '_l%';


# fetching records where customer name starts with any character but third character is 'l' and fifth character is 'e' and ends 'n'
select order_id, ship_date, customer_name, product_id, product_name from orders
where lower(customer_name) like '__l_e%n';


select order_id, ship_date, customer_name, product_id, product_name from orders
where lower(customer_name) like 'cl%' or lower(customer_name) like 'cy%' ;
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




#Questions



#1- write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character (58 rows)
select * from orders where customer_name like '_a_d%';

#2- write a sql to get all the orders placed in the month of dec 2020 (352 rows) 
select * from orders where  order_date between '2020-12-01' and '2020-12-31';

#3- write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020 (944 rows)
select * from orders where  ship_mode not in ('Standard Class','First Class')
and ship_date > '2020-11-30';

#4- write a query to get all the orders where customer name neither start with "A" and nor ends with "n" (9815 rows)
select * from orders where customer_name not like 'A%n';
select * from orders where  not (customer_name like 'A%' and customer_name like '%n');

#5- write a query to get all the orders where profit is negative (1871 rows)
select * from orders where profit<0;

#6- write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)
select * from orders where profit=0 or quantity<3;

#7- your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers (815 rows)
select * from orders where region='South' and discount>0;

#8- write a query to find top 5 orders with highest sales in furniture category 
select * from orders where category='Furniture' order by sales desc limit 5 ;


#9- write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)
select   * from orders where category in ('Furniture','Technology') 
and order_date between '2020-01-01' and '2020-12-31';


#10-write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)
select   * from orders where 
order_date between '2020-01-01' and '2020-12-31' and ship_date between '2021-01-01' and '2021-12-31'
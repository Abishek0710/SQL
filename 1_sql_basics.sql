create database namastesql;

use namastesql;

create table amazon_orders
(
order_id integer ,
order_date date,
product_name varchar(50),
total decimal(5,2) , /*total length is 5 out of that 2 is decimal*/
payment_method varchar(20)
);

# storing data into the table

insert into amazon_orders values( 1, '2023-10-15', 'shirt', 550.50, 'UPI');
insert into amazon_orders values( 2, '2023-10-16', 'pant', 900.50, 'credit card');

# selecting rows from a table
select * from amazon_orders;

# selecting specific values from table
select order_date, product_name from amazon_orders;

# Limiting no of rows displayed while selecting
select * from amazon_orders limit 1;

# order by
select * from  amazon_orders order by order_date; 
select * from  amazon_orders order by order_id desc; 

# order by based on multiple columns
select * from  amazon_orders order by order_date desc, total asc;  # if order date is same then it will order the total, orderdate is given higher priority

# deleting a table
drop table amazon_orders;

# to delete only rows from a table
set sql_safe_updates =0; # disabling sql safe updates to delete records
delete from amazon_orders;

set sql_safe_updates =1; # enabling again
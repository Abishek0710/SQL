# Constraints

create table a_orders
(
order_id integer unique Not null, # every record should be unique and not null
order_date date,
product_name varchar(50),
total decimal(5,2) , /*total length is 5 out of that 2 is decimal*/
payment_method varchar(20) check (payment_method in ('UPI', 'credit card')) default 'UPI',  # check constraint will make sure any other value other than the values will not be executed
discount integer check (discount <= 20),
category varchar(30) default 'essentials');

# to see in detail about the table structure
describe a_orders;

insert into a_orders values(null, '2022-10-01','purse',200,"UPI",20,null); 
# this will fail since we have a not null constraint for this column
# For a column with not null constraint we cannot provide data as null

insert into a_orders values(1, '2022-10-01','purse',200,"cod",20,null); 
# will give error as we have check constraint for payment_method column

insert into a_orders values(3, '2022-10-01','purse',200,"UPI",20,category); 
insert into a_orders values(3, '2022-10-01','purse',200,"UPI",20,default);
# this will take the default value from the column

insert into a_orders values(1, '2022-10-01','purse',200,"UPI"); 

Alter table a_orders add constraint payment_method check((payment_method = 'UPI') or (payment_method = 'credit'));

select * from a_orders;

# deleting a rows in a table based on filter condition
set sql_safe_updates = 0;
delete  from a_orders where payment_method = null;

drop table a_orders;



# Primary key
# There can be only one primary key in a table

create table a_orders
(
order_id integer ,
order_date date,
product_name varchar(50),
total decimal(5,2) , /*total length is 5 out of that 2 is decimal*/
payment_method varchar(20) check (payment_method in ('UPI', 'credit card')) default 'UPI',  # check constraint will make sure any other value other than the values will not be executed
discount integer check (discount <= 20),
category varchar(30) default 'essentials',
primary key(order_id,product_name)); #primary key is mentioned at last to give combination of primary key
# order_id,product_name this combination should be not null and unique
# difference between unique and primary key is unique can have 1 null value but primary key cannot

insert into a_orders (order_id, order_date, product_name, total, payment_method, discount, category)
values( 1, '2022-10-01','purse',200,"UPI",20,default);

insert into a_orders (order_id, order_date, product_name, total, payment_method, discount, category)
values( 1, '2022-10-01','shirt',200,"UPI",20,default);

select * from a_orders;

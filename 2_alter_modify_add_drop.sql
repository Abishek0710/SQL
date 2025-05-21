select * from amazon_orders;

# Changing order_date column type from date to datetime
alter table amazon_orders modify column order_date datetime;
# we cannot change int column to date the values should to compatible
# also if we have acolumn with 10 characters we cannot change to 5 characters
# An empty column can be modified to any datatype

select * from amazon_orders;

insert  into amazon_orders values(5, '2024-02-23 08:30:00', 'brush', 250, 'UPI');


# adding extra column in existing table
alter table amazon_orders add username varchar(20);

#null in columns
insert  into amazon_orders values(6, '2024-02-25 10:30:00', null, 250, 'UPI','Abi'); # null without quotes considers as empty
insert  into amazon_orders values(7, '2024-03-08 10:00:00', 'null', 300, 'UPI','Shasha'); # null with quotes is a string value


select * from amazon_orders;

# adding multiple columns in single query 
alter table amazon_orders add category varchar(30), add product_id varchar(20); # for each column add is included
alter table amazon_orders add column category varchar(30), add column product_id varchar(20);

# droping columns
alter table amazon_orders drop column category,drop column product_id;
alter table amazon_orders drop  category,drop  product_id;

select * from amazon_orders;

use namastesql;

# String Functions


# Length of a string
select order_id, customer_name ,
length(customer_name) as len_name
from orders;


select order_id, customer_name ,
length(customer_name) as len_name,
right(customer_name,5) as name_right_5, # returms string last 5 characters
left(customer_name,5) as name_left_5 # returns string first 5 characters
from orders;



# SUBSTR
#syntax : substr(column, start, how many char from start)
select order_id, customer_name ,
substr(customer_name,5,5) as sub_name
from orders;


select order_id, customer_name ,
substring(customer_name,4,4) as sub_name
from orders;


#stringIndex
#returns the position (1-based index) of the first occurrence of substring in string
select order_id, customer_name ,
INSTR(customer_name, 'e') as string_index
from orders;


# to get string index of multiple occurance
select order_id, customer_name ,
locate('n', customer_name) as locate_1,
locate( 'n', customer_name, locate('n', customer_name)+1) as locate_2,
locate('n', customer_name, locate('n', customer_name , locate('n', customer_name ) +1)+1) as locate_3
from orders;


# concating column values

select order_id, customer_name,
concat(order_id, '-',  customer_name) as concat_1
from orders;



# fetch only the first name of customername
select customer_name,
left(customer_name,locate(' ', customer_name)) as first_name # locate(' ', customer_name) this gives the index where we have ' '
from orders;



# Replace an string from a string column
select customer_name,
replace(customer_name, ' ', '-') as replace_col
from orders;



# if we want to replace multiple characters
select customer_name,
replace(replace(replace(customer_name, ' ', '-'), 'A', 'a'),'B','b') as replace_col
from orders;


# Trim function
# removes leading and trailing spaces from string values
select customer_name,
trim(customer_name) from orders;


# If we want to check if any extra spaces are removed
select length(customer_name),
length(trim(customer_name)) from orders;


# Null Handling
select order_id, city,
ifnull(city, 'unknown') as new_city
from orders
where city is null;


# coalesce and ifnull used for null handling or replacing
select order_id, city,
coalesce(city, 'unknown') as new_city
from orders
where city is null;


# in coalesce multiple columns can be used
select order_id, city, state, region ,
coalesce(city,state,region, 'unknown') as new_city # if city is null value of state is taken if city and region are null it will take value of region if all three are null then default value unknown is taken
from orders
where city is null;


# type casting
# changing dtype into integer
# usigned is used for negative values
select order_id, sales, cast(sales as signed) as sales_1
from orders;


# similarly we can use char, date, decimal, datetime etc


# round function
select order_id, round(sales,1) # rounds upto 1 decimal value
from orders;


# Union operation

create table order_east(
order_id integer,
region varchar(20),
sales int);

create table order_west(
order_id integer,
region varchar(20),
sales int);

insert into order_east(order_id, region, sales)
values(1, 'east', 100), 
(2, 'eatst', 200),
(3, 'west', 300);

insert into order_west(order_id, region, sales)
values(3, 'west', 300), 
(4, 'west', 500);


# union all will combine both tables
# But no of columns, column name and dtype should be same in both tables
select * from order_east
union all
select * from order_west;



# if you want the union all results without duplicates we use union
select * from order_east
union 
select * from order_west;


select distinct * from order_east
union all
select distinct * from order_west;


# fetching common records
# this only shows the comming records between two tables
select * from order_east
inner join order_west 
using ( order_id, region, sales);


select * from order_west
except 
select * from order_east;


select * from order_east
except 
select * from order_west;
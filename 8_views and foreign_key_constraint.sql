

use namastesql;


create table icc_world_cup
(
team1 varchar(20),
team2 varchar(20),
winner varchar(20));

insert into icc_world_cup( team1, team2, winner)
values( 'IND', 'SL', 'IND'),
('SL', 'AUS', 'AUS'),
('SA', 'ANG', 'ENG'),
('ENG','NZ', 'NZ'),
('AUS', 'IND', 'IND');

select * from icc_world_cup;

# fetching all the didtinct teams that played in a single column
select team1 as team_name from icc_world_cup
union
select team2 as team_name from icc_world_cup;


# create a column flag if team 1 wins then the flag value increases
select team1 as team_name,
case 
when team1 = winner 
then 1 else 0 
end as flag 
from icc_world_cup;


select team2 as team_name,
case 
when team2 = winner 
then 1 else 0 
end as flag 
from icc_world_cup;



select team1 as team_name, case when team1 = winner then 1 else 0 
end as flag from icc_world_cup
union all
select team2 as team_name, case when team2 = winner then 1 else 0 
end as flag from icc_world_cup;



create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');



select * from drivers;


select id, count(*) as total_rides
from drivers
group by id;

# interview qn
/*write a query to print below output using drivers table. Profit rides are the no of rides where end location of a ride is same as start location of immediate next ride for a driver
id, total_rides , profit_rides*/

select * from drivers d1
inner join drivers d2 on d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time;


select * from drivers d1
left join drivers d2 on d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time;


select d1.id, count(*) as total_rides, count(d2.id) as profit_rides from drivers d1
left join drivers d2 on d1.id = d2.id and d1.end_loc = d2.start_loc and d1.end_time = d2.start_time
group by d1.id;


/*write a query to print below output from orders data. example output
hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies */

select 'category' as hierarchy_type, category as hierarchy_name, 
sum(case when region = 'west' then sales end) as total_sales_west_region,
sum(case when region = 'east' then sales end) as total_sales_east_region
from orders
group by category
union all
select 'sub_category' as hierarchy_type, sub_category as hierarchy_name, 
sum(case when region = 'west' then sales end) as total_sales_west_region,
sum(case when region = 'east' then sales end) as total_sales_east_region
from orders
group by sub_category;



select 'category' as hierarchy_type, category as hierarchy_name, sub_category,
sum(case when region = 'west' then sales end) as total_sales_west_region,
sum(case when region = 'east' then sales end) as total_sales_east_region
from orders
group by category , sub_category;


select category , length(category),
case when length(category)  != length(trim(category)) then 1 else 0 end as category_len_check
from orders
order by category_len_check asc;


# creating a view
create view orders_view as
select * from orders;

select * from orders_view;
# view dont hold any data it will just show the results for the query it was created
# here we have used select query to create a view so whenever this view is called the select query runs

drop view orders_view;


create view sales_on_region_view as
select 'category' as hierarchy_type, category as hierarchy_name, 
sum(case when region = 'west' then sales end) as total_sales_west_region,
sum(case when region = 'east' then sales end) as total_sales_east_region
from orders
group by category
union all
select 'sub_category' as hierarchy_type, sub_category as hierarchy_name, 
sum(case when region = 'west' then sales end) as total_sales_west_region,
sum(case when region = 'east' then sales end) as total_sales_east_region
from orders
group by sub_category;


select * from sales_on_region_view; 

drop view sales_on_region_view;


# Foreign key constraint

select * from employee;
select * from dept;

SELECT dept_id
FROM employee
WHERE dept_id NOT IN (SELECT dep_id FROM dept);

# For a foreign key we need to provide a primary key from another table  

alter table dept modify column  dep_id int not null,
add primary key (dep_id);

describe dept;

alter table employee add constraint 
foreign key  (dept_id) 
references dept(dep_id);

select * from employee;
select * from dept;

set sql_safe_updates =0;
delete from dept where dep_id is null;


update dept 
set dep_id = 600
where dep_id = 500;


# auro_increment constraint

CREATE TABLE dept2 (
    id INT AUTO_INCREMENT unique ,
    dept_id INT,
    dep_name VARCHAR(20)
);


# for auto increment we dont have to specify the values it will increase the value by 1
insert into dept2(dept_id, dep_name)
values(100,"HR"),
(200,'Analytics');

select * from dept2;


insert into dept2(id, dept_id, dep_name)
values(4, 300, 'Data');

insert into dept2(dept_id, dep_name)
values(500,"IT");
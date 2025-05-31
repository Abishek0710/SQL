use namastesql;

# Sub Query

select order_id, sum(sales) 
from orders
group by order_id;


select avg(order_sales) from
(select order_id, sum(sales) as order_sales
from orders
group by order_id) as sub;


select order_id 
from orders
group by order_id
having sum(sales) > (select avg(order_sales) avg_order_sales from
(select order_id, sum(sales) as order_sales
from orders
group by order_id) as sub) ;

# while giving  a sub query in from clause we need to give alias to sub query
# but while using in having or where clause providing alias to sub query is optional



select * from employee;
select * from dept;

# fetch the records from dept where the the dept id is not found in employee tbl
select * from dept
where dep_id not in (select dept_id from employee);

# we can pass sun query in not in conditions also



# Sub query in select

select *, (select avg(salary) from employee) as avg_sal from employee;


# Join using subqueries 

select A.*, b.* from
(select order_id, sum(sales) as order_sales
from orders
group by order_id) as  A
inner join 
(select avg(order_sales) as avg_order_sales
from (
select order_id, sum(sales) as order_sales from orders
group by order_id ) as orders_aggregated) as B
on 1=1;


select A.*, b.* from
(select order_id, sum(sales) as order_sales
from orders
group by order_id) as  A
inner join 
(select avg(order_sales) as avg_order_sales
from (
select order_id, sum(sales) as order_sales from orders
group by order_id ) as orders_aggregated) as B
on 1=1
where order_sales > avg_order_sales;


select e.*, d.avg_salary from employee as e
inner join 
(select dept_id, avg(salary) as avg_salary from employee
group by dept_id) as d
on e.dept_id = d.dept_id;


select * from icc_world_cup;

set sql_safe_updates = 0;

update icc_world_cup
set team2 = 'ENG'
where team2 = 'ANG';


# creating a points tables displaying team, no of matches, no of matches won and no of matches lost

select team1 as teams, winner, case when team1 = winner then 1 else 0 end as points 
from icc_world_cup
union all
select team2 as teams, winner, case when team2 = winner then 1 else 0 end as points 
from icc_world_cup;


select teams, count(*) as matches_played, sum(points) as matches_won, count(*) - sum(points) as matches_lost
from
(select team1 as teams, winner, 
case when team1 = winner then 1 else 0 end as points 
from icc_world_cup
union all
select team2 as teams, winner, 
case when team2 = winner then 1 else 0 end as points 
from icc_world_cup) as A
group by teams;




# CTE - common table expression
# it is similar to sub query but we eill take a table and will fetch from tht table

with A as 
(select team1 as teams, winner, 
case when team1 = winner then 1 else 0 end as points 
from icc_world_cup
union all
select team2 as teams, winner, 
case when team2 = winner then 1 else 0 end as points 
from icc_world_cup)
select teams, count(*) , sum(points) as matches_played, count(*) - sum(points) as matches_won
from A
group by teams;



with dep as
( select dept_id, avg(salary) as avg_dep_salary
from employee
group by dept_id) 
select e.* , d.avg_dep_salary 
from employee e
inner join dep d
where e.dept_id = d.dept_id;


select A.*, b.* from
(select order_id, sum(sales) as order_sales
from orders
group by order_id) as  A
inner join 
(select avg(order_sales) as avg_order_sales
from (
select order_id, sum(sales) as order_sales from orders
group by order_id ) as orders_aggregated) as B
on 1=1
where order_sales > avg_order_sales;

# Same above query using CTE

with order_wise_sales as 
(select order_id, sum(sales) as order_sales
from orders
group by order_id),

B as ( select avg(order_sales) as avg_order_sales
from order_wise_sales)

select order_wise_sales.*, B.* 
from order_wise_sales
inner join B
on 1=1
where order_sales > avg_order_sales;

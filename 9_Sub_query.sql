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



# Sub query in sub query

select *, (select avg(salary) from employee) as avg_sal from employee
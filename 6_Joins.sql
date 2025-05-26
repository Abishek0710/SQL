## Joins


use namastesql;

select * from orders;
select count(*) from returns;


# joining 2 tables using inner join
select o.order_id, o.order_date, r.return_reason from orders o 
inner join returns r on o.order_id = r.order_id;

select o.*, r.return_reason from orders o 
inner join returns r on o.order_id = r.order_id;
# returns all the columns from orders tbl and returns reason column from returns tbl


# Left join
# Left join takes all records from left table(ie.orders) and returns the matcching records from right table(ie.returns)
select o.order_id, o.product_id, r.return_reason from orders o 
left join returns r on o.order_id = r.order_id;


#Interview Qn
#Select all the records that are not returned ie those records dont have return reason
select o.order_id, o.product_id, r.return_reason from orders o 
left join returns r on o.order_id = r.order_id
where r.order_id is null;


# Number of records that are not returned
select count(*) from orders o 
left join returns r on o.order_id = r.order_id
where r.order_id is null;


select r.return_reason, sum(o.sales) as total_sales from orders o
left join returns r on o.order_id = r.order_id
group by r.return_reason
order by total_sales;
# if left join is used we will see null as a cateegory because there will be null values in return reason for non matching records


select r.return_reason, sum(o.sales) as total_sales from orders o
inner join returns r on o.order_id = r.order_id
group by r.return_reason
order by total_sales;
# We wont see null as a category because in inner join we will only have matching records not all records from left table


select * from employee;
select * from dept;

# cross Join
# cross join joins each records from one table to every other records from other table
# we dont need any on condition for croos join
#It is used when we dont have any common column from both tables
select * from employee,dept;

select * from employee
cross join dept;
# we have 10 records in employee and 4 records in dept by cross join we will get 40 records


select * from employee e
cross join dept d on e.dept_id = d.dep_id;
# cross join in on condition acts as inner

select * from employee e
inner join dept d on e.dept_id = d.dep_id;


select e.emp_name, e.emp_id, e.dept_id, d.dep_name from employee e
left join dept d on e.dept_id = d.dep_id;


# Right Join
# It gives all records from right table and matching records from left table
select e.emp_name, e.emp_id, e.dept_id, d.dep_name from dept d
right join employee e on e.dept_id = d.dep_id;



select r.*, o.order_id from orders o 
right join returns r on o.order_id = r.order_id;
# Usually we wont use right join since we can achieve everything using left join



# Full outer join
# It combines results of left and right join
# It is not supported in mysql
# Full outer join is achieved indirectly in mysql

select e.emp_name, e.emp_id, e.dept_id, d.dep_name from employee e
left join dept d on e.dept_id = d.dep_id
union all
select e.emp_name, e.emp_id, e.dept_id, d.dep_name from employee e
right join dept d on e.dept_id = d.dep_id;



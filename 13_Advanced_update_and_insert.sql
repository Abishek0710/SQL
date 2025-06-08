

-- Advanced update and insert

select * from employee;
select * from dept;
-- taking back up for employee and dept tables

create table employee_bkp as
select * from employee;

create table dept_bkp as
select * from dept;


# Normal way of updating a table
update employee
set dept_id = 300
where emp_name = 'Agam';

# update salary of employees by 10% whose dept is HR
update employee
set salary = salary *1.1
where dept_id in (select dep_id from dept where dep_name = 'HR');


 -- another way of perforing the same update
update employee e
left join dept d on d.dep_id = e.dept_id
set salary = e.salary * 1.1
where d.dep_name = 'HR';

select * from employee;


alter table employee add column dept_name varchar(20);

-- we have created a column dept id in employee
-- we have values for that col in dept tbale
-- so we are updating the col in employee table using dept table

update employee e
inner join dept d on e.dept_id= d.dep_id
set dept_name = d.dep_name;

select * from employee;


# Deleting using join

delete e 
from employee e
left join dept d
on e.dept_id = d.dep_id
where d.dep_name = 'HR';

delete from employee where dept_id not in ( select dep_id from dept);

select * from employee;



# exists and not exists

select * from employee e
where exists ( select 1 from dept d  where e.dept_id = d.dep_id);

select * from employee e
where not exists ( select 1 from dept d  where e.dept_id = d.dep_id);

/* exists and not exists are not used mostly 
everything that is performed with exists clause can be done with where clause*/

-- ddl - create, drop , alter
-- dml - insert, update, delete
-- dql - select
-- dcl - grant, revoke


# DCL - Data control Language

# to give access to a user name with guest
grant select , insert on namastesql.employee to guest;

grant select , insert, create, update on namastesql.employee to public;

# revoke access
revoke select , insert on namastesql.employee from guest;


create role role_sales;
grant select , insert on namastesql.employee to role_sales;

# using with grant option gives access to the users in a role to provide access
grant select , insert on namastesql.employee to role_sales with grant option;


# TCL - Transaction Control Language -- commit and rollback


# we are starting a transaction with some dml operation

start transaction ;
update employee set salary = 30000 where emp_id = 1;

# checking if the operation is affected
select * from employee;

# if we are not satisfied with the operation we can undo using rollback
rollback ;

start transaction ;
update employee set salary = 30000 where emp_id = 1;

# if we want the operation to be permanent we can use commit
commit;



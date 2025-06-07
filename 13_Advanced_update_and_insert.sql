

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





















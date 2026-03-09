
use namastesql;
SELECT * FROM employee_bkp;

/* Inddex in tables will keeps the records in sorted manner
it is useful when we want to perform colum by column operation like where conditions 
if data is sortedin order it is easier to fetch results*/

-- primary key is also an index which acts like a clustered index

-- each table can have only clustered one index 
-- because when clustered index is created the data is sorted ans stored we cannot sort based on two columns
-- In case we need more index we can create non clustered index because it is not sorted instead address is passed 
-- when a filter query is run it will check the address of the filter condition to get the results quickly

-- In non clustered index a refrence address is passed with the value
/*A non-clustered index is a type of database index where the index and the actual data are stored separately. 
The index contains pointers (row locations) to the actual data rows in the table*/

-- when index is created in below manner it creates a non clustered index
create index idx_emp on employee_bkp(manager_id);

SELECT * FROM employee_bkp;

describe employee_bkp;

drop index idx_emp on employee_bkp;


create table orders_bkp as
select * from orders;


# creating a table from existing table that will have more records
create table order_index as 
select row_number() over(order by a.row_id) as rn, a.* from orders as a, 
(select * from orders limit 200) as b;


create index idx_ordid on orders_bkp(order_id);

select * from orders_bkp;


select * from orders_bkp where customer_id > 'CA-2021-113572'; 


# Deleting Duplicates

select * from employee_bkp group by 1,2,3,4,5,6 having count(*) >1;


select * from employee_bkp group by emp_id, emp_name, dept_id, salary, manager_id, emp_age having count(*) >1;

















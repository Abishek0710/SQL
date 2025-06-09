SELECT * FROM employee_bkp;

/* Inddex in tables will keeps the records in sorted manner
it is useful when we want to perform colum by column operation like where conditions 
if data is sortedin order it is easier to fetch results*/

-- primary key is also an index which acts like a clustered index

-- each table can have only clustered one index
-- In case we need more index we can create non clustered index

-- In non clustered index a refrence address is passed with the value
/*A non-clustered index is a type of database index where the index and the actual data are stored separately. 
The index contains pointers (row locations) to the actual data rows in the table*/

-- when index is created in below manner it creates a non clustered index
create index idx_emp on employee_bkp(manager_id);

SELECT * FROM employee_bkp;

describe employee_bkp;

drop index idx_emp on employee_bkp;


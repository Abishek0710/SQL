# PROCEDURES

DELIMITER $$

CREATE PROCEDURE sp_emp()
BEGIN
    SELECT * FROM employee;
END $$

DELIMITER ;


call sp_emp;

# we cannot alyer a procedure in mysql so we will drop and create again

drop procedure sp_emp;

delimiter $$
create procedure sp_emp(in salary_val int, dept_id_val int)
begin
select * from employee where salary > salary_val and dept_id = dept_id_val;
end $$
delimiter ;


call sp_emp(8000,100);

drop procedure sp_emp;

delimiter $$
create procedure sp_emp(in salary_val int, dept_id_val int)
begin
insert into dept values(800,'HR1');
select * from employee where salary > salary_val and dept_id = dept_id_val;
end $$
delimiter ;
# W can include any staement like create insert, drop, delete etc inside a procedure


call sp_emp(5000,100);
select * from dept;



drop procedure sp_emp;

delimiter $$
create procedure sp_emp(in dept_id_val int, out cnt int )
begin
-- creating a var inside procedure
declare cnt int;

-- Store the employee count int cnt variable
select count(*) into cnt from employee where dept_id = dept_id_val;

-- Use IF-ELSE with SELECT for output
if cnt = 0 then
	select "there is no employee with this dept=id" as message;
else
	select concat("Total emplyess : " ,cnt) as message; 
end if;
end $$
delimiter ;


call sp_emp(100);


drop procedure sp_emp;

delimiter $$
create procedure sp_emp(in dept_id_val int, out cnt int )
begin

-- Store the employee count int cnt variable
select count(*) into cnt from employee where dept_id = dept_id_val;

-- Use IF-ELSE with SELECT for output
if cnt = 0 then
	select "there is no employee with this dept=id" as message;
else
	select concat("Total emplyess : " ,cnt) as message; 
end if;
end $$
delimiter ;


# insted od declaring a variable inside procedure we can do outside also
set @total := 0;
call sp_emp(100, @total);
select @total as total_emp;






















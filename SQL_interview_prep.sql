select * from employee;
select * from departments;
# 1.How to find the duplicates in given table
select employee_id, count(*) from employee group by employee_id having count(*) >1;

# 2.How to delete the duplicates
with cte as (
select *, 
row_number() over(partition by employee_id order by salary) as rn 
from employee)

select * from cte where rn=1;
-- delete from employee where rn>1;

# 3.difference between union and union all

	/* union removes duplicate records if present in both tables 
	union all shows all the records even if there is duplicates */

# 4. Difference between rank, dense_rank and row_number

select *, 
row_number() over(order by salary desc) as rn ,
rank() over(order by salary desc ) as rnk ,
dense_rank() over(order by salary desc) drnk from employee;

	/*row number - 	It assigns a unique, sequential integer to every row, 
					regardless of whether the values are identical. 
                    If two employees have the exact same salary, one will randomly be assigned "2" and the other "3"
	rank 		-	When RANK() encounters a tie, it gives both rows the same rank.
					However, it "makes up for it" by skipping the next available numbers. 
                    If two people are tied for 2nd place, the next person is ranked 4th.
	dense rank  -	Like RANK(), it gives tied rows the same number. 
					However, it never skips a number. 
                    If two people are tied for 2nd, the next person is ranked 3rd */
                    
# 5.Show employees which are not present in department table
select emp.*, dept.department_name from employee as emp
left join departments as dept on emp.department = dept.department_name
where dept.department_name is null;
-- select * from employee where department in (select department_name from departments);
-- select department, length(department) from employee order by department asc;
-- select department_name, length(department_name) from departments order by department_name asc


# 6. second highest salaried employee in each department

select * from (
select *, dense_rank() over( partition by department order by salary desc) as rnk
from employee where department is not null) a
where rnk = 2;

# Get the third overall salary
select * from (
select *, dense_rank() over(order by salary desc) as rnk from employee) a where rnk =3;


# 7. Show the records of a customer whose name is alice

select * from employee where lower(first_name) = 'alice';


# 8. Show the salary of employees whose salary is greater than manager

select e.* from employee as e
join employee as m
on e.employee_id = m.manager_id
where e.salary> m.salary;

# 9. Update the table and change gender from male to female and female to male

update employee set gender = case when gender = 'Female' then 'Male'
						when gender = 'male' then 'Female' end ;
                        
                        
# 10. How join behaves when the join key have duplicates

create table t1
(id int);

insert into t1 values (Null);

insert into t2 values (Null);

select * from t1;
select * from t2;

# inner join
select * from t1 inner join t2 on t1.id = t2.id;

# right join
select * from t1 right join t2 on t1.id = t2.id;

# left join
select * from t1 left join t2 on t1.id = t2.id;


/* 
Table1			Table2
c1	c2			c3	c4
1	A			1	A 
2	B			1	B 
3	C			3	C 
4	D			5	D 
				2	E 
                6	F
11. Given 2 tables give the results for inner, left, right, outer join
*/

create table j1
(c1 int, c2 varchar(10));

insert into j1 
values
(1,'A'), (2,'B'), (3,'C'), (4,'D');

CREATE TABLE j2
(c3 int, c4 varchar(10));

insert into j2
values
(1,'A'), (1,'B'), (3,'C'), (5,'D'), (2,'E'), (6,'F');

SELECT * from j1;
select * from j2;

# inner join
select * from j1 join j2 on j1.c1= j2.c3; 

# left join
select * from j1 left join j2 on j1.c1= j2.c3; 

# right join
select * from j1 right join j2 on j1.c1= j2.c3; 

# full outer
select * from j1 left join j2 on j1.c1= j2.c3
union
select * from j1 right join j2 on j1.c1= j2.c3; 

drop table j1,j2;
# 12. Given a table with user id and follower id find the no of followers with respect to user id

/*
userid 	followerid
0		1
1		0
2		0
2		1
2		1
*/

create table usertbl
(userid int, followerid int);

insert into usertbl
values
(0,1), (1,0), (2,0), (2,1), (2,1);

# no of followers as per user id
select userid, count(distinct followerid) from usertbl group by userid;

select userid, count(*) from ( select distinct userid, followerid from usertbl) as A group by userid;

/*
Table 1		Table2
ID			ID
A			A
A			A
B			C
Null		Null

13. Give the outputs of inner, left , right, and outer join for the above table 
*/

create table j1
(id varchar(10));
create table j2 
(id varchar(10));

insert into j1
values
('A'), ('A'), ('B'), (Null);

insert into j2
values
('A'), ('A'), ('C'), (Null);

# inner
select * from j1 inner join j2 on j1.id = j2.id;

# left join
select * from j1 left join j2 on j1.id = j2.id;

# right join
select j2.id, j1.id from j1 right join j2 on j1.id = j2.id;

#full outer join
select * from j1 left join j2 on j1.id = j2.id
union 
select * from j1 right join j2 on j1.id = j2.id


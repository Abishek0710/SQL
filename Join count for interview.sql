use namastesql;
create table joinA (id int);
create table joinB (id int);

insert into joinA
values(1),(1);

insert into joinB
values(1),(1),(1);
insert into joinB
values(1);

set sql_safe_updates = 0;
delete from joinB where id = 2;

select * from joinA;
select * from joinB;

# inner join
select * from joinA as a
inner join joinB as b
on a.id = b.id;


# left join
select * from joinA as a
left join joinB as b
on a.id = b.id;


# right join
select * from joinA as a
right join joinB as b
on a.id = b.id;

#full outer Join
select * from joinA as a
left join joinB as b
on a.id = b.id
union 
select * from joinA as a
right join joinB as b
on a.id = b.id
;

insert into joinA values(2);


# inner join
select * from joinA as a
inner join joinB as b
on a.id = b.id;


# left join
select * from joinA as a
left join joinB as b
on a.id = b.id;


# right join
select * from joinA as a
right join joinB as b
on a.id = b.id;

#full outer Join
select * from joinA as a
left join joinB as b
on a.id = b.id
union
select * from joinA as a
right join joinB as b
on a.id = b.id
;

insert into joinA values(null);
insert into joinB values(null);

select * from joinA;
select * from joinB;

# inner join
select * from joinA as a
inner join joinB as b
on a.id = b.id; # null cannot be compared with null so it wont display in inner join


# left join
select * from joinA as a
left join joinB as b
on a.id = b.id;


# right join
select * from joinA as a
right join joinB as b
on a.id = b.id;

#full outer Join
select * from joinA as a
left join joinB as b
on a.id = b.id
union
select * from joinA as a
right join joinB as b
on a.id = b.id
;
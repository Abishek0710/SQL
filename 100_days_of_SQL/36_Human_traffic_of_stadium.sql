/*

You are given a table stadium that records the number of people who visited a stadium on different dates.

Each row contains:

a unique incremental ID

visit date

number of people visited

🎯 Task

Write an SQL query to return all rows that belong to 3 or more consecutive rows where:

no_of_people >= 100

Rows must be consecutive based on ID

If a row is part of any valid consecutive group, it must appear in the output

🗂 Table Structure

CREATE TABLE stadium (
    id INTEGER,
    visit_date DATE,
    no_of_people INTEGER
);

Input data:
id	visit_date	no_of_people
1	2022-07-01	10
2	2022-07-02	109
3	2022-07-03	150
4	2022-07-04	80
5	2022-07-05	130
6	2022-07-06	160
7	2022-07-07	180
8	2022-07-08	140
9	2022-07-09	90
10	2022-07-10	110
11	2022-07-11	120
12	2022-07-12	130
13	2022-07-13	140
14	2022-07-14	50
15	2022-07-15	160
16	2022-07-16	170
17	2022-07-17	180
18	2022-07-18	190
19	2022-07-19	95
20	2022-07-20	100
21	2022-07-21	120
22	2022-07-22	130


Expected Output:
id	visit_date	no_of_people
5	2022-07-05	130
6	2022-07-06	160
7	2022-07-07	180
8	2022-07-08	140
10	2022-07-10	110
11	2022-07-11	120
12	2022-07-12	130
13	2022-07-13	140
15	2022-07-15	160
16	2022-07-16	170
17	2022-07-17	180
18	2022-07-18	190
20	2022-07-20	100
21	2022-07-21	120
22	2022-07-22	130
*/

with xxx as (
Select *,
row_number() over(order by visit_date) as rn ,
id - row_number() over(order by visit_date) as grp
from stadium
where no_of_people >= 100
)

select  id,
  visit_date,
  no_of_people
from xxx
where grp in(
select grp from xxx 
group by grp
having count(1) >=3);
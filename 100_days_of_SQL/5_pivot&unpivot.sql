/*
You are given an employee compensation table where each salary component is stored as a separate row.

Each employee can have multiple salary components such as:

salary

bonus

hike_percentage

Your manager wants the data in a columnar format, where:

Each employee appears only once

Each salary component becomes a separate column

You must not use database-specific PIVOT or UNPIVOT functions.
Use standard SQL only.

📋 Input Table

CREATE TABLE emp_compensation (
    emp_id INT,
    salary_component_type VARCHAR(20),
    val INT
);

Input data:

emp_id	salary_component_type	     val
1	        salary	                10000
1	        bonus	                5000
1	        hike_percent	        10
2	        salary	                20000
2	        bonus	                3000
2	        hike_percent	        12
3	        salary	                15000
3	        bonus	                4000
3	        hike_percent	        8
4	        salary	                25000
4	        bonus	                6000
4	        hike_percent	        15
5	        salary	                18000
5	        bonus	                3500
5	        hike_percent	        9
6	        salary	                22000
6	        hike_percent	        11
7	        salary	                30000
7	        bonus	                7000
8	        salary	                12000
8	        bonus	                2000
8	        hike_percent	        5



Expected result

emp_id	 salary	    bonus	    hike_percent
1	     10000	    5000	    10
2	     20000	    3000	    12
3	     15000	    4000	    8
4	     25000	    6000	    15
5	     18000	    3500	    9
6	     22000	    null	    11
7	     30000	    7000	    null
8	     12000	    2000        5



*/



--pivot
select emp_id,
sum(case when salary_component_type = 'salary' then val  end) as salary,
sum(case when salary_component_type = 'bonus' then val  end) as bonus,
sum(case when salary_component_type = 'hike_percent' then val end) as hike_percent
from emp_compensation
group by emp_id; 


--unpivot ( from output format to input format)


select emp_id, 'salary' as salary_component_type, salary as val
from emp_compensation_pivot
union all
select emp_id, 'bonus' as salary_component_type, bonus as val
from emp_compensation_pivot
union all
select emp_id, 'hike_percent' as salary_component_type, hike_percent as val
from emp_compensation_pivot;
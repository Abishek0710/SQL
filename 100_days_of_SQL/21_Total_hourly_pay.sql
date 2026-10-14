/*

Freelancers are paid hourly, but their billing rate may change over time.

You are given two tables:

billings – contains billing rate changes

hoursworked – contains daily hours worked by each employee

⚠️ Billing Rule (Important)

A billing rate becomes effective from its bill_date

If a new bill_date appears, it overrides the old rate

For any work date, use the latest applicable rate on or before that work date

The solution must automatically work for future rate changes

🗂 Table Structures

CREATE TABLE billings (
    emp_name TEXT,
    bill_date DATE,
    bill_rate INT
);
 
CREATE TABLE HoursWorked (
    emp_name TEXT,
    work_date DATE,
    bill_hrs INT
);

billings table:
emp_name	bill_date	bill_rate
Amit	    2022-01-01	    20
Amit	    2022-02-10	    25
Amit	    2022-03-15	    30
Neha	    2022-01-05	    40
Neha	    2022-02-20	    45
Ravi	    2022-01-01	    50

HoursWorked table:
emp_name	work_date	bill_hrs
Amit	    2022-01-05	    5
Amit	    2022-01-20	    4
Amit	    2022-02-15	    6
Amit	    2022-03-20	    3
Neha	    2022-01-10	    4
Neha	    2022-02-10	    5
Neha	    2022-02-25	    6
Ravi	    2022-01-03	    8
Ravi	    2022-02-03	    7
Ravi	    2022-03-03	    6
Ravi	    2022-04-01	    5

Expected Output:
emp_name	total_billing
Amit	    420
Neha	    630
Ravi	    1300
    

*/


WITH date_range AS (
    SELECT
        emp_name, bill_date, bill_rate,
        DATE(COALESCE(LEAD(bill_date) OVER (PARTITION BY emp_name ORDER BY bill_date), '9999-12-31'),'-1 day') AS bill_date_end
    FROM billings
)
SELECT
    hw.emp_name, 
    SUM(dr.bill_rate * hw.bill_hrs) AS total_billing
FROM date_range dr
JOIN HoursWorked hw
    ON hw.emp_name = dr.emp_name
   AND hw.work_date BETWEEN dr.bill_date AND dr.bill_date_end
GROUP BY hw.emp_name;
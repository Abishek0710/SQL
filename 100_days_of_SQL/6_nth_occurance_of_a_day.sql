/*
You are given a table that contains:

a starting date (today_date)

a number n

Your task is to find the date of the nth occurrence of Sunday after the given date.

🔍 Key Rules

The search is strictly after the given date
(if the given date itself is Sunday, it does NOT count).

You must return the nth Sunday occurring in the future.

The solution should work for any given date and any value of n.

🧩 Example Explanation

If:

today_date = '2022-01-01' (Saturday)

n = 1 → Output: 2022-01-02

n = 2 → Output: 2022-01-09

n = 3 → Output: 2022-01-16

📋 Table Structure

CREATE TABLE input_date (
    today_date DATE,
    n INTEGER
);
Assuming today's date as per input_date table, Write SQL to get 3rd Sunday.




Expected Output

sunday_3
2022-01-02
2022-01-09
2022-01-16
2022-01-30
2022-01-09
2022-01-16
2022-01-30
2022-01-09
2022-01-16
2022-02-13
2022-01-09
2022-01-23
2022-02-27
2022-02-06
2022-02-13
2022-03-06
2022-03-13
2022-04-03
2022-06-26
2022-07-31
2023-01-01
*/


SELECT DATE(
           today_date,
           CASE
               WHEN strftime('%w', today_date) = '0'
                   THEN (7 * 1)  -- today is Sunday → skip to next Sunday (7 days later)
               ELSE (7 - strftime('%w', today_date))  -- move to coming Sunday
           END || ' days',
           ((n - 1) * 7) || ' days'
       ) AS sunday_3
FROM input_date;
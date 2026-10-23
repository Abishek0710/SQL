/*
You are given a table subscriber that stores SMS message exchanges between users.

Each row represents:

who sent the message

who received the message

how many SMS (sms_no) were sent on a given date

📌 Important Challenge
Messages between two people can appear in both directions:

A → B

B → A

🎯 Requirement

Write a SQL query to find the total number of messages exchanged between each unique pair of users, regardless of direction.

🔑 Output Rules

Each pair must appear only once

Order the two users alphabetically

person_1 = alphabetically smaller name

person_2 = alphabetically larger name

Sum all messages sent in both directions

🗃️ Table Schema

CREATE TABLE subscriber (
    sms_date DATE,
    sender TEXT,
    receiver TEXT,
    sms_no INTEGER
);

Input data:
sms_date	    sender	    receiver	sms_no
2023-01-01	    Avinash	    Weibo	      10
2023-01-01	    Weibo	    Avinash	      20
2023-01-02	    Avinash	    Rahul	      5
2023-01-02	    Rahul	    Avinash	      8
2023-01-03	    Avinash	    Sneha	      12
2023-01-04	    Sneha	    Avinash	      6
2023-01-01	    Rahul	    Sneha	      4
2023-01-02	    Sneha	    Rahul	      11
2023-01-05	    Rahul	    Weibo	      7
2023-01-06	    Weibo	    Rahul	      9
2023-01-07	    Sneha	    Weibo	      3
2023-01-08	    Weibo	    Sneha	      6
2023-01-09	    Amit	    Avinash	      14
2023-01-10	    Avinash	    Amit	      6
2023-01-11	    Amit	    Rahul	      5
2023-01-12	    Rahul	    Amit	      7
2023-01-13	    Amit	    Sneha	      9
2023-01-14	    Sneha	    Amit	      1

Expected Output:
sms_date	    p1	        p2	    total_sms
2023-01-01	    Avinash	    Weibo	  30
2023-01-01	    Rahul	    Sneha	  4
2023-01-02	    Avinash	    Rahul	  13
2023-01-02	    Rahul	    Sneha	  11
2023-01-03	    Avinash	    Sneha	  12
2023-01-04	    Avinash	    Sneha	  6
2023-01-05	    Rahul	    Weibo	  7
2023-01-06	    Rahul	    Weibo	  9
2023-01-07	    Sneha	    Weibo	  3
2023-01-08	    Sneha	    Weibo	  6
2023-01-09	    Amit	    Avinash	  14
2023-01-10	    Amit	    Avinash	  6
2023-01-11	    Amit	    Rahul	  5
2023-01-12	    Amit	    Rahul	  7
2023-01-13	    Amit	    Sneha	  9
2023-01-14	    Amit	    Sneha	  1

*/


select sms_date, p1,p2, sum(sms_no) as total_sms from
(
Select *,
case when sender<receiver then sender else receiver end as p1,
case when sender>receiver then sender else receiver end as p2
from subscriber
)
group by sms_date, p1,p2

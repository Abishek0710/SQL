/*
You are given two tables:

person – stores each person’s basic information and score.

friend – stores friendship relationships between people.

A person can have one or more friends.

🎯 Objective

Write a SQL query to find details of persons whose friends’ total score is greater than 100.

For each qualifying person, return:

PersonID

Name

Number of friends

Total score of all friends

📋 Table Structures

CREATE TABLE person (
    PersonID INT,
    Name VARCHAR(50),
    Score INT
);
 
CREATE TABLE friend (
    pid INT,   -- person id
    fid INT    -- friend id
);

input data:

person tbl
PersonID	Name	    Score
1	        Aman	    88
2	        Rohit	    38
3	        Neha	    27
4	        Pooja	    45
5	        Rahul	    60
6	        Kunal	    55
7	        Sneha	    40
8	        Arjun	    70
9	        Meena	    65
10	        Vikas	    30
11	        Anita	    50
12	        Suresh	    90

friend tbl
pid	    fid
1	    2
1	    3
2	    1
2	    3
3	    4
4	    5
4	    6
5	    7
5	    8
6	    9
7	    10
7	    11

Expected Output

pid	    total_friend_score	no_of_friends	    person_name
2	        115	                2	            Rohit
4	        115	                2	            Pooja
5	        110	                2	            Rahul


*/



with totalFriendScoreTBL as (
select f.pid, sum(p.score ) as total_friend_score, count(*) as no_of_friends
from person p 
inner join friend f
on p.personID = f.fid
group by f.pid
having sum(p.score) > 100)

select tf.* , p.name as person_name
from totalFriendScoreTBL as tf
inner join person p on tf.pid = p.personID
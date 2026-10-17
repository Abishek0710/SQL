/*
You are given a seat occupancy table.

Each row represents a seat

is_empty = 'Y' → seat is empty

is_empty = 'N' → seat is occupied

👉 Task:
Find all seat numbers that are part of a group of 3 or more consecutive empty seats.

📊 Table Structure

CREATE TABLE bms (
    seat_no INT,
    is_empty VARCHAR(10)
);

input data

seat_no	is_empty
1	N
2	Y
3	N
4	Y
5	Y
6	Y
7	N
8	Y
9	Y
10	Y
11	Y
12	N
13	Y
14	Y

Expected Output

seat_no	is_empty	prev_1	prev_2	next_1	next_2
4	        Y	        N	    Y	    Y	    Y
5	        Y	        Y	    N	    Y	    N
6	        Y	        Y	    Y	    N	    Y
8	        Y	        N	    Y	    Y	    Y
9	        Y	        Y	    N	    Y	    Y
10	        Y	        Y	    Y	    Y	    N
11	        Y	        Y	    Y	    N	    Y


*/


select * from(

Select *,
lag(is_empty,1) over(order by seat_no asc) as prev_1,
lag(is_empty,2) over(order by seat_no asc) as prev_2,
lead(is_empty,1) over(order by seat_no asc) as next_1,
lead(is_empty,2) over(order by seat_no asc) as next_2
from bms order by seat_no
)

where (is_empty = 'Y' and prev_2 = 'Y' and next_1 = 'Y' and next_2 = 'Y')
OR (is_empty = 'Y' and prev_1 = 'Y' and next_1 = 'Y' )
OR (is_empty = 'Y' and prev_1 = 'Y' and prev_2 = 'Y' and next_2 = 'Y')
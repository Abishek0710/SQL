/*

You are given an exam table that stores student marks for different subjects.

Each student may appear in:

Physics

Chemistry

Other subjects (optional)

👉 Write an SQL query to find students who:

Appeared in both Physics and Chemistry

Scored exactly the same marks in Physics and Chemistry

🧱 Table Schema

CREATE TABLE exams (
    student_id INT,
    subject VARCHAR(20),
    marks INT
);



Input data:
student_id	subject	    marks
1	        Physics	    92
1	        Chemistry	92
2	        Physics	    80
2	        Chemistry	90
3	        Chemistry	85
4	        Physics	    78
5	        Physics	    88
5	        Chemistry	88
6	        Physics 	70
6	        Chemistry	75
7	        Chemistry	91
7	        Physics	    91
8	        Physics	    60
8	        Chemistry	60
8	        Maths	    85
9	        Maths	    90
10	        Physics	    83
10	        Chemistry	83


Expected Output:

student_id
1
5
7
8
10
*/


Select student_id from exams
where subject in ('Chemistry', 'Physics')
group by student_id
having count(distinct subject) = 2 and count(distinct marks) = 1;
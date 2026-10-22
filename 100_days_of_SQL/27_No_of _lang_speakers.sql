/*

You are given a table company_users that stores information about which language each user speaks in a company.

A user can speak multiple languages, hence the same (company_id, user_id) may appear multiple times with different languages.

✅ Requirement

Write a SQL query to find company IDs that have at least two users who speak both English and German.

⚠️ Important Clarifications

A user must speak both English and German (not just one)

At least two different users in the same company must satisfy this condition

Users speaking additional languages should still be counted if they also speak English & German

🗂️ Table Schema

CREATE TABLE company_users (
    company_id INT,
    user_id INT,
    language VARCHAR(20)
);

Input data:

company_id	user_id	    language
1	            1	    English
1	            1	    German
1	            2	    English
1	            3	    English
1	            3	    German
1	            4	    English
2	            5	    English
2	            5	    German
2	            5	    Spanish
2	            6	    German
2	            6	    Spanish
2	            7	    English
3	            8	    English
3	            8	    German
3	            9	    English
3	            9	    German
3	            10	    French
4	            11	    English
4	            12	    German
4	            13	    English
5	            14	    German
5	            14	    English
5	            15	    German
5	            15	    English
5	            16	    Spanish

Expected Output:
company_id	No_of_users
1	            2
3	            2
5	            2


*/


select company_id, count(1) as No_of_users from 
(
Select company_id, user_id, count(1) 
from company_users
where language in ('English', 'German')
group by company_id,user_id
having count(1) >= 2
)
group by company_id
having count(*) >= 2

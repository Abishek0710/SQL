/*

You are given a table containing match information from a tournament.
Each record represents a match between two teams and the winner of that match.

Write a SQL query to generate a points table that shows for each team:

Matches played

Wins

Losses

Points (2 points per win)

📂 Table Structure

create table icc_world_cup
(
    team_1 varchar(20),
    team_2 varchar(20),
    winner varchar(20)
);

ans structure:
team_name	        no_of_matches_played	no_of_matches_won	no_of_losses
India	            6	                            5	            1
Pakistan	        6	                            4	            2
New Zealand	        6	                            4	            2
England	            7	                            4	            3
South Africa       	5	                            3	            2
Australia	        5	                            2	            3
Sri Lanka	        7	                            1	            6
Bangladesh	        4	                            0	            4

*/



select team_name,
count(*) as no_of_matches_played, 
sum(no_of_matches_won) as no_of_matches_won,
count(*) - sum(no_of_matches_won) as no_of_losses
from
(
select Team_1 as team_name, case when Team_1 = Winner then 1 else 0 end as no_of_matches_won from icc_world_cup 
union all
select Team_2 as team_name, case when Team_2 = Winner then 1 else 0 end as no_of_matches_won from icc_world_cup ) as A
group by team_name order by no_of_matches_won desc

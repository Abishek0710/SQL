/*

You are given two tables:

players – contains player information and their group

matches – contains match results between two players

Each player belongs to one group only.

Each match has:

two players

score of both players

🎯 Objective

Write an SQL query to find the tournament winner for each group.

🏆 Winner Rules

For each group, calculate total score per player

The player with the maximum total score in a group is the winner

Tie-breaker:

If multiple players have the same score, the lowest player_id wins

🧱 Table Structures

CREATE TABLE players
(
  player_id INT,
  group_id INT
);
 
CREATE TABLE matches
(
  match_id INT,
  first_player INT,
  second_player INT,
  first_score INT,
  second_score INT
);

input data:

players:
player_id	group_id
15	            1
30	            1
45	            1
60	            1
10	            2
20	            2
25	            3
35	            3

matches:
match_id	first_player	second_player	first_score	second_score
1	            15	            45	            3	        0
2	            30	            60	            1	        2
3	            15	            30	            0	        2
4	            45	            60	            1	        1
5	            15	            60	            2	        2
6	            30	            45	            3	        1
7	            10	            20	            1	        1
8	            10	            20	            2	        0
9	            25	            35	            2	        2
10	            25	            35	            1	        0
11	            15	            45	            1	        1
12	            30	            60	            0	        0
13	            10	            20	            0	        2
14	            25	            35	            0	        1
15	            45	            60	            3	        2
16	            15	            30	            1	        1

Expected Output:

group_id	player_id	score
1	15	7
2	10	3
3	25	3

*/

with all_players as (
select first_player  as player_id , first_score  as score  from matches
union all
select second_player  as player_id , second_score  as score  from matches)
, 
total_scores as(
select p.group_id, ap.player_id, sum(ap.score) as score
from all_players ap
inner join players p
on ap.player_id = p.player_id
group by 1,2)
, 
score_ranking as(
select *, 
rank() over(partition by group_id order by score desc, player_id asc) as rn
from total_scores)

select group_id, player_id,	score
from score_ranking
where rn =1

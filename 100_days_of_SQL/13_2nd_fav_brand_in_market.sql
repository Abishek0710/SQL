/*

You are given three tables:

users – contains seller information and their favorite brand

orders – contains order details with buyer and seller IDs

items – contains item and brand information

🎯 Objective

Write an SQL query to determine for each seller whether the brand of the second item they sold matches their favorite brand.

📌 Rules

Orders should be considered in chronological order (order_date)

If a seller has sold fewer than 2 items, return 'no'

Output columns:

seller_id

second_item_fav_brand → 'yes' or 'no'

🧱 Table Definitions (As Given)

CREATE TABLE users 
(
  user_id         INT,
  join_date       TEXT,
  favorite_brand  VARCHAR(50)
);
 
CREATE TABLE orders 
(
  order_id   INT,
  order_date TEXT,
  item_id    INT,
  buyer_id   INT,
  seller_id  INT
);
 
CREATE TABLE items
(
  item_id    INT,
  item_brand VARCHAR(50)
);

Input Data:

users:
user_id	    join_date	    favorite_brand
1	        2019-01-01	    Lenovo
2	        2019-02-09	    Samsung
3	        2019-01-19	    LG
4	        2019-05-21	    HP

orders:
order_id	order_date	    item_id	    buyer_id	seller_id
1	        2019-08-01	        4	        1	        2
2	        2019-08-02	        2	        1	        3
3	        2019-08-03	        3	        2	        3
4	        2019-08-04	        1	        4	        2
5	        2019-08-04	        1	        3	        4
6	        2019-08-05	        2	        2	        4

items:
item_id	    item_brand
1	        Samsung
2	        Lenovo
3	        LG
4	        HP

Expected Output:
seller_id	    item_fav_brand
1	            No
2	            Yes
3	            Yes
4	            No

*/

-- giving ranking based on order_date 
with order_date_rnk as
(select *,
rank() over(partition by seller_id order by order_date ) as rnk
from orders)

-- getting all the data by combining users, order_date_rnk and items tables
-- users tbl is used first so that all sellers are included in the output even if they have sold less than 2 items
select u.user_id as seller_id,
case when u.favorite_brand = i.item_brand then 'Yes' else 'No' end as item_fav_brand
from users u
left join order_date_rnk o on u.user_id = o.seller_id and o.rnk = 2
left join items i on o.item_id = i.item_id


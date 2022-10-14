/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Average Post Hiatus (Part 1)
	   URL:		https://datalemur.com/questions/sql-average-post-hiatus-1

Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

p.s. If you've read the Ace the Data Science Interview and liked it, consider writing us a review?

posts Table:
Column Name	Type
user_id	integer
post_id	integer
post_date	timestamp
post_content	timestamp
posts Example Input:
user_id	post_id	post_date	post_content
151652	599415	07/10/2021 12:00:00	Need a hug
661093	624356	07/29/2021 13:00:00	Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that's gonna fly by. I miss my girlfriend
004239	784254	07/04/2021 11:00:00	Happy 4th of July!
661093	442560	07/08/2021 14:00:00	Just going to cry myself to sleep after watching Marley and Me.
151652	111766	07/12/2021 19:00:00	I'm so done with covid - need travelling ASAP!
Example Output:
user_id	days_between
151652	2
661093	21



*********************************************************************************
*/

WITH CTE1 AS (
SELECT user_id, COUNT(user_id) AS count
FROM posts 
WHERE EXTRACT('year' FROM post_date)=2021
GROUP BY user_id
HAVING COUNT(user_id)>=2
),

CTE2 AS (
SELECT P.user_id AS user_id, MIN(post_date) AS mindate, MAX(post_date) AS maxdate
FROM posts P INNER JOIN CTE1
ON P.user_id=CTE1.user_id
GROUP BY P.user_id
)

SELECT user_id, date_part('day', maxdate-mindate) AS days_between
FROM CTE2
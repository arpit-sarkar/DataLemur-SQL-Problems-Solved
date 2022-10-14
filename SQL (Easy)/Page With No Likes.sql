/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Page With No Likes
	   URL:		https://datalemur.com/questions/sql-page-with-no-likes

Assume you are given the tables below about Facebook pages and page likes. Write a query to return the page IDs of all the Facebook pages that don't have any likes. The output should be in ascending order.

pages Table:
Column Name	Type
page_id	integer
name	varchar
pages Example Input:
page_id	name
20001	SQL Solutions
20045	Brain Exercises
20701	Tips for Data Analysts
page_likes Table:
Column Name	Type
user_id	integer
page_id	integer
liked_date	datetime
page_likes Example Input:
user_id	page_id	liked_date
111	20001	04/08/2022 00:00:00
121	20045	03/12/2022 00:00:00
156	20001	07/25/2022 00:00:00
Example Output:
page_id
20701
Explanation: The page with ID 20701 has no likes.


*********************************************************************************
*/

SELECT P.page_id--, COUNT(liked_date)
FROM pages P LEFT JOIN page_likes L
ON P.page_id=L.page_id
GROUP BY P.page_id
HAVING COUNT(liked_date)=0
ORDER BY P.page_id
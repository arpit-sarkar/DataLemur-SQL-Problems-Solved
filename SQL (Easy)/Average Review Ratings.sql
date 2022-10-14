/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Average Review Ratings
	   URL:		https://datalemur.com/questions/sql-avg-review-ratings

Given the reviews table, write a query to get the average stars for each product every month.

The output should include the month in numerical value, product id, and average star rating rounded to two decimal places. Sort the output based on month followed by the product id.

P.S. If you've read the Ace the Data Science Interview, and liked it, consider writing us a review?

reviews Table:
Column Name	Type
review_id	integer
user_id	integer
submit_date	datetime
product_id	integer
stars	integer (1-5)
reviews Example Input:
review_id	user_id	submit_date	product_id	stars
6171	123	06/08/2022 00:00:00	50001	4
7802	265	06/10/2022 00:00:00	69852	4
5293	362	06/18/2022 00:00:00	50001	3
6352	192	07/26/2022 00:00:00	69852	3
4517	981	07/05/2022 00:00:00	69852	2
Example Output:
mth	product	avg_stars
6	50001	3.50
6	69852	4.00
7	69852	2.50
Explanation
In June (month #6), product 50001 had two ratings - 4 and 3, resulting in an average star rating of 3.5.


*********************************************************************************
*/

SELECT EXTRACT(MONTH FROM submit_date) AS mth,
product_id  AS product, ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY product_id, EXTRACT(MONTH FROM submit_date)
ORDER BY mth, product_id
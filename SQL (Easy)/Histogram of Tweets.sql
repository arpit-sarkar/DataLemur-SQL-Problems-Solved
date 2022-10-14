/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Histogram of Tweets
	   URL:		https://datalemur.com/questions/sql-histogram-tweets

This is the same question as problem #6 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below containing tweet data. Write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket, and then the number of Twitter users who fall into that bucket.

tweets Table:
Column Name	Type
tweet_id	integer
user_id	integer
msg	string
tweet_date	timestamp
tweets Example Input:
tweet_id	user_id	msg	tweet_date
214252	111	Am considering taking Tesla private at $420. Funding secured.	12/30/2021 00:00:00
739252	111	Despite the constant negative press covfefe	01/01/2022 00:00:00
846402	111	Following @NickSinghTech on Twitter changed my life!	02/14/2022 00:00:00
241425	254	If the salary is so competitive why won’t you tell me what it is?	03/01/2022 00:00:00
231574	148	I no longer have a manager. I can't be managed	03/23/2022 00:00:00
Example Output:
tweet_bucket	users_num
1	2
2	1
Explanation: 2 users fall under the 1 tweet bucket whereas 1 user is in the 2 tweets bucket.


*********************************************************************************
*/

WITH CTE1 AS(
SELECT user_id, COUNT(tweet_id) AS tweet_bucket
FROM tweets
WHERE EXTRACT(YEAR FROM tweet_date)=2022
GROUP BY user_id
)

SELECT DISTINCT tweet_bucket, COUNT(user_id) AS users_num
FROM CTE1
GROUP BY tweet_bucket
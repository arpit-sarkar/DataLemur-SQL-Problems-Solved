/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Tweets' Rolling Averages
	   URL:		https://datalemur.com/questions/rolling-average-tweets

This is the same question as problem #10 in the SQL Chapter of Ace the Data Science Interview!

The table below contains information about tweets over a given period of time. Calculate the 3-day rolling average of tweets published by each user for each date that a tweet was posted. Output the user id, tweet date, and rolling averages rounded to 2 decimal places.

Important Assumptions:

Rows in this table are consecutive and ordered by date.
Each row represents a different day
A day that does not correspond to a row in this table is not counted. The most recent day is the next row above the current row.
Note: Rolling average is a metric that helps us analyze data points by creating a series of averages based on different subsets of a dataset. It is also known as a moving average, running average, moving mean, or rolling mean.

tweets Table:
Column Name	Type
tweet_id	integer
user_id	integer
tweet_date	timestamp
tweets Example Input:
tweet_id	user_id	tweet_date
214252	111	06/01/2022 12:00:00
739252	111	06/01/2022 12:00:00
846402	111	06/02/2022 12:00:00
241425	254	06/02/2022 12:00:00
137374	111	06/04/2022 12:00:00
Example Output:
user_id	tweet_date	rolling_avg_3days
111	06/01/2022 12:00:00	2.00
111	06/02/2022 12:00:00	1.50
111	06/04/2022 12:00:00	1.33
254	06/02/2022 12:00:00	1.00
Explanation
User 111 made 2 tweets on 06/01/2022, and 1 tweet the next day. By 06/02/2022, the user had made in total 3 tweets over the course of 2 days; thus, the rolling average is 3/2=1.5. By 06/04/2022, there are 4 tweets that were made during 3 days: 4/3 = 1.33 rolling average.

*********************************************************************************
*/

WITH CTE1 AS (
SELECT user_id, tweet_date, 
COUNT(tweet_id) AS tweet_count
FROM tweets
GROUP BY user_id, tweet_date
ORDER BY user_id, tweet_date
)

SELECT user_id, tweet_date, --tweet_count, 
ROUND(AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY tweet_date 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3days
FROM CTE1
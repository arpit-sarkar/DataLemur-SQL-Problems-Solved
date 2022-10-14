/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Apple Pay Volume
	   URL:		https://datalemur.com/questions/sql-app-ctr

This is the same question as problem #1 in the SQL Chapter of Ace the Data Science Interview!

Assume you have an events table on app analytics. Write a query to get the click-through rate (CTR %) per app in 2022. Output the results in percentages rounded to 2 decimal places.

Notes:

To avoid integer division, you should multiply the click-through rate by 100.0, not 100.
Percentage of click-through rate = 100.0 * Number of clicks / Number of impressions
events Table:
Column Name	Type
app_id	integer
event_type	string
timestamp	datetime
events Example Input:
app_id	event_type	timestamp
123	impression	07/18/2022 11:36:12
123	impression	07/18/2022 11:37:12
123	click	07/18/2022 11:37:42
234	impression	07/18/2022 14:15:12
234	click	07/18/2022 14:16:12
Example Output:
app_id	ctr
123	50.00
234	100.00
Explanation
App 123 has a CTR of 50.00% because this app receives 1 click out of the 2 impressions. Hence, it's 1/2 = 50.00%.

*********************************************************************************
*/

WITH CTE1 AS (
SELECT app_id,
SUM(CASE WHEN event_type='click' THEN 1 ELSE 0 END)*1.00 AS clicks,
SUM(CASE WHEN event_type='impression' THEN 1 ELSE 0 END)*1.00 AS impressions
FROM events
WHERE EXTRACT('year' FROM timestamp)=2022
GROUP BY app_id
)

SELECT app_id, ROUND(clicks/impressions*100, 2) AS ctr
FROM CTE1
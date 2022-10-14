/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Odd and Even Measurements
	   URL:		https://datalemur.com/questions/odd-even-measurements

This is the same question as problem #28 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below containing measurement values obtained from a sensor over several days. Measurements are taken several times within a given day.

Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two different columns.

Note that the 1st, 3rd, 5th measurements within a day are considered odd-numbered measurements and the 2nd, 4th, 6th measurements are even-numbered measurements.

measurements Table:
Column Name	Type
measurement_id	integer
measurement_value	decimal
measurement_time	datetime
measurements Example Input:
measurement_id	measurement_value	measurement_time
131233	1109.51	07/10/2022 09:00:00
135211	1662.74	07/10/2022 11:00:00
523542	1246.24	07/10/2022 13:15:00
143562	1124.50	07/11/2022 15:00:00
346462	1234.14	07/11/2022 16:45:00
Example Output:
measurement_day	odd_sum	even_sum
07/10/2022 00:00:00	2355.75	1662.74
07/11/2022 00:00:00	1124.50	1234.14
Explanation
On 07/11/2022, there are only two measurements. In chronological order, the first measurement (odd-numbered) is 1124.50, and the second measurement(even-numbered) is 1234.14.

*********************************************************************************
*/

WITH CTE1 AS (
SELECT DATE_TRUNC('day', measurement_time) AS measurement_day,
CAST(measurement_time AS TIME) AS measurement_mins, *
FROM measurements
), 

CTE2 AS (
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY measurement_day ORDER BY measurement_mins) AS RN
FROM CTE1
)

SELECT measurement_day,
SUM(CASE WHEN MOD(RN, 2)=1 THEN measurement_value ELSE 0 END) AS odd_sum,
SUM(CASE WHEN MOD(RN, 2)=0 THEN measurement_value ELSE 0 END) AS even_sum
FROM CTE2
GROUP BY measurement_day
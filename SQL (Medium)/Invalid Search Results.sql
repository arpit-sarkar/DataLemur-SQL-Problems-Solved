/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Invalid Search Results
	   URL:		https://datalemur.com/questions/invalid-search-pct

Assume you are given the table below containing the information on the searches attempted and the percentage of invalid searches by country. Write a query to obtain the percentage of invalid search result.

Output the country (in ascending order), total number of searches and percentage of invalid search rounded to 2 decimal places.

Note that to find the percentages, multiply by 100.0 and not 100 to avoid integer division.

Definition and assumptions:

num_search is the number of searches attempted and invalid_result_pct is the percentage of invalid searches.
In cases where countries has search attempts but does not have an invalid result percentage, it should be excluded, and vice versa.
search_category Table:
Column Name	Type
country	string
search_cat	string
num_search	integer
invalid_result_pct	decimal
search_category Example Input:
country	search_cat	num_search	invalid_result_pct
UK	home	null	null
UK	tax	98000	1.00
UK	travel	100000	3.25
Example Output:
country	total_search	invalid_result_pct
UK	198000	2.14
Example: UK had 98,000 * 1% + 100,000 x 3.25% = 4,230 invalid searches, out of the total 198,000 searches, resulting in a percentage of 2.14%.

*********************************************************************************
*/

WITH CTE1 AS (
SELECT *,  0.01*invalid_result_pct*num_search AS num_invalid
FROM search_category
WHERE num_search IS NOT NULL AND invalid_result_pct IS NOT NULL
)

SELECT country, SUM(num_search) AS total_search, ROUND(sum(num_invalid)*1.00/SUM(num_search)*100, 2) AS invalid_result_pct
FROM CTE1
GROUP BY country



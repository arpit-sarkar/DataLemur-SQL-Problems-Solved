/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Photoshop Revenue Analysis
	   URL:		https://datalemur.com/questions/photoshop-revenue-analysis

For every customer that bought Photoshop, return a list of the customers, and the total spent on all the products except for Photoshop products.

Sort your answer by customer ids in ascending order.

adobe_transactions Table:
Column Name	Type
customer_id	integer
product	string
revenue	integer
adobe_transactions Example Input:
customer_id	product	revenue
123	Photoshop	50
123	Premier Pro	100
123	After Effects	50
234	Illustrator	200
234	Premier Pro	100
Example Output:
customer_id	revenue
123	150
Explanation: User 123 bought Photoshop, Premier Pro + After Effects, spending $150 for those products. We don't output user 234 because they didn't buy Photoshop.

*********************************************************************************
*/

SELECT customer_id, SUM(revenue) AS revenue
FROM adobe_transactions 
WHERE customer_id NOT IN (
    SELECT customer_id 
    FROM adobe_transactions
    GROUP BY customer_id
    HAVING SUM(CASE WHEN product='Photoshop' THEN 1 ELSE 0 END)=0
)
AND product<>'Photoshop'
GROUP BY customer_id


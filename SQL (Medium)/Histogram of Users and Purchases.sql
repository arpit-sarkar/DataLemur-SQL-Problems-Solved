/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Histogram of Users and Purchases
	   URL:		https://datalemur.com/questions/histogram-users-purchases

This is the same question as problem #13 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the below table on transactions from users. Bucketing users based on their latest transaction date, write a query to obtain the number of users who made a purchase and the total number of products bought for each transaction date.

Output the transaction date, number of users and number of products.

user_transactions Table:
Column Name	Type
product_id	integer
user_id	integer
spend	decimal
transaction_date	timestamp
user_transactions Example Input:
product_id	user_id	spend	transaction_date
3673	123	68.90	07/08/2022 12:00:00
9623	123	274.10	07/08/2022 12:00:00
1467	115	19.90	07/08/2022 12:00:00
2513	159	25.00	07/08/2022 12:00:00
1452	159	74.50	07/10/2022 12:00:00
Example Output:
transaction_date	number_of_users	number_of_products
07/08/2022 12:00:00	2	3
07/10/2022 12:00:00	1	1


*********************************************************************************
*/

WITH CTE1 AS (
SELECT *, RANK() OVER (PARTITION BY user_id ORDER BY transaction_date DESC) AS RN
FROM user_transactions
)

SELECT transaction_date, COUNT(DISTINCT user_id) AS number_of_users,
COUNT (product_id) AS number_of_products
FROM CTE1 WHERE RN=1
GROUP BY transaction_date



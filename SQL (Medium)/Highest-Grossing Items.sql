/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Highest-Grossing Items
	   URL:		https://datalemur.com/questions/sql-highest-grossing

This is the same question as problem #12 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below containing information on Amazon customers and their spend on products belonging to various categories. Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend.

product_spend Table:
Column Name	Type
category	string
product	string
user_id	integer
spend	decimal
transaction_date	timestamp
product_spend Example Input:
category	product	user_id	spend	transaction_date
appliance	refrigerator	165	246.00	12/26/2021 12:00:00
appliance	refrigerator	123	299.99	03/02/2022 12:00:00
appliance	washing machine	123	219.80	03/02/2022 12:00:00
electronics	vacuum	178	152.00	04/05/2022 12:00:00
electronics	wireless headset	156	249.90	07/08/2022 12:00:00
electronics	vacuum	145	189.00	07/15/2022 12:00:00
Example Output:
category	product	total_spend
appliance	refrigerator	299.99
appliance	washing machine	219.80
electronics	vacuum	341.00
electronics	wireless headset	249.90


*********************************************************************************
*/

SELECT category, product, spend FROM 
(
  SELECT category, product, SUM(spend) AS spend,
  RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS RN
  FROM product_spend
  WHERE EXTRACT('YEAR' FROM transaction_date)=2022
  GROUP BY category, product
) temp
WHERE RN<=2
/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Cumulative Purchases by Product Type
	   URL:		https://datalemur.com/questions/sql-purchasing-activity

This is the same question as problem #4 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below for the purchasing activity by order date and product type. Write a query to calculate the cumulative purchases for each product type over time in chronological order.

Output the order date, product, and the cumulative number of quantities purchased.

total_trans Table:
Column Name	Type
order_id	integer
product_type	string
quantity	integer
order_date	datetime
total_trans Example Input:
order_id	product_type	quantity	order_date
213824	printer	20	06/27/2022 12:00:00
132842	printer	18	06/28/2022 12:00:00
Example Output:
order_date	product_type	cum_purchased
06/27/2022 12:00:00	printer	20
06/28/2022 12:00:00	printer	38
Explanation
On 06/27/2022, 20 printers were purchased. Subsequently, on 06/28/2022, 38 printers were purchased cumulatively (20 + 18 printers).


*********************************************************************************
*/

SELECT order_date, product_type, 
SUM(quantity) OVER (PARTITION BY product_type ORDER BY order_date) AS cum_purchased
FROM total_trans
ORDER BY order_date
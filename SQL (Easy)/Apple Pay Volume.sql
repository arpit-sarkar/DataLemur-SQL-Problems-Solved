/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Apple Pay Volume
	   URL:		https://datalemur.com/questions/apple-pay-volume

Visa is trying to analyze its Apply Pay partnership. Calculate the total transaction volume for each merchant where the transaction was performed via Apple Pay.

Output the merchant ID and the total transactions by merchant. For merchants with no Apple Pay transactions, output their total transaction volume as 0.

Display the result in descending order of transaction volume.

transactions Table:
Column Name	Type
merchant_id	integer
transaction_amount	integer
payment_method	varchar
transactions Example Input:
merchant_id	transaction_amount	payment_method
1	600	Contactless Chip
1	850	Apple Pay
1	500	Apple Pay
2	560	Magstripe
2	400	Samsung Pay
4	1200	apple pay
Example Output:
merchant_id	volume
1	1350
4	1200
2	0
Explanation
Merchant 1 has made two Apple Pay purchases totalling $1,350, Merchant 4 has completed one Apple Pay transaction costing $1,200, and Merchant 2 has not completed any Apple Pay transactions.

*********************************************************************************
*/

SELECT merchant_id, 
SUM(CASE WHEN LOWER(payment_method)='apple pay' THEN transaction_amount ELSE 0 END) AS volume
FROM transactions
GROUP BY merchant_id
ORDER BY volume DESC
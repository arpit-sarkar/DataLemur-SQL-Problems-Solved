/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Unique Money Transfer Relationships
	   URL:		https://datalemur.com/questions/money-transfer-relationships

You are given a table of PayPal payments showing the payer, the recipient, and the amount paid. A two-way unique relationship is established when two people send money back and forth. Write a query to find the number of two-way unique relationships in this data.

Assumption:

A payer can send money to the same recipient multiple times.
payments Table:
Column Name	Type
payer_id	integer
recipient_id	integer
amount	integer
payments Example Input:
payer_id	recipient_id	amount
101	201	30
201	101	10
101	301	20
301	101	80
201	301	70
Example Output:
unique_relationships
2
Explanation
There are 2 unique two-way relationships between:

ID 101 and ID 201
ID 101 and ID 301


*********************************************************************************
*/

WITH CTE1 AS (
SELECT DISTINCT P1.payer_id, P1.recipient_id--, P2.payer_id, P2.recipient_id
FROM payments P1 INNER JOIN payments P2
ON P1.recipient_id=P2.payer_id
WHERE P1.recipient_id=P2.payer_id AND P2.recipient_id=P1.payer_id
)

SELECT COUNT(payer_id)/2 AS unique_relationships
FROM CTE1
/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Final Account Balance
	   URL:		https://datalemur.com/questions/final-account-balance

Given a table of bank deposits and withdrawals, return the final balance for each account.

Assumption:

All the transactions performed for each account are present in the table; no transactions are missing.
transactions Table:
Column Name	Type
transaction_id	integer
account_id	integer
transaction_type	varchar
amount	decimal
transactions Example Input:
transaction_id	account_id	transaction_type	amount
123	101	Deposit	10.00
124	101	Deposit	20.00
125	101	Withdrawal	5.00
126	201	Deposit	20.00
128	201	Withdrawal	10.00
Example Output:
account_id	final_balance
101	25.00
201	10.00
Explanation:
In total, $30.00 were deposited to account 101, and $5.00 were withdrawn. Therefore, the final balance will


*********************************************************************************
*/

SELECT account_id,
(
  SUM(CASE WHEN transaction_type='Deposit' THEN amount ELSE 0 END) -
  SUM(CASE WHEN transaction_type='Withdrawal' THEN amount ELSE 0 END)
) AS final_balance
FROM transactions
GROUP BY account_id
ORDER BY account_id
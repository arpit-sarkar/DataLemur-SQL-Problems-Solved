/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Signup Confirmation Rate
	   URL:		https://datalemur.com/questions/signup-confirmation-rate

New TikTok users sign up with their emails, so each signup requires a text confirmation to activate the new user's account.

Write a query to find the confirmation rate of users who confirmed their signups with text messages. Round the result to 2 decimal places.

Assumptions:

A user may fail to confirm several times with text. Once the signup is confirmed for a user, they will not be able to initiate the signup again.
A user may not initiate the signup confirmation process at all.
emails Table:
Column Name	Type
email_id	integer
user_id	integer
signup_date	datetime
emails Example Input:
email_id	user_id	signup_date
125	7771	06/14/2022 00:00:00
236	6950	07/01/2022 00:00:00
433	1052	07/09/2022 00:00:00
texts Table:
Column Name	Type
text_id	integer
email_id	integer
signup_action	varchar
texts Example Input:
text_id	email_id	signup_action
6878	125	Confirmed
6920	236	Not Confirmed
6994	236	Confirmed
Example Output:
confirm_rate
0.67
Explanation
This output indicates that 67% of users have successfully confirmed their signup. The other 33% have either not initiated signup, or their signup is not confirmed yet.

*********************************************************************************
*/

WITH findingConfirmRate AS (
SELECT 
COUNT(email_id)*1.00/(SELECT COUNT(DISTINCT emails)*1.00 FROM emails) AS confirm_rate
FROM texts 
WHERE signup_action='Confirmed'
)

SELECT ROUND(confirm_rate, 2) AS confirm_rate
FROM findingConfirmRate
/*
DIFFICULTY: 	Easy
 CHALLENGE: 	Second Day Confirmation
	   URL:		https://datalemur.com/questions/second-day-confirmation

New TikTok users sign up with their emails and each user receives a text confirmation to activate their account. Assume you are given the below tables about emails and texts.

Write a query to display the ids of the users who did not confirm on the first day of sign-up, but confirmed on the second day.

Assumption:

action_date is the date when the user activated their account and confirmed their sign-up through the text.
emails Table:
Column Name	Type
email_id	integer
user_id	integer
signup_date	datetime
emails Example Input:
email_id	user_id	signup_date
125	7771	06/14/2022 00:00:00
433	1052	07/09/2022 00:00:00
texts Table:
Column Name	Type
text_id	integer
email_id	integer
signup_action	string ('Confirmed', 'Not confirmed')
action_date	datetime
texts Example Input:
text_id	email_id	signup_action	action_date
6878	125	Confirmed	06/14/2022 00:00:00
6997	433	Not Confirmed	07/09/2022 00:00:00
7000	433	Confirmed	07/10/2022 00:00:00
Example Output:
user_id
1052
Explanation: User 1052 is the only user who confirmed their sign up on the second day.

*********************************************************************************
*/

SELECT user_id 
FROM emails E INNER JOIN texts T
ON E.email_id=T.email_id
WHERE signup_action='Confirmed' AND DATE_PART('day', action_date-signup_date)=1
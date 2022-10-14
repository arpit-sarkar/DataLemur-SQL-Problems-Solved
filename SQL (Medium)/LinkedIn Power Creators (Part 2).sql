/*
DIFFICULTY: 	Medium
 CHALLENGE: 	LinkedIn Power Creators (Part 2)
	   URL:		https://datalemur.com/questions/linkedin-power-creators-part2

The LinkedIn Creator team is looking for power creators who use their personal profile as a company or influencer page. If someone's LinkedIn page has more followers than the company they work for, we can safely assume that person is a power creator.

Write a query to return the IDs of these LinkedIn power creators in ascending order.

Assumption:

A person can work at multiple companies.
This is the second part of the question, so make sure your start with Part 1 if you haven't completed that yet!

personal_profiles Table:
Column Name	Type
profile_id	integer
name	string
followers	integer
personal_profiles Example Input:
profile_id	name	followers
1	Nick Singh	92,000
2	Zach Wilson	199,000
3	Daliana Liu	171,000
4	Ravit Jain	107,000
5	Vin Vashishta	139,000
6	Susan Wojcicki	39,000
employee_company Table:
Column Name	Type
personal_profile_id	integer
company_id	integer
employee_company Example Input:
personal_profile_id	company_id
1	4
1	9
2	2
3	1
4	3
5	6
6	5
company_pages Table:
Column Name	Type
company_id	integer
name	string
followers	integer
company_pages Example Input:
company_id	name	followers
1	The Data Science Podcast	8,000
2	Airbnb	700,000
3	The Ravit Show	6,000
4	DataLemur	200
5	YouTube	1,6000,000
6	DataScience.Vin	4,500
9	Ace The Data Science Interview	4479
Example Output:
profile_id
1
3
4
5
This output shows that profile IDs 1-5 are all power creators, meaning that they have more followers than their each of their company pages, whether they work for 1 company or 3.


*********************************************************************************
*/

SELECT DISTINCT P.profile_id
FROM personal_profiles P INNER JOIN employee_company E
ON P.profile_id=E.personal_profile_id
INNER JOIN company_pages C
ON E.company_id=C.company_id
WHERE P.followers>C.followers AND P.profile_id NOT IN
(
    SELECT P.profile_id
    FROM personal_profiles P INNER JOIN employee_company E
    ON P.profile_id=E.personal_profile_id
    INNER JOIN company_pages C
    ON E.company_id=C.company_id
    WHERE P.followers<C.followers
)
ORDER BY P.profile_id
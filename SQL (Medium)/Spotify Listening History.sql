/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Spotify Listening History
	   URL:		https://datalemur.com/questions/spotify-listening-history

You are given a songs_history table that keeps track of users' listening history on Spotify. The songs_weekly table tracks how many times users listened to each song for all days between August 1 and August 7, 2022.

Write a query to show the user ID, song ID, and the number of times the user has played each song as of August 4, 2022. We'll refer to the number of song plays as song_plays. The rows with the most song plays should be at the top of the output.

Assumption:

The songs_history table holds data that ends on July 31, 2022. Output should include the historical data in this table.
There may be a new user in the weekly table who is not present in the history table.
A user may listen to a song for the first time, in which case no existing (user_id, song_id) user-song pair exists in the history table.
A user may listen to a specific song multiple times in the same day.
songs_history Table:
Column Name	Type
history_id	integer
user_id	integer
song_id	integer
song_plays	integer
songs_history Example Input:
history_id	user_id	song_id	song_plays
10011	777	1238	11
12452	695	4520	1
songs_weekly Table:
Column Name	Type
user_id	integer
song_id	integer
listen_time	datetime
songs_weekly Example Input:
user_id	song_id	listen_time
777	1238	08/01/2022 12:00:00
695	4520	08/04/2022 08:00:00
125	9630	08/04/2022 16:00:00
695	9852	08/07/2022 12:00:00
Example Output:
user_id	song_id	song_plays
777	1238	12
695	4520	2
125	9630	1
Up to August 4, 2022, user_id 777 has listened to the song_id 1238 12 times. user_id 695 with song_id 9852 is excluded from the output because their listening time on August 8, 2022 is not within the the question's requirement (which is up to August 4, 2022 only).

*********************************************************************************
*/

WITH CTE1 AS (
SELECT user_id, song_id, song_plays
FROM songs_history 
UNION ALL
SELECT user_id, song_id, COUNT(song_id) AS song_plays
FROM songs_weekly 
WHERE EXTRACT('DAY' FROM listen_time)<05
GROUP BY user_id, song_id
)

SELECT user_id, song_id, SUM(song_plays) AS song_plays
FROM CTE1
GROUP BY user_id, song_id
ORDER BY song_plays DESC
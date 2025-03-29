USE Spotify; 
DROP TABLE IF EXISTS df_spotify;

-- create table
CREATE TABLE df_spotify (
	id INT PRIMARY KEY, 
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energyliveness FLOAT,
    most_playedon VARCHAR(50)
);

-- Find artists and their respective tracks which have more than 1 billion streams

SELECT artist, track, stream
FROM df_spotify
WHERE stream > 1000000000
ORDER BY stream DESC;

-- Find the top 3 most-viewed tracks for each artist

SELECT artist, track, total_views
FROM ( 
	SELECT artist, track, SUM(views) as total_views,
	DENSE_RANK() OVER(PARTITION BY ARTIST ORDER BY SUM(views) DESC) as rn
	FROM df_spotify
    GROUP BY artist, track) t
WHERE rn <= 3
ORDER BY artist, total_views DESC;

-- Count the total number of views, likes and comments for each artist 

SELECT artist, SUM(views) AS total_views, 
SUM(likes) AS total_likes,
SUM(comments) AS total_comments
FROM df_spotify
GROUP BY artist
ORDER BY total_views DESC;


-- Calculate average music features per artist 

SELECT artist, ROUND(AVG(energy),2), ROUND(AVG(danceability),2), 
ROUND(AVG(tempo),2)
FROM df_spotify
GROUP BY artist; 

SELECT artist, ROUND(AVG(liveness),2), ROUND(AVG(valence),2), 
ROUND(AVG(loudness),2)
FROM df_spotify
GROUP BY artist; 

-- For each album, calculate the total views of all associated tracks

SELECT album, track,
SUM(views) as total_views
FROM df_spotify
GROUP BY album, track
ORDER BY total_views DESC; 

-- Find the top 5 tracks with the highest energy values

SELECT DISTINCT(track), energy as highest_energy
FROM df_spotify
ORDER BY highest_energy DESC
LIMIT 5;

-- Find tracks for which the liveness score is above the average liveness

SELECT track, liveness 
FROM df_spotify
WHERE liveness > (SELECT AVG(liveness) FROM df_spotify);  


-- List all tracks which have an official video along with their views and likes counts

SELECT track, sum(views) as total_views, sum(likes) as total_likes
FROM df_spotify
WHERE official_video = 1
GROUP BY track
ORDER BY total_views DESC; 


-- Calculate the average number of streams for tracks which have official video and compare it with the average streams
-- for tracks which don't 

WITH t1 AS (
SELECT track, AVG(stream) as average_streams, 
DENSE_RANK() OVER(ORDER BY AVG(stream) DESC) AS rn1
FROM df_spotify
WHERE official_video = 1
GROUP BY track), 
t2 AS (
SELECT track, AVG(stream) as average_streams, 
DENSE_RANK() OVER(ORDER BY AVG(stream) DESC) AS rn2
FROM df_spotify
WHERE official_video = 0
GROUP BY track) 
SELECT t1.track, t1.average_streams, t2.track, t2.average_streams
FROM t1
LEFT JOIN t2
ON t1.rn1 = t2.rn2;

-- Find the avergae number of comments for tracks which are licensed vs for not licensed

SELECT licensed, AVG(comments) as comments
FROM df_spotify
GROUP BY licensed; 

-- Comparison between licensed and not licensed tracks in terms of comments

WITH wc AS (
SELECT track, AVG(comments) as average_comments, 
DENSE_RANK() OVER(ORDER BY AVG(stream) DESC) AS rn1
FROM df_spotify
WHERE licensed = 1
GROUP BY track), 
woc AS (
SELECT track, AVG(comments) as average_comments, 
DENSE_RANK() OVER(ORDER BY AVG(stream) DESC) AS rn2
FROM df_spotify
WHERE licensed = 0
GROUP BY track) 
SELECT wc.track, wc.average_comments, woc.track, woc.average_comments
FROM wc
LEFT JOIN woc
ON wc.rn1 = woc.rn2;


-- Retrieve the tracks that have been streamed on Spotify more than Youtube

SELECT track,
SUM(CASE WHEN most_playedon = 'Spotify' THEN stream
ELSE 0 END) AS spotify_streams, 
SUM(CASE WHEN most_playedon = 'Youtube' THEN stream
ELSE 0 END) AS yt_streams
FROM df_spotify
GROUP BY track
HAVING spotify_streams > yt_streams
AND yt_streams <> 0;  

-- Calculate the difference between the highest and lowest energy values for tracks in each album

WITH cte AS (
SELECT album, 
MAX(energy) AS max,
MIN(energy) as min
FROM df_spotify
GROUP BY album
)
SELECT album, 
max - min AS difference
FROM cte
ORDER BY difference DESC; 

-- Find artist Efficiency Score - Rank artists based on "stream per track" to find who consistently performs well 
#(consider only artists who have more than 5 tracks)

SELECT *,
DENSE_RANK() OVER(ORDER BY streams_per_track DESC) AS artist_ranks
FROM (
	SELECT artist, 
	ROUND(SUM(stream) / COUNT(track),2) AS streams_per_track
	FROM df_spotify
	GROUP BY artist
	HAVING COUNT(track) > 5
    ) t; 
    
-- Identify most engaging tracks (high likes to views ratio)
# i.e., songs that go viral beyond just views - consider tracks with views greater than 1000000

SELECT track, 
SUM(views),
ROUND(SUM(likes)/ SUM(views),3) AS likes_to_views_ratio
FROM df_spotify
GROUP BY track 
HAVING SUM(views) > 1000000
ORDER BY likes_to_views_ratio DESC; 








-- For this project, I downloaded Spotify data from Kaggle.
-- Then I created a table to insert Spotify data into.
-- Finally, I performed analytics on the data using SQL. 

DROP TABLE IF EXISTS Spotifydata;

CREATE TABLE Spotifydata (
id integer PRIMARY KEY,
artist_name varchar NOT NULL,
track_name varchar NOT NULL,
track_id varchar NOT NULL,
popularity integer NOT NULL,
danceability decimal(4,3) NOT NULL,
energy decimal(4,3) NOT NULL,
song_key integer NOT NULL,
loudness decimal(5,3) NOT NULL,
song_mode integer NOT NULL,
speechiness decimal(5,4) NOT NULL,
acousticness decimal(6,5) NOT NULL,
instrumentalness decimal(8,7) NOT NULL,
liveness decimal(5,4) NOT NULL,
valence decimal(4,3) NOT NULL,
tempo decimal(6,3) NOT NULL,
duration_ms integer NOT NULL,
time_signature integer NOT NULL );

-- Then I inserted the Spotify Data .csv into the table.
SELECT * FROM Spotifydata;

-- Next, I explored the data using the following SQL:

-- How many artists are there on the Top 50?
WITH List_Of_Artists AS (
SELECT artist_name FROM Spotifydata
GROUP BY artist_name
)
SELECT COUNT(artist_name) As Number_Of_Artists
FROM List_Of_Artists;

-- Who are the artists on the Top 50?
SELECT artist_name FROM Spotifydata GROUP BY artist_name;

-- What is the average popularity, song danceability, and song energy
-- by artist from the most popular to the least popular?
SELECT artist_name, AVG(popularity), AVG(danceability), AVG(energy)
FROM Spotifydata GROUP BY artist_name ORDER BY AVG(popularity) DESC;

-- What is the average danceability for the 10 most popular songs?
WITH Top_Ten_Songs AS (
SELECT danceability FROM Spotifydata
ORDER BY popularity DESC LIMIT 10
)
SELECT AVG(danceability) FROM Top_Ten_Songs;

-- Who are the Top 10 artists based on their songs' popularity?
SELECT artist_name, track_name, popularity
FROM Spotifydata ORDER BY popularity DESC LIMIT 10;

-- Who are the Top 10 least popular artists based on their songs' popularity?
SELECT artist_name, track_name, popularity
FROM Spotifydata ORDER BY popularity ASC LIMIT 10;

-- What artist released the longest song?
SELECT artist_name, track_name,
MAX(duration_ms) AS Duration_MS FROM Spotifydata;

-- What artist released the shortest song?
SELECT artist_name, track_name,
MIN(duration_ms) AS Duration_MS FROM Spotifydata;

-- What artist has the most songs in the Top 50 and how many?
SELECT artist_name, COUNT(artist_name) AS Number_Of_Songs
FROM Spotifydata GROUP BY artist_name
ORDER BY Number_Of_Songs DESC LIMIT 2;

-- List all the artist and the number of songs they have on the Top 50.
SELECT artist_name, COUNT(artist_name) AS Number_Of_Songs
FROM Spotifydata GROUP BY artist_name
ORDER BY Number_Of_Songs DESC;

-- What are the 10 easiest songs to dance to?
SELECT track_name, artist_name, danceability
FROM Spotifydata ORDER BY danceability DESC LIMIT 10;

-- What are the 10 hardest songs to dance to?
SELECT track_name, artist_name, danceability
FROM Spotifydata ORDER BY danceability ASC LIMIT 10;

-- What is the key, mode and tempo of all the songs,
-- from the most popular to the least popular?
SELECT track_name, song_key, song_mode, tempo, artist_name
FROM Spotifydata ORDER BY popularity DESC;

-- List all the songs from the ones with the most lyrics
-- to the ones with the least amount of lyrics.
SELECT track_name, artist_name, speechiness FROM Spotifydata
ORDER BY speechiness DESC;

/* Calculate the average popularity for the artists in the Spotify data table.
Then, for every artist with an average popularity of 90 or above,
show their name, their average popularity, and label them as a “Top Star”. */
WITH Artists_Average_Popularity AS(
SELECT sd.artist_name, AVG(sd.popularity) AS average_popularity
FROM Spotifydata sd GROUP BY sd.artist_name
)
SELECT artist_name, average_popularity, 'Top Star' AS tag
FROM Artists_Average_Popularity
WHERE average_popularity>=90;

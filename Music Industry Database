/* Create table about the people and what they do here */

-- Record Label table
CREATE TABLE record_label (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT);

INSERT INTO record_label VALUES(1,'Blackened');
INSERT INTO record_label VALUES(2,'Warner Bros');
INSERT INTO record_label VALUES(3,'Universal');
INSERT INTO record_label VALUES(4,'MCA');
INSERT INTO record_label VALUES(5,'Elektra');
INSERT INTO record_label VALUES(6,'Capitol');

-- Artist table
CREATE TABLE artist (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  record_label_id INTEGER,
  name TEXT);

INSERT INTO Artist VALUES(1, 1,'Metallica');
INSERT INTO Artist VALUES(2, 1,'Megadeth');
INSERT INTO Artist VALUES(3, 1,'Anthrax');
INSERT INTO Artist VALUES(4, 2,'Eric Clapton');
INSERT INTO Artist VALUES(5, 2,'ZZ Top');
INSERT INTO Artist VALUES(6, 2,'Van Halen');
INSERT INTO Artist VALUES(7, 3,'Lynyrd Skynyrd');
INSERT INTO Artist VALUES(8, 3,'AC/DC');
INSERT INTO Artist VALUES(9, 6,'The Beatles');

-- Album Table
CREATE TABLE album (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  artist_id INTEGER,
  name TEXT,
  release_year INTEGER);

INSERT INTO album VALUES(1, 1, '...And Justice For All',1988);
INSERT INTO album VALUES(2, 1, 'Black Album',1991);
INSERT INTO album VALUES(3, 1, 'Master of Puppets',1986);
INSERT INTO album VALUES(4, 2, 'Endgame',2009);
INSERT INTO album VALUES(5, 2, 'Peace Sells',1986);
INSERT INTO album VALUES(6, 3, 'The Greater of 2 Evils',2004);
INSERT INTO album VALUES(7, 4, 'Reptile',2001);
INSERT INTO album VALUES(8, 4, 'Riding with the King',2000);
INSERT INTO album VALUES(9, 5, 'Greatest Hits',1992);
INSERT INTO album VALUES(10, 6, 'Greatest Hits',2004);
INSERT INTO album VALUES(11, 7, 'All-Time Greatest Hits',1975);
INSERT INTO album VALUES(12, 8, 'Greatest Hits',2003);
INSERT INTO album VALUES(13, 9, 'Sgt. Pepper''s Lonely Hearts Club Band', 1967);

-- Song table
CREATE TABLE song (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  album_id INTEGER,
  name TEXT,
  song_duration REAL);

INSERT INTO song VALUES(1,1,'One',7.25);
INSERT INTO song VALUES(2,1,'Blackened',6.42);
INSERT INTO song VALUES(3,2,'Enter Sandman',5.3);
INSERT INTO song VALUES(4,2,'Sad But True',5.29);
INSERT INTO song VALUES(5,3,'Master of Puppets',8.35);
INSERT INTO song VALUES(6,3,'Battery',5.13);
INSERT INTO song VALUES(7,4,'Dialectic Chaos',2.26);
INSERT INTO song VALUES(8,4,'Endgame',5.57);
INSERT INTO song VALUES(9,5,'Peace Sells',4.09);
INSERT INTO song VALUES(10,5,'The Conjuring',5.09);
INSERT INTO song VALUES(11,6,'Madhouse',4.26);
INSERT INTO song VALUES(12,6,'I am the Law',6.03);
INSERT INTO song VALUES(13,7,'Reptile',3.36);
INSERT INTO song VALUES(14,7,'Modern Girl',4.49);
INSERT INTO song VALUES(15,8,'Riding with the King',4.23);
INSERT INTO song VALUES(16,8,'Key to the Highway',3.39);
INSERT INTO song VALUES(17,9,'Sharp Dressed Man',4.15);
INSERT INTO song VALUES(18,9,'Legs',4.32);
INSERT INTO song VALUES(19,10,'Eruption',1.43);
INSERT INTO song VALUES(20,10,'Hot For Teacher',4.43);
INSERT INTO song VALUES(21,11,'Sweet Home Alabama',4.45);
INSERT INTO song VALUES(22,11,'Free Bird',14.23);
INSERT INTO song VALUES(23,12,'Thunderstruck',4.52);
INSERT INTO song VALUES(24,12,'T.N.T',3.35);
INSERT INTO song VALUES(25,13,'Sgt. Pepper''s Lonely Hearts Club Band', 2.0333);
INSERT INTO song VALUES(26,13,'With a Little Help from My Friends', 2.7333);
INSERT INTO song VALUES(27,13,'Lucy in the Sky with Diamonds', 3.4666);
INSERT INTO song VALUES(28,13,'Getting Better', 2.80);
INSERT INTO song VALUES(29,13,'Fixing a Hole', 2.60);
INSERT INTO song VALUES(30,13,'She''s Leaving Home', 3.5833);
INSERT INTO song VALUES(31,13,'Being for the Benefit of Mr. Kite!',2.6166);
INSERT INTO song VALUES(32,13,'Within You Without You',5.066);
INSERT INTO song VALUES(33,13,'When I''m Sixty-Four',2.6166);
INSERT INTO song VALUES(34,13,'Lovely Rita', 2.7);
INSERT INTO song VALUES(35,13,'Good Morning Good Morning', 2.6833);
INSERT INTO song VALUES(36,13,'Sgt. Pepper''s Lonely Hearts Club Band (Reprise)', 1.3166);
INSERT INTO song VALUES(37,13,'A Day in the Life', 5.65);

-- Display all the record labels, artists, albums and songs.
SELECT * FROM record_label;
SELECT * FROM artist;
SELECT * FROM album;
SELECT * FROM song;

-- List all artists with their record label, albums and songs.
SELECT artist.name AS Artist, record_label.name AS Record_Label, album.name AS Album, album.release_year AS Release_Year, song.name AS Song
FROM record_label
JOIN artist ON record_label.id = artist.record_label_id
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
ORDER BY artist.name ASC;

-- List the record labels and their number of artists.
SELECT record_label.name AS Record_Label, COUNT(artist.id) AS Number_Of_Artists FROM record_label LEFT JOIN artist ON record_label.id = artist.record_label_id GROUP BY Record_Label ORDER BY Number_Of_Artists DESC;

-- What is the average number of artists per record label?
SELECT COUNT(artist.id) / COUNT(record_label.id) AS Average_Of_Artists_Per_Record_Label FROM record_label JOIN artist ON record_label.id = artist.record_label_id;

-- List the artists and their number of albums.
SELECT artist.name AS Artist, COUNT(album.id) AS Number_Of_Albums FROM artist LEFT JOIN album ON artist.id = album.artist_id GROUP BY Artist ORDER BY Number_Of_Albums DESC;

-- What is the average number of albums per artist?
SELECT COUNT(album.id) / COUNT(artist.id) AS Average_Of_Albums_Per_Artist FROM artist JOIN album ON artist.id = album.artist_id;

-- List the albums, their artists, their release year and and number of songs.
SELECT album.name AS Album, artist.name AS Artist, album.release_year AS Release_Year, COUNT(song.id) AS Number_Of_Songs FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
GROUP BY album.id ORDER BY Release_Year ASC;

-- List the albums from longest to shortest.
SELECT album.name AS Album, artist.name AS Artist, album.release_year AS Release_Year, SUM(song.song_duration) AS Duration FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
GROUP BY album.id ORDER BY Duration DESC;

-- What is the longest album?
SELECT Album AS Longest_Album, Artist, Release_Year, MAX(Duration) AS Duration FROM (
SELECT album.name AS Album, artist.name AS Artist, album.release_year AS Release_Year, SUM(song.song_duration) AS Duration FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id GROUP BY album.id);

-- What is the shortest album?
SELECT Album AS Shortest_Album, Artist, Release_Year, MIN(Duration) AS Duration FROM (
SELECT album.name AS Album, artist.name AS Artist, album.release_year AS Release_Year, SUM(song.song_duration) AS Duration FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id GROUP BY album.id);

-- How many albums were released every year?
SELECT album.release_year AS Year, COUNT(album.release_year) AS Number_Of_Albums_Released FROM album GROUP BY Year ORDER BY Number_Of_Albums_Released DESC;

-- What albums were released this century?
SELECT album.name AS This_Century_Albums, artist.name AS Artist, album.release_year AS Release_Year FROM artist JOIN album ON artist.id = album.artist_id WHERE Release_Year >= 2000 GROUP BY album.id ORDER BY Release_Year ASC;

-- What albums were released last century?
SELECT album.name AS Last_Century_Albums, artist.name AS Artist, album.release_year AS Release_Year FROM artist JOIN album ON artist.id = album.artist_id WHERE Release_Year < 2000 GROUP BY album.id ORDER BY Release_Year ASC;

-- List all the songs from longest to shortest.
SELECT song.name AS Song, song.song_duration AS Duration, album.release_year AS Release_Year, artist.name AS Artist FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
GROUP BY song.id ORDER BY Duration DESC;

-- What is the longest song?
SELECT song.name AS Longest_Song, MAX(song.song_duration) AS Duration, album.release_year AS Release_Year, artist.name AS Artist FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id;

-- What is the shortest song?
SELECT song.name AS Shortest_Song, MIN(song.song_duration) AS Duration, album.release_year AS Release_Year, artist.name AS Artist FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id;

-- List 5 songs which are 5 minutes or longer.
SELECT song.name AS Top_5_Songs_5_Minutes_Or_Longer, song.song_duration AS Duration, artist.name AS Artist FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
WHERE Duration >=5 GROUP BY song.id ORDER BY Duration ASC LIMIT 5;

-- List 5 songs which are shorter than 5 minutes.
SELECT song.name AS Top_5_Songs_Shorter_Than_5_Minutes, song.song_duration AS Duration, artist.name AS Artist FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
WHERE Duration <5 GROUP BY song.id ORDER BY Duration DESC LIMIT 5;

-- List all songs released in the 80's.
SELECT song.name AS Songs_From_The_80s, album.release_year AS Release_Year, artist.name AS Artist FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
WHERE Release_Year >=1980 AND Release_Year <=1989 GROUP BY song.id ORDER BY Release_Year ASC;

-- List all songs released in the 90's.
SELECT song.name AS Songs_From_The_90s, album.release_year AS Release_Year, artist.name AS Artist FROM artist
JOIN album ON artist.id = album.artist_id
JOIN song ON album.id = song.album_id
WHERE Release_Year >=1990 AND Release_Year <=1999 GROUP BY song.id ORDER BY Release_Year ASC;

-- Question Set 2: Moderate
-- PostgreSQL syntax.

-- Q1. Customers who listened to Rock music.
-- DISTINCT avoids repeating a customer when they bought multiple Rock tracks.
-- The genre is included to match the requested output fields.
SELECT DISTINCT
       c.email,
       c.first_name,
       c.last_name,
       g.name AS genre
FROM customer AS c
JOIN invoice AS i ON i.customer_id = c.customer_id
JOIN invoice_line AS il ON il.invoice_id = i.invoice_id
JOIN track AS t ON t.track_id = il.track_id
JOIN genre AS g ON g.genre_id = t.genre_id
WHERE g.name = 'Rock'
ORDER BY c.email ASC;

-- Q2. Top 10 artists by number of Rock tracks.
SELECT a.artist_id,
       a.name AS artist_name,
       COUNT(t.track_id) AS rock_track_count
FROM artist AS a
JOIN album AS al ON al.artist_id = a.artist_id
JOIN track AS t ON t.album_id = al.album_id
JOIN genre AS g ON g.genre_id = t.genre_id
WHERE g.name = 'Rock'
GROUP BY a.artist_id, a.name
ORDER BY rock_track_count DESC, artist_name
LIMIT 10;

-- Q3. Tracks longer than the average track length.
-- The correct column name is milliseconds.
SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;

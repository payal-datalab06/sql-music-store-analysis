-- Question Set 3: Advanced
-- PostgreSQL syntax.

-- Q1. Amount spent by each customer on each artist.
-- Revenue is calculated from invoice-line price * quantity, not invoice total,
-- because an invoice may contain tracks from multiple artists.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.artist_id,
    a.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS amount_spent
FROM customer AS c
JOIN invoice AS i ON i.customer_id = c.customer_id
JOIN invoice_line AS il ON il.invoice_id = i.invoice_id
JOIN track AS t ON t.track_id = il.track_id
JOIN album AS al ON al.album_id = t.album_id
JOIN artist AS a ON a.artist_id = al.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.artist_id, a.name
ORDER BY amount_spent DESC, c.last_name, a.name;

-- Q2. Most popular genre in each country.
-- Popularity is measured as total quantity purchased. RANK keeps all genres
-- tied for the highest number of purchases within a country.
WITH genre_purchases AS (
    SELECT
        c.country,
        g.genre_id,
        g.name AS genre_name,
        SUM(il.quantity) AS purchases
    FROM invoice_line AS il
    JOIN invoice AS i ON i.invoice_id = il.invoice_id
    JOIN customer AS c ON c.customer_id = i.customer_id
    JOIN track AS t ON t.track_id = il.track_id
    JOIN genre AS g ON g.genre_id = t.genre_id
    GROUP BY c.country, g.genre_id, g.name
),
ranked_genres AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY country
               ORDER BY purchases DESC
           ) AS genre_rank
    FROM genre_purchases
)
SELECT country, genre_name, purchases
FROM ranked_genres
WHERE genre_rank = 1
ORDER BY country, genre_name;

-- Q3. Top-spending customer(s) in each billing country.
-- RANK preserves ties, returning every customer who shares the maximum spend.
WITH customer_spend AS (
    SELECT
        i.billing_country,
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(i.total) AS total_spending
    FROM invoice AS i
    JOIN customer AS c ON c.customer_id = i.customer_id
    GROUP BY i.billing_country, c.customer_id, c.first_name, c.last_name
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY billing_country
               ORDER BY total_spending DESC
           ) AS spending_rank
    FROM customer_spend
)
SELECT billing_country, customer_id, first_name, last_name, total_spending
FROM ranked_customers
WHERE spending_rank = 1
ORDER BY billing_country, last_name, first_name;

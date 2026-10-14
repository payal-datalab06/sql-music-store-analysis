-- Question Set 1: Easy
-- Run against the PostgreSQL schema in 01_create_tables.sql.

-- Q1. Senior-most employee based on job level.
-- The dataset uses labels such as L1...L7, so descending lexical order works for this format.
SELECT employee_id, first_name, last_name, title, levels
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2. Countries with the most invoices.
SELECT billing_country, COUNT(*) AS invoice_count
FROM invoice
GROUP BY billing_country
ORDER BY invoice_count DESC, billing_country;

-- Q3. Three highest invoice totals.
SELECT invoice_id, total
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- Q4. City with the highest sum of invoice totals.
SELECT billing_city, SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1;

-- Q5. Best customer by total invoice spend.
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(i.total) AS total_spending
FROM customer AS c
JOIN invoice AS i ON i.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC
LIMIT 1;

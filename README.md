# SQL Music Store Data Analysis

A portfolio project using SQL and a relational music-store dataset to answer business questions about revenue, customers, genres, artists, and track lengths.

## Project objective

Use SQL to turn transactional music-store data into answers to practical business questions. The analysis is organized into easy, moderate, and advanced query sets.

## Tools

- PostgreSQL SQL
- Relational database concepts: primary keys, foreign keys, joins, aggregation, CTEs, and window functions
- CSV files supplied with the project

## Dataset overview

The provided CSV files contain the following records:

| File / table | Rows | Purpose |
|---|---:|---|
| `customer` | 59 | Customer details |
| `employee` | 9 | Employee and reporting information |
| `invoice` | 614 | Invoice headers and billing details |
| `invoice_line` | 4,757 | Purchased track line items |
| `track` | 3,503 | Track details, duration, genre, and price |
| `album` | 347 | Album and artist mapping |
| `artist` | 275 | Artist names |
| `genre` | 25 | Genre categories |
| `media_type` | 5 | Track media formats |

The supplied files do not include playlist data, although optional `playlist` and `playlist_track` table definitions are included in the schema script.

## Business questions answered

### Easy
1. Who is the senior-most employee by job level?
2. Which billing countries have the most invoices?
3. What are the three highest invoice totals?
4. Which billing city generates the highest sum of invoice totals?
5. Who is the best customer by total invoice spend?

### Moderate
1. Which customers have purchased Rock tracks? Return email, first name, last name, and genre.
2. Which ten artists have the most Rock tracks?
3. Which tracks are longer than the average track duration?

### Advanced
1. How much has each customer spent on each artist?
2. What is the most purchased genre in each customer country, including ties?
3. Who are the highest-spending customers in each billing country, including ties?

## SQL concepts demonstrated

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- `GROUP BY` and aggregate functions such as `COUNT`, `SUM`, and `AVG`
- Multi-table `JOIN`s
- Subqueries and common table expressions (CTEs)
- Window functions: `RANK()`
- Tie-aware ranking
- Revenue calculation using invoice-line `unit_price * quantity`
- Relational schema design and key constraints

## Repository structure

```text
sql-music-store-analysis/
├── README.md
├── data/
│   ├── album.csv
│   ├── artist.csv
│   ├── customer.csv
│   ├── employee.csv
│   ├── genre.csv
│   ├── invoice.csv
│   ├── invoice_line.csv
│   ├── media_type.csv
│   └── track.csv
└── sql/
    ├── 01_create_tables.sql
    ├── 02_easy_questions.sql
    ├── 03_moderate_questions.sql
    └── 04_advanced_questions.sql
```

## How to run

1. Create a PostgreSQL database for the project.
2. Run `sql/01_create_tables.sql`.
3. Import each CSV into its matching table. Ensure the import tool uses the header row and maps columns by name.
4. Run the query files in order: easy, moderate, advanced.
5. Save selected query outputs or screenshots in a `screenshots/` folder and discuss the findings below.

## Findings

Add verified findings after running the queries in your own database. Do not add results until they have been checked against the query output.

Suggested items to report:
- Highest-revenue billing city and its invoice total
- Top-spending customer and their spend
- Most popular genre by country
- Top Rock artists by track count

## Data and attribution

Before publishing the CSV files publicly, confirm that the source dataset's licence permits redistribution. If redistribution is not permitted or is unclear, publish the SQL scripts and document how to obtain the dataset instead of committing the raw data.

## Limitations and assumptions

- Revenue for artist-level analysis is calculated from invoice-line `unit_price * quantity`.
- Country-level customer ranking in question 3 uses `invoice.billing_country`, as the question is based on sales transactions.
- Genre popularity is measured by total quantity purchased, not by the number of distinct invoices.
- No query outputs or business findings are claimed in this README until verified by running the scripts.

-- Music Store Data Analysis
-- Database: PostgreSQL
-- Tables are created in dependency order. IDs use INTEGER to match the supplied CSV files.

CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    title VARCHAR(50),
    reports_to INTEGER REFERENCES employee(employee_id),
    levels VARCHAR(10),
    birthdate TIMESTAMP,
    hire_date TIMESTAMP,
    address VARCHAR(120),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(30),
    phone VARCHAR(40),
    fax VARCHAR(40),
    email VARCHAR(100)
);

CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    company VARCHAR(150),
    address VARCHAR(120),
    city VARCHAR(80),
    state VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(30),
    phone VARCHAR(40),
    fax VARCHAR(40),
    email VARCHAR(100),
    support_rep_id INTEGER REFERENCES employee(employee_id)
);

CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customer(customer_id),
    invoice_date TIMESTAMP,
    billing_address VARCHAR(120),
    billing_city VARCHAR(80),
    billing_state VARCHAR(50),
    billing_country VARCHAR(50),
    billing_postal_code VARCHAR(30),
    total NUMERIC(10,2)
);

CREATE TABLE artist (
    artist_id INTEGER PRIMARY KEY,
    name VARCHAR(150)
);

CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    title VARCHAR(200),
    artist_id INTEGER REFERENCES artist(artist_id)
);

CREATE TABLE media_type (
    media_type_id INTEGER PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE genre (
    genre_id INTEGER PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE track (
    track_id INTEGER PRIMARY KEY,
    name VARCHAR(200),
    album_id INTEGER REFERENCES album(album_id),
    media_type_id INTEGER REFERENCES media_type(media_type_id),
    genre_id INTEGER REFERENCES genre(genre_id),
    composer VARCHAR(200),
    milliseconds BIGINT,
    bytes BIGINT,
    unit_price NUMERIC(10,2)
);

CREATE TABLE invoice_line (
    invoice_line_id INTEGER PRIMARY KEY,
    invoice_id INTEGER REFERENCES invoice(invoice_id),
    track_id INTEGER REFERENCES track(track_id),
    unit_price NUMERIC(10,2),
    quantity INTEGER CHECK (quantity >= 0)
);

-- The supplied files do not include playlist.csv or playlist_track.csv.
-- Optional tables can be created if those datasets are obtained:
CREATE TABLE playlist (
    playlist_id INTEGER PRIMARY KEY,
    name VARCHAR(120)
);

CREATE TABLE playlist_track (
    playlist_id INTEGER REFERENCES playlist(playlist_id),
    track_id INTEGER REFERENCES track(track_id),
    PRIMARY KEY (playlist_id, track_id)
);

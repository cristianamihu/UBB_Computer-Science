-- Database: vacante

-- DROP DATABASE IF EXISTS vacante;

CREATE DATABASE vacante
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	
	CREATE TABLE clients (
    client_id BIGINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    fidelity_grade INT CHECK (fidelity_grade BETWEEN 1 AND 100),
    age INT CHECK (age > 0),
    hobbies TEXT[] CHECK (hobbies <@ ARRAY['READING', 'MUSIC', 'HIKING', 'WALKING', 'EXTREME_SPORTS']::TEXT[])
);

CREATE TABLE locations (
    location_id BIGINT PRIMARY KEY,
    location_name VARCHAR(255) NOT NULL
);

CREATE TABLE hotels (
    hotel_id BIGINT PRIMARY KEY,
    location_id BIGINT REFERENCES locations(location_id),
    hotel_name VARCHAR(255) NOT NULL,
    no_rooms INT,
    price_per_night DOUBLE PRECISION,
    type VARCHAR(50) CHECK (type IN ('FAMILY', 'TEENAGERS', 'OLDPEOPLE'))
);

CREATE TABLE special_offers (
    special_offer_id BIGINT PRIMARY KEY,
    hotel_id BIGINT REFERENCES hotels(hotel_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    percent INT CHECK (percent BETWEEN 1 AND 100)
);

CREATE TABLE reservations (
    reservation_id BIGINT PRIMARY KEY,
    client_id BIGINT REFERENCES clients(client_id),
    hotel_id BIGINT REFERENCES hotels(hotel_id),
    start_date DATE NOT NULL,
    no_nights INT CHECK (no_nights > 0)
);

INSERT INTO clients (client_id, name, fidelity_grade, age, hobbies) VALUES
(1, 'John Doe', 75, 28, ARRAY['READING', 'HIKING']),
(2, 'Jane Smith', 60, 35, ARRAY['MUSIC', 'WALKING']),
(3, 'Emily Johnson', 85, 42, ARRAY['EXTREME_SPORTS', 'HIKING']),
(4, 'Michael Brown', 50, 23, ARRAY['READING']),
(5, 'Jessica Davis', 95, 30, ARRAY['READING', 'MUSIC', 'WALKING']);


-- Inserting into locations
INSERT INTO locations (location_id, location_name) VALUES
(1, 'Downtown'),
(2, 'Seaside');

-- Inserting into hotels
INSERT INTO hotels (hotel_id, location_id, hotel_name, no_rooms, price_per_night, type) VALUES
(1, 1, 'Grand Hotel', 100, 150.0, 'FAMILY'),
(2, 2, 'Sea View Resort', 50, 200.0, 'OLDPEOPLE');


-- Inserting into special_offers
INSERT INTO special_offers (special_offer_id, hotel_id, start_date, end_date, percent) VALUES
(3, 1, '2023-06-01', '2025-06-15', 70),
(4, 2, '2023-07-01', '2025-07-15', 50);

-- Inserting into reservations
INSERT INTO reservations (reservation_id, client_id, hotel_id, start_date, no_nights) VALUES
(1, 1, 1, '2023-08-01', 7),
(2, 2, 1, '2023-09-01', 3);

SELECT * FROM hotels;
SELECT so.*, h.hotel_name, l.location_name
                FROM special_offers so
                JOIN hotels h ON so.hotel_id = h.hotel_id
                JOIN locations l ON h.location_id = l.location_id
                JOIN clients c ON c.client_id = 3
                WHERE so.end_date >= CURRENT_DATE AND c.fidelity_grade > so.percent

SELECT * FROM special_offers WHERE hotel_id = 2 AND start_date <= '2024-01-12' AND end_date >= '2024-02-15';
SELECT * FROM reservations;
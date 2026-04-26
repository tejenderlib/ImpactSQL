CREATE DATABASE disaster_analysis;
USE disaster_analysis;
SHOW DATABASES;

CREATE TABLE disasters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100),
    location TEXT,
    region VARCHAR(100),
    origin VARCHAR(100),
    disaster_type VARCHAR(100),
    disaster_subtype VARCHAR(100),
    year INT,
    total_deaths INT,
    total_affected BIGINT,
    total_damage_usd BIGINT,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6)
);
DESCRIBE disasters;

SELECT * FROM disasters;

CREATE TABLE disasters_raw (
    country TEXT,
    location TEXT,
    region TEXT,
    origin TEXT,
    disaster_type TEXT,
    disaster_subtype TEXT,
    year TEXT,
    total_deaths TEXT,
    total_affected TEXT,
    total_damage_usd TEXT,
    latitude TEXT,
    longitude TEXT
);
-- if wanna run all this file 
--  .read 'Lesson\1.21\1.21_DDL_DML_Pt1.sql'
USE data_jobs;
DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

SELECT * 
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

-- DROP SCHEMA staging;

CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INT PRIMARY KEY,
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog='jobs_mart';

-- DROP TABLE IF EXISTS preferred_roles;
    /* Inserting Values */
INSERT INTO staging.preferred_roles(role_id,role_name)
VALUES
      (1,'Data Engineer'),
      (2,'Senior  Data Engineer'),
      (3,'Junior Data Engineer');
SELECT * 
FROM staging.preferred_roles;
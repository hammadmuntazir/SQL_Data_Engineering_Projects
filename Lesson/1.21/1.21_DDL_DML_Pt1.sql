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

    /* Inserting Values */
INSERT INTO staging.preferred_roles(role_id,role_name)
VALUES
      (1,'Data Engineer'),
      (2,'Senior  Data Engineer'),
      (3,'Software Engineer');

SELECT * 
FROM staging.preferred_roles;

/* Data Manipulation Language */
--  ADDING COLUMN
ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

-- Dropping COLUMN
ALTER TABLE staging.preferred_roles
DROP COLUMN preferred_role;
-- UPDATE is row level modification WHILE insertion is row level Addition
UPDATE staging.preferred_roles
SET preferred_role=TRUE
WHERE role_id=1 OR role_id=2;

UPDATE staging.preferred_roles
SET preferred_role=FALSE
WHERE role_id=3;

-- UPDATE staging.preferred_roles
-- SET preferred_role=TRUE
-- WHERE role_name LIKE '%Data Engineer%';

-- UPDATE staging.preferred_roles
-- SET preferred_role=FALSE
-- WHERE role_name NOT LIKE '%Data Engineer%';

/*RENAME Table*/
ALTER TABLE staging.preferred_roles
RENAME TO  priority_roles;

/* Now we will query by this new name */
SELECT * 
FROM staging.priority_roles;

/* Renaming Column*/
ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl; 
/* changing data types*/
ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE  INTEGER;

UPDATE staging.priority_roles
SET priority_lvl =3
WHERE role_id=3;
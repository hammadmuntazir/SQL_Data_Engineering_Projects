USE data_jobs;
-- /* Data base  */
-- -- Creating Database
-- CREATE DATABASE job_mart;
-- -- checking
-- SHOW DATABASES;
-- -- for automation script and wanna avoid error

CREATE DATABASE IF NOT EXISTS job_mart;

-- -- Drop data base -> always carefull while doing this
-- DROP DATABASE job_mart;
-- --  checking if it got deleted 
SHOW DATABASES;
-- -- for automated script
-- DROP DATABASE IF EXISTS job_mart;

-- /*   SCHEMA         */
-- SELECT *
-- FROM information_schema.schemata;
-- --  Creating schema
-- CREATE SCHEMA job_mart.staging; 
-- -- if we donot always wanna create schema in specified data base by mentioning it we can do it by this way
USE job_mart;
-- CREATE SCHEMA staging;
-- -- for automation task
CREATE SCHEMA IF NOT EXISTS staging;

-- -- Droping schema
-- DROP SCHEMA staging;
-- -- for automated tasks
-- DROP SCHEMA IF EXISTS staging;

--    /*  TABLES  */

-- --  you  should specify schema too otherwise it will go in default one i.e. main here
CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INT,
    role_name VARCHAR
);

--  checking schemas
SELECT *
FROM information_schema.tables
WHERE table_catalog='job_mart';

-- -- droping table
-- DROP TABLE IF EXISTS staging.preferred_roles;
INSERT INTO staging.preferred_roles(role_id,role_name)
VALUES
      (1,'Data Engineer'),
      (2,'Senior  Data Engineer');

SELECT * 
FROM staging.preferred_roles;
-- INSERT INTO staging.preferred_roles(role_id,role_name)
-- VALUES(3,'Junior Data Engineer');




/*          */
-- File: 1.21_DDL_DML_Pt1.sql
-- ============================================

-- ============================================
-- STEP 1: Switch away from jobs_mart before dropping
-- ============================================

-- First, switch to a different database
USE data_jobs;

-- Now we can drop jobs_mart
DROP DATABASE IF EXISTS jobs_mart;

-- Create fresh database
CREATE DATABASE IF NOT EXISTS jobs_mart;

-- ============================================
-- STEP 2: Use the new database
-- ============================================

USE jobs_mart;

-- Show all databases to verify
SHOW DATABASES;

-- ============================================
-- STEP 3: Create schema
-- ============================================

CREATE SCHEMA IF NOT EXISTS staging;

-- ============================================
-- STEP 4: Create table
-- ============================================

CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INT PRIMARY KEY,
    role_name VARCHAR
);

-- ============================================
-- STEP 5: Clear and insert data
-- ============================================

DELETE FROM staging.preferred_roles WHERE role_id IN (1, 2, 3);

INSERT INTO staging.preferred_roles(role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

-- View inserted data
SELECT * FROM staging.preferred_roles;

-- ============================================
-- STEP 6: Add column
-- ============================================

ALTER TABLE staging.preferred_roles 
ADD COLUMN IF NOT EXISTS preferred_role BOOLEAN;

-- ============================================
-- STEP 7: Update values
-- ============================================

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_name LIKE '%Data Engineer%';

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_name NOT LIKE '%Data Engineer%';

-- View updates
SELECT * FROM staging.preferred_roles;

-- ============================================
-- STEP 8: RENAME TABLE (FIXED for DuckDB)
-- ============================================

-- DuckDB syntax: ALTER TABLE old_name RENAME TO new_name
-- (no schema prefix in the new name)
ALTER TABLE staging.preferred_roles 
RENAME TO priority_roles;

-- Now query with new name (note: it's still in staging schema)
SELECT * FROM staging.priority_roles;

-- ============================================
-- STEP 9: RENAME COLUMN
-- ============================================

ALTER TABLE staging.priority_roles 
RENAME COLUMN preferred_role TO priority_lvl;

-- ============================================
-- STEP 10: CHANGE DATA TYPE (INTEGER doesn't work for boolean)
-- ============================================

-- First, drop the column and recreate as INTEGER
-- OR convert using CASE statement
ALTER TABLE staging.priority_roles 
ADD COLUMN IF NOT EXISTS priority_lvl_int INTEGER;

-- Convert boolean to integer
UPDATE staging.priority_roles 
SET priority_lvl_int = CASE 
    WHEN priority_lvl = TRUE THEN 1 
    WHEN priority_lvl = FALSE THEN 0 
    ELSE NULL 
END;

-- Drop old column
ALTER TABLE staging.priority_roles 
DROP COLUMN priority_lvl;

-- Rename new column
ALTER TABLE staging.priority_roles 
RENAME COLUMN priority_lvl_int TO priority_lvl;

-- ============================================
-- STEP 11: Update specific values
-- ============================================

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

UPDATE staging.priority_roles
SET priority_lvl = 1
WHERE role_id IN (1, 2);

-- ============================================
-- STEP 12: Final verification
-- ============================================

SELECT * FROM staging.priority_roles;

-- Show table structure
DESCRIBE staging.priority_roles;
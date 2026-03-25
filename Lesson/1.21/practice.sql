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
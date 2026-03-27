SELECT 
     *
FROM 
    company_dim
WHERE
    name IN ('Facebook','Meta');   
SELECT * 
FROM skills_job_dim; 
SELECT *
FROM skills_dim;

SELECT *
FROM skills_dim
LIMIT 5;

SELECT *
FROM information_schema.tables
WHERE table_catalog='data_jobs';
-- table_constraints
-- key_column_usage
PRAGMA show_tables_expanded;
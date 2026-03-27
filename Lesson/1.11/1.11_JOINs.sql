SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.name,
    jpf.job_location
FROM 
   job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id=cd.company_id
LIMIT 10;

-- Right Join
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd. company_id,
    cd.name AS Compnay_Name
FROM
    job_postings_fact AS jpf
RIGHT JOIN company_dim as cd
    ON jpf.company_id=cd.company_id;

/* Inner Join*/
--  INNER JOIN is by default join in sql
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd. company_id,
    cd.name AS Compnay_Name

FROM
    job_postings_fact AS jpf
iNNER JOIN company_dim as cd
    ON jpf.company_id=cd.company_id;

/* FULL OUTER JOIN */
--  returns all rows from both tables
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd. company_id,
    cd.name AS Compnay_Name

FROM
    job_postings_fact AS jpf
FULL JOIN company_dim as cd
    ON jpf.company_id=cd.company_id
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id=sjd.job_id
lEFT JOIN skills_dim AS sd
    ON sjd.skill_id=sd.skill_id
LIMIT 10;

SELECT 
    cd.name AS company_name,
    COUNT(jpf.*) AS posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id=cd.company_id
GROUP BY cd.name;

/* Find the top 10 companies  for posting jobs
They must have>3000 postings 
Limit this to only US jobs
*/
EXPLAIN ANALYZE
SELECT 
    cd.name AS company_name,
    COUNT(jpf.*) AS posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS  cd
    ON jpf.company_id=cd.company_id
WHERE jpf.job_country ='United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id)>3000
ORDER BY posting_count DESC
LIMIT 10;

/*

*/
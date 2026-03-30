-- subquery
SELECT *
FROM (
    SELECT * 
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary__hour_avg IS NOT NULL
) AS valid_salaries
LIMIT 10;
-- CTE 
--  ->FOR CTE we define that temporary result set at the beginning of the query using the with keyword

WITH valid_salaries AS (
     SELECT *
     FROM job_postings_fact
     WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
        LIMIT 10
)
SELECT *
FROM valid_salaries;

/* Scenario 1 - Subquery in 'SELECT'
show each job's salary next to the overall market median:
Har job title ke saath POORE MARKET ki median salary dikhao

NOT Show median salary for each job title"
Har job title category ke liye USKI APNI median salary dikhao


*/
SELECT 
    job_title_short,
    salary_year_avg,
    (SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact)AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;


/* Scenario 2 -Subquery in FROM 
-- Stage only jobs that are remote before aggregation
to determine the remote median salary per job
*/
SELECT 
    job_title_short,
    MEDIAN(salary_year_avg)AS median_salary,
    (SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact)AS market_median_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home =TRUE
) AS clean_jobs
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
LIMIT 10;

SELECT 
    job_title_short,
    MEDIAN(salary_year_avg)AS median_salary,
    (SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home=TRUE)AS market_remote_median_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home =TRUE
) AS clean_jobs
-- WHERE salary_year_avg IS NOT NULL  -- not needed 
GROUP BY job_title_short
LIMIT 10;

/*
-- Scenario 3 - Subquery in Having
-- Keep only job titles whose median salary is above the overall median:
*/
SELECT 
    job_title_short,
    MEDIAN(salary_year_avg)AS median_salary,
    (SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home=TRUE)AS market_remote_median_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home =TRUE
) AS clean_jobs
-- WHERE salary_year_avg IS NOT NULL  -- not needed 
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg)>(SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home=TRUE)
LIMIT 10;


/* select is giving one value,
from is giving table,
having givining single value
more than one row returned by a subquery used as an expression -a scalar sub queries can only return a single row*/

                /* CTEs*/
WITH data_engineers_jobs AS (
    SELECT * 
    FROM job_postings
    WHERE job_title_short='Data Engineer'
)
SELECT * FROM data_engineers_jobs;
/* CTE - A temporary result set that you can reference within:
FROM : used like a table
JOIN : join to  it like any other table
Other CTEs: Later CTEs can reference earlies ones
SELECT/INSERT/UPDATE/DELETE :main statement
WITH - used to define CTE at the beginning of a query .
Exists only during the execution of a query A*/

-- CTE Example
-- Compare how much more (or less ) remote roles pay compared to onsite roles for each job title.
-- Use a CTE to calculate the median salary by title and work arrangement,then compare those medains.
WITH title_median AS (
SELECT 
    job_title_short,
    job_work_from_home,
    MEDIAN(salary_year_avg):: INT AS  median_salary
FROM job_postings_fact 
WHERE job_country='United States'
GROUP BY 
    job_title_short,
    job_work_from_home)

SELECT 
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    (r.median_salary - o.median_salary)AS remote_premium
FROM title_median AS r 
INNER JOIN title_median AS o
   ON  r.job_title_short=o.job_title_short
WHERE r.job_work_from_home=TRUE
    AND o.job_work_from_home=FALSE
ORDER BY remote_premium DESC;

/* Final Exam */
--  WHERE EXISTS 

FROM range(3) AS src(key);

SELECT *
FROM range(3) AS src(key);

SELECT *
FROM range(2) AS tgt(key);

-- FInal query 
SELECT *
FROM range(3) AS src(key)
WHERE EXISTS(
    SELECT 1
    FROM range(2) AS tgt(key)
    WHERE tgt.key=src.key
);
-- 
/*
┌───────┐
│  key  │
│ int64 │
├───────┤
│     0 │
│     1 │
|_______|
*/
-- WHERE NOT EXISTS
SELECT *
FROM range(3) AS src(key)
WHERE NOT EXISTS(
    SELECT 1 FROM -- 1 is common why of sharing we can do anyother
    range(2) AS tgt(key)
    WHERE tgt.key=src.key
);
/*
┌───────┐
│  key  │
│ int64 │
├───────┤
│   2   │
└───────┘
*/
-- identifying job posting that have no associated skillls before loading them in a data mart
SELECT *
FROM job_postings_fact 
ORDER BY job_id
LIMIT 10;

SELECT * 
FROM skills_job_dim
ORDER BY job_id
LIMIT 40;

SELECT *
FROM job_postings_fact AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS src
    WHERE src.job_id =tgt.job_id
)
ORDER BY job_id;
-- SO we got only those job which have not skill listed in skills_job_dim 
SELECT *
FROM job_postings_fact AS tgt
WHERE EXISTS(
    SELECT 1 
    FROM skills_job_dim AS src
    WHERE src.job_id=tgt.job_id
)
ORDER BY job_id;
/* now it will give those where skills exists
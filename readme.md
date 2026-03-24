# Heading 1
## Heading 2
### Heading 3
Normal Text 
**Bold Text**  
*Italics Text*
`This is code`
- Bullet 1
- Bullet 2
1. number 1
2. number 2

[Link Text](https://google.com)  
![Project Overview](/images\1_1_Project1_EDA.png)

```sql
SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id=sd.skill_id
WHERE 
    jpf.job_title_short='Data Engineer'
    AND jpf.job_work_from_home=TRUE
GROUP BY   
    sd.skills
ORDER BY 
    demand_count DESC
LIMIT 10;
```
>block quote  
Horizontal line
---


## 💻 SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Joins**: Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping**: `GROUP BY` for categorical analysis by skill
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics**: Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause**: Filtering aggregated results (skills with >= 100 postings)
- **NULL Handling**: Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)
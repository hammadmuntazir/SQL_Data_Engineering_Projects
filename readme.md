# SQL Data Engineering Projects

This repository contains two SQL-focused projects: job-market analysis and a data warehouse with analytical data marts. They are portfolio projects for practicing SQL, data modeling, and data transformation.

## 1. Job-market SQL analysis

Folder: [1_EDA](./1_EDA/)

Queries explore a job-posting dataset to investigate topics such as in-demand skills, higher-paying skills, and skills that combine demand with pay. The folder includes its own README and SQL scripts.

![Job market analysis overview](./images/1_1_Project1_EDA.png)

## 2. Data warehouse and data marts

Folder: [2_DW_Mart_Build](./2_DW_Mart_Build/)

SQL scripts create a star-schema-style warehouse model, load CSV data from public Google Cloud Storage URLs with DuckDB, and build analytical marts for different query patterns.

Key files:
- [Create warehouse tables](./2_DW_Mart_Build/01_create_tables_dw.sql)
- [Load source CSVs](./2_DW_Mart_Build/02_load_schema_dw.sql)
- [Create flat mart](./2_DW_Mart_Build/03_create_flat_mart.sql)
- [Create skills mart](./2_DW_Mart_Build/04_create_skills_mart.sql)
- [Create priority mart](./2_DW_Mart_Build/05_create_priority_mart.sql)
- [Build script](./2_DW_Mart_Build/build_dw_marts.sql)
- [Detailed project guide](./2_DW_Mart_Build/README.md)

![Data pipeline architecture](./images/1_2_Project2_Data_Pipeline.png)

## Tools and concepts

- SQL and DuckDB
- Fact and dimension tables
- Bridge tables for many-to-many relationships
- Data loading from CSV
- Analytical data marts
- Aggregations, CTEs, joins, and incremental-update patterns

## Getting started

The data warehouse project uses DuckDB SQL and reads source CSV files from public URLs. Install DuckDB using its official instructions, then follow the project-specific README and execute scripts in the documented order. Confirm the exact DuckDB version and script compatibility in your environment before running all scripts.

These projects are learning and portfolio work; the repository documentation describes the intended workflow, but this README does not claim that every script has been run in a clean environment.

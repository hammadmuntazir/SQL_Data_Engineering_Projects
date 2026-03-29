# This is visual explanation of pipeline made


┌─────────────────────────────────────────────────────────────────────────────────────┐
│                           COMPLETE DATA FLOW VISUALIZATION                          │
└─────────────────────────────────────────────────────────────────────────────────────┘

    SOURCE 1                    SOURCE 2                    SOURCE 3
    (Jobs)                      (Companies)                 (Priority Roles)
        │                           │                           │
        │                           │                           │
        ▼                           ▼                           ▼
    ┌─────────┐                 ┌─────────┐                 ┌─────────┐
    │   JOB   │                 │ COMPANY │                 │PRIORITY │
    │ POSTINGS│                 │   DIM   │                 │ ROLES   │
    └────┬────┘                 └────┬────┘                 └────┬────┘
         │                           │                           │
         │    LEFT JOIN              │                           │
         │    (company_id)           │                           │
         └──────────┬────────────────┘                           │
                    │                                            │
                    │         Combined Result                    │
                    │         (All jobs + company names)         │
                    │                                            │
                    │              INNER JOIN                    │
                    │         (job_title = role_name)            │
                    └──────────────────┬─────────────────────────┘
                                       │
                                       │  ONLY priority jobs pass
                                       │
                                       ▼
                          ┌─────────────────────────┐
                          │    TEMPORARY RESULT      │
                          │  (What will be inserted) │
                          ├─────────────────────────┤
                          │ job_id: 101,102,103...   │
                          │ + priority_lvl from      │
                          │   priority_roles         │
                          │ + CURRENT_TIMESTAMP      │
                          └───────────┬─────────────┘
                                      │
                                      │  INSERT
                                      ▼
                          ┌─────────────────────────┐
                          │   TARGET TABLE           │
                          │ priority_jobs_snapshot   │
                          ├─────────────────────────┤
                          │ ✓ Data Engineer (lvl 1)  │
                          │ ✓ Senior DE (lvl 1)      │
                          │ ✓ Software Eng (lvl 3)   │
                          │ ✗ Data Scientist (out)   │
                          └─────────────────────────┘
  

  MERGE INTO 
    target_table AS tgt 
  USING 
    source_table AS src
 ON 
    tgt.key_column=src.key_column
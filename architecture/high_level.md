## High-Level Architecture

```mermaid
flowchart LR
    A[Azure Blob Storage<br>raw CSV files] --> B[Snowflake Stage]
    B --> C[Snowflake RAW Tables]

    C --> D[dbt Staging Models<br>stg_*]
    D --> E[dbt Intermediate Models<br>int_*, inc_*]
    E --> F[dbt Marts<br>dim_*, fact_*]

    F --> G[Analytics / BI Tools]

    subgraph Airflow
    X[Airflow DAG<br>Cosmos + dbt build]
    end

    X --> D
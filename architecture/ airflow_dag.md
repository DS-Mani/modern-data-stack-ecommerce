```markdown


```mermaid
flowchart TD

    subgraph DAG["Airflow DAG: cosmos_ecommerce_dbt"]
        A[staging_models<br>stg_*] --> B[intermediate_models<br>int_*, inc_*]
        B --> C[mart_models<br>dim_*, fact_*]
        C --> D[snapshots<br>snapshot:*]
    end
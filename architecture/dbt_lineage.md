```markdown
## dbt Model Lineage

```mermaid
flowchart TD

    %% Raw layer
    R1[(raw.customers)]
    R2[(raw.orders)]
    R3[(raw.order_items)]
    R4[(raw.products)]

    %% Staging
    R1 --> S1[stg_customers]
    R2 --> S2[stg_orders]
    R3 --> S3[stg_order_items]
    R4 --> S4[stg_products]

    %% Intermediate
    S2 --> I1[int_order_items_products]
    S3 --> I1
    S4 --> I1

    S1 --> I2[int_customer_orders]
    S2 --> I2
    I1 --> I2

    %% Incremental history
    S2 --> I3[inc_order_history]
    S3 --> I3
    S4 --> I3

    %% Marts
    I2 --> D1[dim_customer_summary]
    S1 --> D2[dim_customers]
    S4 --> D3[dim_products]
    S2 --> D4[dim_date]

    I1 --> F1[fact_order_items]
    S2 --> F2[fact_sales]
    S3 --> F2
    S4 --> F2
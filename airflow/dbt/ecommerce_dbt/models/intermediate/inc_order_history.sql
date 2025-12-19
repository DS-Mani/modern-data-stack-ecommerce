{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

with source_data as (
    select 
        o.order_id,
        o.customer_id,
        o.order_timestamp,
        oi.product_id,
        oi.quantity,
        (oi.quantity * p.price) as total_price
    from {{ ref('stg_orders') }} as o
    join {{ ref('stg_order_items') }} as oi
        on o.order_id = oi.order_id
    join {{ ref('stg_products') }} as p
        on oi.product_id = p.product_id

    {% if is_incremental() %}
    where o.order_timestamp > (
        select coalesce(max(order_timestamp), '1900-01-01')
        from {{ this }}
    )
    {% endif %}
)

select * from source_data
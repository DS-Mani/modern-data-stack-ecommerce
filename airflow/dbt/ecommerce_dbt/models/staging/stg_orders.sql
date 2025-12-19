with src as (
    select
        order_id,
        customer_id,
        order_status,
        try_to_timestamp(order_date) as order_timestamp
    from {{ source('raw', 'orders') }}
)

select * from src
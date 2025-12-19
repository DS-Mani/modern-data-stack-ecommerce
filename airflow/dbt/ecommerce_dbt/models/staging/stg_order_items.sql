with src as (
    select
        order_item_id,
        order_id,
        product_id,
        try_to_number(unit_price) as unit_price,
        try_to_number(quantity) as quantity
    from {{ source('raw', 'order_items') }}
)

select * from src
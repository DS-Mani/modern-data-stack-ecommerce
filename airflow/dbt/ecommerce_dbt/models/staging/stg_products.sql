with src as (
    select
        product_id,
        product_name,
        category,
        try_to_number(price) as price
    from {{ source('raw', 'products') }}
)

select * from src
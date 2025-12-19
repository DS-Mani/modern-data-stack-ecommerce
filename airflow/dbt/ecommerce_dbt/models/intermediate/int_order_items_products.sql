with base as (
    select
        oi.order_id,
        oi.order_item_id,
        oi.product_id,
        p.product_name,
        p.category,
        oi.quantity,
        (oi.quantity * p.price) as total
    from {{ ref('stg_order_items') }} as oi
    join {{ ref('stg_products') }} as p
      on oi.product_id = p.product_id
)

select * from base
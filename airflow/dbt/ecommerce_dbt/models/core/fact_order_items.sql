with items as (
    select *
    from {{ ref('stg_order_items') }}
),

orders as (
    select order_id, customer_id, order_timestamp
    from {{ ref('stg_orders') }}
),

final as (

    select
        items.order_item_id,
        items.order_id,
        orders.customer_id,
        items.product_id,
        items.unit_price,
        items.quantity,
        (items.unit_price * items.quantity) as revenue,
        orders.order_timestamp,
        orders.order_timestamp::date as order_date_key
    from items
    left join orders using (order_id)

)

select * from final
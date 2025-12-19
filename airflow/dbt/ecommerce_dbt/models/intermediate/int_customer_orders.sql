with cte as (
    select
        c.customer_id,
        c.first_name || ' ' || c.last_name as customer_name,
        count(distinct o.order_id) as total_orders,
        sum(oi.total) as total_revenue
    from {{ ref('stg_customers') }} c
    join {{ ref('stg_orders') }} o
      on c.customer_id = o.customer_id
    join {{ ref('int_order_items_products') }} oi
      on o.order_id = oi.order_id
    group by 1,2
)

select * from cte
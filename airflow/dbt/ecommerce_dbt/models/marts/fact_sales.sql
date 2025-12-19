select
    oi.order_id,
     o.order_timestamp as order_date,
    o.customer_id,
    sum(oi.quantity * p.price) as order_total
from {{ ref('stg_orders') }} o
join {{ ref('stg_order_items') }} oi
  on o.order_id = oi.order_id
join {{ ref('stg_products') }} p
  on oi.product_id = p.product_id
group by 1, 2, 3
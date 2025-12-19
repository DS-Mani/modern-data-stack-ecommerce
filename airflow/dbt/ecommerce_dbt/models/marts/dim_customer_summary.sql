with src as (
  select
    c.customer_id,
    c.first_name || ' ' || c.last_name as customer_name,
    c.email,
    c.phone_no,
    co.total_orders,
    co.total_revenue
from {{ ref('stg_customers') }} as c
left join {{ ref('int_customer_orders') }} as co
  on c.customer_id = co.customer_id
  )


select * from src
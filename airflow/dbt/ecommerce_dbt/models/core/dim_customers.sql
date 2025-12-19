with customers 
as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        phone_no,
        signup_timestamp AS signup_date
    from {{ ref('stg_customers') }}
)

select * from customers
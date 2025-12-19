with src as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        phone_no,
        try_to_timestamp(signup_date) as signup_timestamp
    from {{ source( 'raw', 'customers')}}
)

select * from src
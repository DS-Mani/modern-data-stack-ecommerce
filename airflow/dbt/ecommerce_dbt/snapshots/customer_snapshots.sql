{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='timestamp',
        updated_at='signup_date'
    )
}}

select
    customer_id,
    first_name,
    last_name,
    email,
    phone_no,
    signup_date
from {{ source('raw', 'customers') }}

{% endsnapshot %}


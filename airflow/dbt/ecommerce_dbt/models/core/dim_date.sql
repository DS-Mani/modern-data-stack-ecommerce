with dates as (

    select
        order_timestamp::date as date_day
    from {{ ref('stg_orders') }}
    where order_timestamp is not null

),

final as (

    select distinct
        date_day,
        year(date_day) as year,
        month(date_day) as month,
        day(date_day) as day,
        to_char(date_day, 'DY') as day_name
    from dates

)

select * from final

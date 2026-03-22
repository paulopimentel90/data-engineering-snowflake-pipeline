{{ config(materialized='table') }}

with dates as (

    select
        dateadd(day, seq4(), '2020-01-01') as date
    from table(generator(rowcount => 3650))

)

select
    -- {{ dbt_utils.generate_surrogate_key(['date']) }} as date_key,
    to_number(to_char({{ dbt_utils.generate_surrogate_key(['date']) }}, 'YYYYMMDD')) as date_key,
    date,
    year(date) as year,
    month(date) as month_number,
    monthname(date) as month_desc,
    day(date) as day,
    week(date) as week,
    case 
        when month(date) <= 6 then 1
        else 2
    end as halfyear

from dates
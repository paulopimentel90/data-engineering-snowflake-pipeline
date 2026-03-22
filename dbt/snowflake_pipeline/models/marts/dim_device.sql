{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['device_id']) }} as device_key,
    device_id,
    ip_address
from {{ ref('int_transactions') }}
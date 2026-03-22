{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['deviceid']) }} as device_key,
    deviceid,
    ipaddress
from {{ ref('int_transactions') }}
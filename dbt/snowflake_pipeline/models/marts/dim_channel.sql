{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['channel']) }} as channel_key,
    channel
from {{ ref('int_transactions') }}
{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['merchantid']) }} as merchant_key,
    merchantid
from {{ ref('int_transactions') }}
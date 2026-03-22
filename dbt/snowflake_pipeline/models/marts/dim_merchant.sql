{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['merchant_id']) }} as merchant_key,
    merchant_id
from {{ ref('int_transactions') }}
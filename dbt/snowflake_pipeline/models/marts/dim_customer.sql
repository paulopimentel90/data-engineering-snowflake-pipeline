{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as customer_key,
    account_id,
    customer_age,
    customer_occupation
from {{ ref('int_transactions') }}
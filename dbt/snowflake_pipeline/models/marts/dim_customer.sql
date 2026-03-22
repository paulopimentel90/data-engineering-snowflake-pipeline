{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['accountid']) }} as customer_key,
    accountid,
    customerage,
    customeroccupation
from {{ ref('int_transactions') }}
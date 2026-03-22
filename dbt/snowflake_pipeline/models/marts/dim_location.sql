{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['city']) }} as location_key,
    city
from {{ ref('int_transactions') }}
{{ config(materialized='table') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['location']) }} as location_key,
    location
from {{ ref('int_transactions') }}
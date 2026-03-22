select *
from {{ source('raw', 'BANK_TRANSACTIONS') }}
limit 10
select *
from {{ ref('stg_bank_transactions') }}
where AccountBalance > 0
select *
from {{ ref('stg_bank_transactions') }}
where transaction_amount > 0;
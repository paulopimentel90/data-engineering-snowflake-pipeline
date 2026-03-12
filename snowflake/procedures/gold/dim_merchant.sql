CREATE OR REPLACE PROCEDURE load_dim_merchant()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE dim_merchant;

INSERT INTO dim_merchant (merchant_id)
SELECT DISTINCT merchantid
FROM bank_transactions_silver;

SELECT 'DIM_MERCHANT LOADED';

$$;
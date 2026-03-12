CREATE OR REPLACE PROCEDURE load_dim_channel()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE dim_channel;

INSERT INTO dim_channel (channel)
SELECT DISTINCT channel
FROM bank_transactions_silver;

SELECT 'DIM_CHANNEL LOADED';

$$;
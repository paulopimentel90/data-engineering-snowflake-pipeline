CREATE OR REPLACE PROCEDURE load_dim_location()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE dim_location;

INSERT INTO dim_location (city)
SELECT DISTINCT location
FROM bank_transactions_silver;

SELECT 'DIM_LOCATION LOADED';

$$;
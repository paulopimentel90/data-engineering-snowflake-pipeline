CREATE OR REPLACE PROCEDURE load_dim_customer()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE dim_customer;

INSERT INTO dim_customer (account_id, customer_age, customer_occupation)
SELECT DISTINCT
    accountid,
    customerage,
    customeroccupation
FROM bank_transactions_silver;

SELECT 'DIM_CUSTOMER LOADED';

$$;
CREATE OR REPLACE PROCEDURE load_fact_transactions()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE fact_transactions;

INSERT INTO fact_transactions
SELECT
    t.transactionid,
    c.customer_key,
    m.merchant_key,
    d.device_key,
    l.location_key,
    ch.channel_key,
    TO_NUMBER(TO_CHAR(t.transactiondate,'YYYYMMDD')),
    t.transactionamount,
    t.transactionduration,
    t.loginattempts,
    t.accountbalance
FROM bank_transactions_silver t
JOIN dim_customer c
ON t.accountid = c.account_id
JOIN dim_merchant m
ON t.merchantid = m.merchant_id
JOIN dim_device d
ON t.deviceid = d.device_id
JOIN dim_location l
ON t.location = l.city
JOIN dim_channel ch
ON t.channel = ch.channel;

SELECT 'FACT_TRANSACTIONS LOADED';

$$;
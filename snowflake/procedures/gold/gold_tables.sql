-- DIM DATE
truncate table dim_date;
INSERT INTO dim_date
SELECT DISTINCT

    TO_NUMBER(TO_CHAR(transactiondate,'YYYYMMDD')) AS date_key,
    transactiondate AS data,
    YEAR(transactiondate) AS year,
    MONTH(transactiondate) AS month_number,
    MONTHNAME(transactiondate) AS month_desc,
    DAY(transactiondate) AS day,
    WEEK(transactiondate) AS week,
    CASE 
        WHEN MONTH(transactiondate) <= 6 THEN 1
        ELSE 2
    END AS halfyear
FROM bank_transactions_silver ORDER BY transactiondate;

-- DIM CUSTOMER
truncate table dim_customer;
INSERT INTO dim_customer (account_id, customer_age, customer_occupation)
SELECT DISTINCT
    accountid,
    customerage,
    customeroccupation
FROM bank_transactions_silver;

-- DIM LOCATION
truncate table dim_location;
INSERT INTO dim_location (city)
SELECT DISTINCT location
FROM bank_transactions_silver;

-- DIM MERCHANT
truncate table dim_merchant; 
INSERT INTO dim_merchant (merchant_id)
SELECT DISTINCT merchantid
FROM bank_transactions_silver;

-- DIM DEVICE
truncate table dim_device;
INSERT INTO dim_device (device_id, ip_address)
SELECT DISTINCT
    deviceid,
    ipaddress
FROM bank_transactions_silver;

-- DIM CHANNEL
truncate table dim_channel;
INSERT INTO dim_channel (channel)
SELECT DISTINCT channel
FROM bank_transactions_silver;

-- FACT TRANSACTIONS
truncate table fact_transactions;
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
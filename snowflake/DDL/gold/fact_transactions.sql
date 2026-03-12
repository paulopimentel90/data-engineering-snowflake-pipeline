CREATE TABLE fact_transactions (
    transaction_id STRING,
    customer_key INTEGER,
    merchant_key INTEGER,
    device_key INTEGER,
    location_key INTEGER,
    channel_key INTEGER,
    date_id INTEGER,
    transaction_amount FLOAT,
    transaction_duration INT,
    login_attempts INT,
    account_balance FLOAT
);
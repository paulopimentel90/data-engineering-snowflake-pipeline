CREATE OR REPLACE PROCEDURE load_dim_device()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE dim_device;

INSERT INTO dim_device (device_id, ip_address)
SELECT DISTINCT
    deviceid,
    ipaddress
FROM bank_transactions_silver;

SELECT 'DIM_DEVICE LOADED';

$$;
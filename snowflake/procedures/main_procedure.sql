CREATE OR REPLACE PROCEDURE load_datawarehouse()
RETURNS STRING
LANGUAGE SQL
AS
$$

CALL load_dim_date();
CALL load_dim_customer();
CALL load_dim_location();
CALL load_dim_merchant();
CALL load_dim_device();
CALL load_dim_channel();
CALL load_fact_transactions();

SELECT 'DATA WAREHOUSE LOADED SUCCESSFULLY';

$$;
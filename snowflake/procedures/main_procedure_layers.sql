CREATE OR REPLACE PROCEDURE load_bronze_and_silver()
RETURNS STRING
LANGUAGE SQL
AS
$$
CALL load_bronze_transactions();
CALL load_silver_transactions();


SELECT 'BRONZE AND SILVER DATA LOADED';

$$;
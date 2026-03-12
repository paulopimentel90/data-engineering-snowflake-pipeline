CREATE TASK load_dw_daily
WAREHOUSE = compute_wh
SCHEDULE = 'USING CRON 0 5 * * * UTC'
AS
CALL load_bronze_and_silver();
CALL load_datawarehouse();
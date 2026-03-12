CREATE OR REPLACE PROCEDURE load_dim_date()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE dim_date;

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
FROM bank_transactions_silver
ORDER BY transactiondate;

SELECT 'DIM_DATE LOADED';

$$;
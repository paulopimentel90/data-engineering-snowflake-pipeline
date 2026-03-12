CREATE OR REPLACE PROCEDURE load_silver_transactions()
RETURNS STRING
LANGUAGE SQL
AS
$$

TRUNCATE TABLE BANK_TRANSACTIONS_SILVER;

INSERT INTO BANK_TRANSACTIONS_SILVER
select 
$1:"AccountBalance"::FLOAT as AccountBalance,
$1:"AccountID"::string as AccountID,
$1:"Channel"::string as Channel,
$1:"CustomerAge"::INT as CustomerAge,
$1:"CustomerOccupation"::string as CustomerOccupation,
$1:"DeviceID"::string as DeviceID,
$1:"IP Address"::string as IPAddress,
$1:"Location"::string as Location,
$1:"LoginAttempts"::INT as LoginAttempts,
$1:"MerchantID"::string as MerchantID,
$1:"TransactionAmount"::FLOAT as TransactionAmount,
COALESCE(
        TRY_TO_DATE($1:"TransactionDate"::STRING, 'MM/DD/YYYY HH24:MI'),
        TRY_TO_DATE($1:"TransactionDate"::STRING, 'MM/DD/YYYY')
    ) AS TransactionDate,
$1:"TransactionDuration"::INT as TransactionDuration,
$1:"TransactionID"::string as TransactionID,
$1:"TransactionType"::string as TransactionType,
filename,
created_at
from bank_transactions_bronze;

SELECT 'SILVER DATA LOADED';

$$;
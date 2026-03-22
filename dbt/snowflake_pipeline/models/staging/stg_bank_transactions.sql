select 
raw_data:"AccountBalance"::FLOAT as AccountBalance,
raw_data:"AccountID"::string as AccountID,
raw_data:"Channel"::string as Channel,
raw_data:"CustomerAge"::INT as CustomerAge,
raw_data:"CustomerOccupation"::string as CustomerOccupation,
raw_data:"DeviceID"::string as DeviceID,
raw_data:"IP Address"::string as IPAddress,
raw_data:"Location"::string as Location,
raw_data:"LoginAttempts"::INT as LoginAttempts,
raw_data:"MerchantID"::string as MerchantID,
raw_data:"TransactionAmount"::FLOAT as TransactionAmount,
COALESCE(
        TRY_TO_DATE(raw_data:"TransactionDate"::STRING, 'MM/DD/YYYY HH24:MI'),
        TRY_TO_DATE(raw_data:"TransactionDate"::STRING, 'MM/DD/YYYY')
    ) AS TransactionDate,
raw_data:"TransactionDuration"::INT as TransactionDuration,
raw_data:"TransactionID"::string as TransactionID,
raw_data:"TransactionType"::string as TransactionType,
filename,
created_at
from {{ source('raw', 'BANK_TRANSACTIONS') }};
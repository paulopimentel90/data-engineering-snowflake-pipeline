INSERT INTO RAW.BANK_TRANSACTIONS
SELECT 
    $1 AS raw_data,
    metadata$filename AS filename,
    CURRENT_TIMESTAMP AS created_at
FROM @public.BANK
(FILE_FORMAT => 'PARQUET_FORMAT');
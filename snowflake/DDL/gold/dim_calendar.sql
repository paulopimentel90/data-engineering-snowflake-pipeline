CREATE OR REPLACE TABLE dim_calendar (
    date_key INTEGER,
    date DATE,
    year INTEGER,
    month_number INTEGER,
    month_desc STRING,
    day INTEGER,
    week INTEGER,
    halfyear INTEGER
);
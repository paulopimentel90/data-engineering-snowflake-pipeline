# Banking Transactions Data Pipeline

This project is an **end-to-end data engineering pipeline** built to simulate a modern data platform.

The goal is to ingest banking transaction data, store it in an AWS S3 data lake, and process the data using a **Medallion Architecture (Bronze, Silver, Gold)**.

This project demonstrates a real-world data engineering workflow using **PySpark, AWS S3, and Snowflake**.

---

# Data Source

The dataset was downloaded from **Kaggle** and contains simulated banking transaction data.

Each record represents a financial transaction made by a customer.

The dataset contains information about:

* transaction details
* customer information
* device used in the transaction
* IP address
* merchant information
* login attempts
* account balance

This type of dataset can be used to simulate **fraud detection pipelines, financial analytics, and customer behavior analysis**.

---

# Dataset Schema

The dataset contains the following columns:

| Column              | Description                            |
| ------------------- | -------------------------------------- |
| TransactionID       | Unique identifier for the transaction  |
| AccountID           | Unique identifier for the bank account |
| TransactionAmount   | Amount of the transaction              |
| TransactionDate     | Date and time of the transaction       |
| TransactionType     | Type of transaction (Debit/Credit)     |
| Location            | City where the transaction happened    |
| DeviceID            | Identifier of the device used          |
| IP Address          | IP address of the transaction          |
| MerchantID          | Merchant identifier                    |
| Channel             | Transaction channel (ATM / Online)     |
| CustomerAge         | Age of the customer                    |
| CustomerOccupation  | Occupation of the customer             |
| TransactionDuration | Duration of the transaction in seconds |
| LoginAttempts       | Number of login attempts               |
| AccountBalance      | Current balance of the account         |

---

# Sample Data

| TransactionID | AccountID | TransactionAmount | TransactionDate | TransactionType | Location  | DeviceID | IP Address     | MerchantID | Channel | CustomerAge | CustomerOccupation | TransactionDuration | LoginAttempts | AccountBalance |
| ------------- | --------- | ----------------- | --------------- | --------------- | --------- | -------- | -------------- | ---------- | ------- | ----------- | ------------------ | ------------------- | ------------- | -------------- |
| TX000001      | AC00128   | 14.09             | 4/11/2023 16:29 | Debit           | San Diego | D000380  | 162.198.218.92 | M015       | ATM     | 70          | Doctor             | 81                  | 1             | 5112.21        |
| TX000002      | AC00455   | 376.24            | 6/27/2023 16:44 | Debit           | Houston   | D000051  | 13.149.61.4    | M052       | ATM     | 68          | Doctor             | 141                 | 1             | 13758.91       |
| TX000003      | AC00019   | 126.29            | 7/10/2023 18:16 | Debit           | Mesa      | D000235  | 215.97.143.157 | M009       | Online  | 19          | Student            | 56                  | 1             | 1122.35        |
| TX000004      | AC00070   | 184.50            | 5/5/2023 16:32  | Debit           | Raleigh   | D000187  | 200.13.225.150 | M002       | Online  | 26          | Student            | 25                  | 1             | 8569.06        |

---

# Project Architecture

The pipeline follows a **modern cloud data architecture**.

```
Kaggle Dataset (CSV)
        │
        ▼
PySpark Ingestion Script
        │
        ▼
AWS S3 Data Lake (Parquet)
        │
        ▼
Snowflake External Stage
        │
        ▼
Bronze Layer
Raw structured data
        │
        ▼
Silver Layer
Cleaned and normalized data
        │
        ▼
Gold Layer
Aggregated analytics data
```

---

# Data Pipeline Steps

### 1️⃣ Data Ingestion

The dataset is downloaded from Kaggle in **CSV format**.
You can get this data using https://www.kaggle.com/datasets/thuandao/bank-transactions-dataset-for-fraud-detection

A **PySpark script** reads the file and transforms the data.

---

### 2️⃣ Data Lake Storage

The data is converted to **Parquet format** and uploaded to an **AWS S3 bucket**.

Parquet is used because it is:

* columnar
* efficient for analytics
* optimized for big data processing

---

### 3️⃣ Snowflake Integration

Snowflake reads the files stored in S3 using an **external stage**.

This allows Snowflake to load the data directly from the data lake.

---

### 4️⃣ Bronze Layer

The Bronze layer stores **raw structured data** from the ingestion process.

Minimal transformation is applied.

---

### 5️⃣ Silver Layer

The Silver layer contains **cleaned and structured data**.

Typical transformations include:

* fixing data types
* removing null values
* standardizing fields
* removing duplicates

---

### 6️⃣ Gold Layer

The Gold layer contains **aggregated and analytics-ready data**.

Examples of metrics:

* total transactions
* transaction amount per day
* customer activity patterns

---

# Project Structure

```
banking-data-pipeline/

├── ingestion
│   └── ingest_transactions.py
├── snowflake
│   ├── stages.sql
│   ├── bronze_tables.sql
│   ├── silver_tables.sql
│   └── gold_tables.sql
│
├── data
│   └── transactions.csv
│
├── .env
│
└── README.md
```

---

# Technologies Used

This project uses modern data engineering tools.

* Python
* PySpark
* AWS S3
* Snowflake
* Parquet
* dotenv (.env configuration)

---

# Example Use Cases

This dataset and pipeline can be used for:

* financial transaction analytics
* fraud detection systems
* customer behavior analysis
* banking activity monitoring

---

# Future Improvements

This project can be extended with more advanced data engineering features.

Possible improvements:

* Apache Airflow orchestration
* Automated ingestion pipelines
* Data quality checks
* CI/CD pipelines
* Infrastructure as Code (Terraform)
* Streaming ingestion with Kafka
* Real-time fraud detection

---

# Project Goal

The goal of this project is to demonstrate the implementation of a **modern data engineering pipeline** using cloud technologies and best practices.

It simulates a real-world **banking analytics platform** built with scalable data engineering architecture.

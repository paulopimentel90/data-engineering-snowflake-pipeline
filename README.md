# 🚀 End-to-End Data Engineering Pipeline (AWS S3 + Snowflake + dbt)

## 📌 Overview

This project implements an **end-to-end data engineering pipeline** designed to simulate a modern cloud-based data platform.

The pipeline ingests banking transaction data from Kaggle, stores it in a data lake, and transforms it into an **analytics-ready dimensional model (star schema)** using **dbt**.

It demonstrates a real-world data engineering workflow using:

* **PySpark** for ingestion
* **AWS S3** as a data lake
* **Snowflake** as a data warehouse
* **dbt** for transformation and modeling

The architecture follows the **Medallion pattern (Bronze → Silver → Gold)**.

---

## 📊 Data Source

Dataset from Kaggle:
https://www.kaggle.com/datasets/thuandao/bank-transactions-dataset-for-fraud-detection

The dataset contains simulated banking transactions, including:

* transaction details
* customer information
* device and IP data
* merchant data
* login attempts and balances

### 📌 Use Cases

This dataset can be used for:

* fraud detection
* financial analytics
* customer behavior analysis

---

## 🏗️ Architecture

```
        +-------------+
        |  Kaggle CSV |
        +-------------+
                |
                v
        +-------------+
        |  PySpark    |
        | (Ingestion) |
        +-------------+
                |
                v
        +-------------+
        |   AWS S3    |
        +-------------+
                |
                v
        +----------------------+
        |  Snowflake (RAW)     |
        |  VARIANT (Parquet)   |
        +----------------------+
                |
                v
        +----------------------+
        |        dbt           |
        |  (Transformations)   |
        +----------------------+
                |
                v
        +----------------------+
        |  Data Mart (GOLD)    |
        |  Star Schema         |
        +----------------------+
```

---

## 🔄 Data Pipeline Flow

### 1️⃣ Ingestion (PySpark)

* Reads raw CSV data
* Converts data to Parquet format
* Uploads files to AWS S3

---

### 2️⃣ Data Lake (S3)

* Stores data in columnar format (Parquet)
* Optimized for analytical workloads

---

### 3️⃣ Snowflake (Raw Layer - Bronze)

* Data is loaded from S3
* Stored as **VARIANT (semi-structured)**
* No transformations applied

---

### 4️⃣ Transformation Layer (dbt - Silver & Gold)

#### 🔹 Staging

* Extracts fields from VARIANT
* Applies type casting

#### 🔹 Intermediate

* Cleans and filters data
* Applies business rules

#### 🔹 Marts (Gold)

* Implements **star schema**
* Creates:

  * `fact_transactions`
  * `dim_customer`
  * `dim_merchant`
  * `dim_device`
  * `dim_location`
  * `dim_channel`
  * `dim_calendar`

---

## 📊 Data Model

### ⭐ Fact Table

* `fact_transactions`

### 📦 Dimension Tables

* `dim_customer`
* `dim_merchant`
* `dim_device`
* `dim_location`
* `dim_channel`
* `dim_calendar`

---

## 🧪 Data Quality

Data quality is enforced using **dbt tests**:

* `not_null`
* `unique`
* `relationships`
* `accepted_values`
* custom business rules

---

## ⚡ Incremental Processing

The fact table is implemented as an **incremental model**, ensuring:

* better performance
* scalability
* reduced Snowflake compute cost

---

## 📁 Project Structure

```
├── ingestion/              # PySpark ingestion
├── snowflake/ingestion/    # Raw layer SQL (table + load)
├── dbt/
│   ├── models/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   ├── macros/
│   ├── tests/
│   ├── dbt_project.yml
│   └── packages.yml
```

---

## ⚙️ Tech Stack

* Python
* PySpark
* AWS S3
* Snowflake
* dbt
* Parquet

---

## 🚀 How to Run

### 1. Install dependencies

```bash
pip install -r requirements.txt
dbt deps
```

---

### 2. Configure Snowflake

Configure your dbt profile:

```
~/.dbt/profiles.yml
```

---

### 3. Run dbt

```bash
dbt run
dbt test
```

---

### 4. Generate documentation

```bash
dbt docs generate
dbt docs serve
```

---

## 💡 Key Design Decisions

* Raw data stored as **VARIANT** for flexibility
* Transformations centralized in **dbt (no stored procedures)**
* Use of **surrogate keys** for dimensional modeling
* Adoption of **medallion architecture**
* Clear separation between ingestion and transformation

---

## 📈 Future Improvements

* CI/CD with GitHub Actions
* Orchestration with Airflow
* Data quality monitoring & alerting
* Integration with BI tools (Power BI / Looker)

---

## 👨‍💻 Author

**Paulo Pimentel**
Data Engineer | ETL | Snowflake | dbt | PySpark

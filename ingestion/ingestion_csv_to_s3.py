from pathlib import Path
from pyspark.sql import SparkSession
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# =========================
# SOLVING FILE PATH OF CSV
# =========================

base_dir = Path(__file__).resolve().parent
project_root = base_dir.parent
jar1 = project_root / "libs" / "hadoop-aws-3.3.4.jar"
jar2 = project_root / "libs" / "aws-java-sdk-bundle-1.12.262.jar"
csv_path = project_root / "data" / "bank_transactions_data_2_augmented_clean_2.csv"

# =========================
# TOOLS AWS
# =========================
AWS_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY")
AWS_SECRET_KEY = os.getenv("AWS_SECRET_KEY")
S3_BUCKET_PATH = os.getenv("S3_BUCKET_PATH")

# =========================
# CREATING SPARK SESSION
# =========================

spark = (
    SparkSession.builder
    .appName("csvToS3")
    .config("spark.hadoop.fs.s3a.access.key", AWS_ACCESS_KEY)
    .config("spark.hadoop.fs.s3a.secret.key", AWS_SECRET_KEY)
    .config("mapreduce.fileoutputcommitter.marksuccessfuljobs", "false")
    .config("spark.hadoop.fs.s3a.endpoint", "s3.amazonaws.com")
    .config("spark.jars", f"{jar1},{jar2}")
    .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
    .getOrCreate()
)

# =========================
# READING CSV
# =========================

df = spark.read.csv(str(csv_path), header=True, inferSchema=True)

print("Dataframe Schema:")
df.printSchema()

print("Preview data:")
df.show(10)

# =========================
# LOAD ON S3
# =========================

print(f"Loading data on {S3_BUCKET_PATH}")

df.write \
    .mode("overwrite") \
    .parquet(S3_BUCKET_PATH)

print("Load finished!")

spark.stop()



# df = spark.read.parquet(S3_BUCKET_PATH)
# df.show(10)
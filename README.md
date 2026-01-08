# Airbnb Data Analytics Platform: From Raw Logs to One Big Table 🏠 🚀

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

## 📖 Project Overview
This project is an end-to-end **ELT (Extract, Load, Transform)** pipeline designed to modernize Airbnb data analytics. It ingests raw data (Bookings, Hosts, Listings) from **AWS S3** into **Snowflake** and leverages **dbt (data build tool)** to orchestrate a robust **Medallion Architecture**.

The pipeline transforms raw logs into a high-performance **Star Schema** and a denormalized **One Big Table (OBT)**, optimized for BI tools like Tableau or PowerBI. It features advanced engineering practices such as **Incremental Materialization**, **SCD Type 2 Snapshots**, and **Jinja-based Metadata Driven pipelines**.

---

## 🏗️ Architecture & Lineage
The project follows the **Bronze ➔ Silver ➔ Gold** layer architecture:

![dbt Lineage Graph](https://arizonastateu-my.sharepoint.com/:i:/r/personal/akaurav_sundevils_asu_edu/Documents/Screenshot%202026-01-07%20at%208.25.39%E2%80%AFPM.png?csf=1&web=1&e=EbKQ2l) 


| Layer | Description | Materialization Strategy |
| :--- | :--- | :--- |
| **Bronze** | Raw data ingestion from AWS S3 (External Stages). 1:1 copy of source files. | `Table` / `View` |
| **Silver** | Cleaned, deduped, and standardized data. Handles nulls and type casting. | **Incremental** (Process only new data) |
| **Gold** | Business logic application. Dimensions, Facts, and OBT. | `Table` / `View` |

---

## ⚡ Key Features

### 1. Metadata-Driven Transformation (Jinja & Macros)
Instead of writing repetitive SQL, I utilized **Jinja macros** to automate transformation logic.
* **Dynamic Configuration:** The `fact.sql` and `obt.sql` models leverage a metadata dictionary to dynamically generate column selects and joins.
* **Code Reusability:** Custom macros handle standard cleaning tasks across multiple models, keeping the codebase DRY (Don't Repeat Yourself).

### 2. Optimized Data Processing (Incremental Models)
To reduce Snowflake compute costs:
* The **Silver Layer** uses `incremental` materialization.
* The pipeline checks for a "high water mark" (max date) and only processes records arriving after the last run.

### 3. Historical Tracking (SCD Type 2 Snapshots)
Business requirements dictated tracking changes in `Hosts` and `Listings` over time (e.g., if a host changes their superhost status).
* **dbt Snapshots** were implemented to capture these changes, creating `dbt_valid_from` and `dbt_valid_to` columns for time-travel analysis.

### 4. BI-Ready Gold Layer (Star Schema + OBT)
* **Star Schema:** Created `fact_bookings` linked to `dim_hosts` and `dim_listings`.
* **One Big Table (OBT):** Pre-joined all data into a single wide table to improve query performance for dashboarding tools by **~50%**.

---

## 🛠️ Tech Stack
* **Cloud Storage:** AWS S3 (Raw Data Lake)
* **Data Warehouse:** Snowflake (Compute & Storage)
* **Transformation:** dbt Core (SQL + Jinja)
* **Orchestration:** dbt CLI
* **Language:** SQL, Python (for data generation/loading scripts)

---

## 📂 Project Structure

```bash
├── analyses
├── macros                  # Custom Jinja macros for cleaning & automation
├── models
│   ├── bronze              # Raw ingestion models
│   ├── silver              # Cleaned & Incremental models
│   └── gold                # Star Schema & OBT
│       ├── fact.sql
│       ├── obt.sql
│       └── ...
├── snapshots               # SCD Type 2 logic for Hosts/Listings
├── seeds                   # Static reference data (csvs)
├── tests                   # Data quality tests (schema & custom)
└── dbt_project.yml         # Project configuration

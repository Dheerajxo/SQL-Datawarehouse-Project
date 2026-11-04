# SQL Data Warehouse Project

Building a modern data warehouse with SQL Server, including ETL processes, data modelling, and analytics.

A SQL Server data warehouse that integrates CRM and ERP data into a clean, analytics-ready model. The project uses a Bronze, Silver, and Gold architecture to organize raw data, transform it, and present it through views for reporting.

## Architecture

The project follows the Medallion Architecture:

- **Bronze:** Stores data loaded from the CRM and ERP source systems.
- **Silver:** Cleans and standardizes customer, product, sales, and ERP data.
- **Gold:** Combines the transformed data into customer and product dimensions and a sales fact view.

## Gold Layer

The Gold layer contains three views:

- **`gold.dim_customers`** — Customer details, including name, location, marital status, gender, and birthdate.
- **`gold.dim_products`** — Current product details, including category, subcategory, cost, and product line.
- **`gold.fact_sales`** — Sales orders connected to customer and product dimension keys, with order dates, quantity, price, and sales amount.

## Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Git and GitHub

## Getting Started

1. Clone this repository.
2. Create or select a SQL Server database for the project.
3. Load the CRM and ERP source data into the Bronze layer.
4. Run the Silver layer procedure to clean and transform the data.
5. Create the Gold views after the Silver layer has been loaded.
6. Query the Gold views for reporting and analysis.

Run the scripts in this order: **Bronze → Silver → Gold**. Make sure the required source tables and schemas exist before running the procedures.

## Analysis Opportunities

The Gold views can support analysis of:

- Sales trends over time
- Product and category performance
- Customer purchasing behavior
- Sales by customer location

## Project Structure

├── datasets/   # CRM and ERP source data
├── scripts/    # SQL scripts for the data warehouse layers
└── README.md

/*
    Project : Data Warehouse
    Step    : 03 - Bronze layer load procedure
    Platform: Microsoft SQL Server

    Purpose:
      Create or update bronze.load_bronze, which reloads the six bronze tables
      from the supplied CRM and ERP CSV files.

    Prerequisites:
      1. DataWarehouse, the bronze schema, and all six bronze tables exist.
      2. The CSV files exist at the paths below and are accessible to the SQL
         Server service account. BULK INSERT reads files on the SQL Server host.
      3. The SQL Server login/context has permission to run BULK INSERT.

    Important:
      The procedure truncates each target table before loading it. Running it
      replaces the existing rows. If a later BULK INSERT fails, earlier tables
      may already have been reloaded and the failing table may be empty or
      partially loaded. There is no transaction around the full set of loads.
*/

USE [DataWarehouse];
GO

/* Ensure the project schema exists before defining the procedure. */
IF SCHEMA_ID(N'bronze') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [bronze] AUTHORIZATION [dbo];');
END;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @start_time DATETIME,
        @end_time   DATETIME;

    PRINT N'===================================';
    PRINT N'Loading bronze layer';
    PRINT N'===================================';
    PRINT N'-----------------------------------';
    PRINT N'Loading CRM Tables';

    /* CRM customer records */
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_cust_info;

    BULK INSERT bronze.crm_cust_info
    FROM 'D:\Dheeraj\Projects\sql-data-warehouse-project-main\01_datasets\source_crm\cust_info.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = GETDATE();
    PRINT N'crm_cust_info load duration: '
        + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
        + N' seconds';

    /* CRM product records */
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_prd_info;

    BULK INSERT bronze.crm_prd_info
    FROM 'D:\Dheeraj\Projects\sql-data-warehouse-project-main\01_datasets\source_crm\prd_info.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = GETDATE();
    PRINT N'crm_prd_info load duration: '
        + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
        + N' seconds';

    /* CRM sales records */
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_sales_details;

    BULK INSERT bronze.crm_sales_details
    FROM 'D:\Dheeraj\Projects\sql-data-warehouse-project-main\01_datasets\source_crm\sales_details.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = GETDATE();
    PRINT N'crm_sales_details load duration: '
        + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
        + N' seconds';

    PRINT N'-----------------------------------';
    PRINT N'Loading ERP Tables';

    /* ERP customer records */
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_cust_az12;

    BULK INSERT bronze.erp_cust_az12
    FROM 'D:\Dheeraj\Projects\sql-data-warehouse-project-main\01_datasets\source_erp\cust_az12.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = GETDATE();
    PRINT N'erp_cust_az12 load duration: '
        + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
        + N' seconds';

    /* ERP location records */
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_loc_a101;

    BULK INSERT bronze.erp_loc_a101
    FROM 'D:\Dheeraj\Projects\sql-data-warehouse-project-main\01_datasets\source_erp\loc_a101.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = GETDATE();
    PRINT N'erp_loc_a101 load duration: '
        + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
        + N' seconds';

    /* ERP product category records */
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'D:\Dheeraj\Projects\sql-data-warehouse-project-main\01_datasets\source_erp\px_cat_g1v2.csv'
    WITH
    (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = GETDATE();
    PRINT N'erp_px_cat_g1v2 load duration: '
        + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
        + N' seconds';

    PRINT N'===================================';
    PRINT N'Bronze layer load complete';
    PRINT N'===================================';
END;
GO

/* Execute the procedure when you are ready to replace/reload bronze data. */
-- EXEC bronze.load_bronze;

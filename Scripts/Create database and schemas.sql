/*
    Project : Data Warehouse
    Step    : 01 - Database and schema creation
    Platform: Microsoft SQL Server

    Purpose:
      Create the DataWarehouse database (if it does not exist) and the three
      project schemas used for the warehouse layers: bronze, silver, and gold.

    Safe to rerun: existing database and schemas are left unchanged.

    Run this script in SQL Server Management Studio (SSMS) while connected to
    the SQL Server instance. Creating a database requires appropriate server
    permissions. The database is created with SQL Server's default settings.
*/

/* Create the project database only when it is missing. */
IF DB_ID(N'DataWarehouse') IS NULL
BEGIN
    PRINT N'Creating database DataWarehouse...';
    CREATE DATABASE [DataWarehouse];
END
ELSE
BEGIN
    PRINT N'Database DataWarehouse already exists; skipping creation.';
END;
GO

/* Run the remaining statements in the project database. */
USE [DataWarehouse];
GO

/*
    Create the warehouse layer schemas.
    dbo is specified as the owner so permissions can be managed centrally.
*/
IF SCHEMA_ID(N'bronze') IS NULL
    EXEC(N'CREATE SCHEMA [bronze] AUTHORIZATION [dbo];');
ELSE
    PRINT N'Schema bronze already exists; skipping creation.';
GO

IF SCHEMA_ID(N'silver') IS NULL
    EXEC(N'CREATE SCHEMA [silver] AUTHORIZATION [dbo];');
ELSE
    PRINT N'Schema silver already exists; skipping creation.';
GO

IF SCHEMA_ID(N'gold') IS NULL
    EXEC(N'CREATE SCHEMA [gold] AUTHORIZATION [dbo];');
ELSE
    PRINT N'Schema gold already exists; skipping creation.';
GO

/* Confirm the project schemas now present in the database. */
SELECT
    s.name AS schema_name,
    USER_NAME(s.principal_id) AS schema_owner
FROM sys.schemas AS s
WHERE s.name IN (N'bronze', N'silver', N'gold')
ORDER BY
    CASE s.name
        WHEN N'bronze' THEN 1
        WHEN N'silver' THEN 2
        WHEN N'gold' THEN 3
    END;
GO

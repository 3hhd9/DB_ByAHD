
-- Use the new database
USE CompanyDB;
GO

--Create schemas for HR and Sales
CREATE SCHEMA HR;
CREATE SCHEMA Sales;
GO

-- Create tables under each schema

-- HR schema table
CREATE TABLE HR.Employees (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    JobTitle VARCHAR(100),
    Department VARCHAR(50)
);

-- Sales schema table
CREATE TABLE Sales.Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Region VARCHAR(50),
    SalesAmount DECIMAL(10, 2)
);
GO


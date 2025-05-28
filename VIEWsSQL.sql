use [SQL Views] 
CREATE TABLE Customer ( 
    CustomerID INT PRIMARY KEY, 
    FullName NVARCHAR(100), 
    Email NVARCHAR(100), 
    Phone NVARCHAR(15), 
    SSN CHAR(9) 
); 

CREATE TABLE Account ( 
    AccountID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    Balance DECIMAL(10, 2), 
    AccountType VARCHAR(50), 
    Status VARCHAR(20) 
); 
 
CREATE TABLE [Transaction] ( 
    TransactionID INT PRIMARY KEY, 
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID), 
    Amount DECIMAL(10, 2), 
    Type VARCHAR(10), -- Deposit, Withdraw 
    TransactionDate DATETIME 
);
 
CREATE TABLE Loan ( 
    LoanID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    LoanAmount DECIMAL(12, 2), 
    LoanType VARCHAR(50), 
    Status VARCHAR(20) 
);

--1. Customer Service View
CREATE VIEW [CustomerServiceView] AS
SELECT 
    c.FullName AS CustomerName,
    c.Phone,
    a.Status AS AccountStatus
FROM 
    Customer c
JOIN 
    Account a ON c.CustomerID = a.CustomerID;

--2. Finance Department View 
 CREATE VIEW [FinanceDepartmentView] AS
SELECT 
    AccountID,
    Balance,
    AccountType
FROM 
    Account;
--3. Loan Officer View
CREATE VIEW [LoanOfficerView] AS
SELECT 
    LoanID,
    CustomerID,
    LoanAmount,
    LoanType,
    Status
FROM 
    Loan;
-- 4. Transaction Summary View
CREATE VIEW [TransactionSummaryView] AS
SELECT 
    AccountID,
    Amount,
    TransactionDate
FROM 
    [Transaction]
WHERE 
    TransactionDate >= DATEADD(DAY, -30, GETDATE());
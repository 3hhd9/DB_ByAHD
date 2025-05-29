-- FULL BACKUP - Every Sunday at 2:00 AM
USE HospitalDB;
GO
BACKUP DATABASE HospitalDB
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\HospitalDB_FULL.bak'
WITH FORMAT, INIT, NAME = 'Full Backup of HospitalDB';
GO


-- DIFFERENTIAL BACKUP - Every Mon–Sat at 2:00 AM
USE HospitalDB;
GO
BACKUP DATABASE HospitalDB
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\HospitalDB_DIFF.bak'
WITH DIFFERENTIAL, INIT, NAME = 'Differential Backup of HospitalDB';
GO

-- TRANSACTION LOG BACKUP - Every hour (24/7)
USE HospitalDB;
GO
BACKUP LOG HospitalDB
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\HospitalDB_LOG.trn'
WITH INIT, NAME = 'Transaction Log Backup of HospitalDB';
GO


--  Backup Strategy Summary
-- Database Name: HospitalDB
--
-- Full Backup: Every Sunday at 2:00 AM
-- Differential Backup: Every day (Mon–Sat) at 2:00 AM
-- Transaction Log Backup: Every hour, 24/7
--
-- Backup Folder: C:\SQLBackups\HospitalDB\
--
-- Naming Convention:
--   Full: HospitalDB_FULL_YYYYMMDD.bak
--   Diff: HospitalDB_DIFF_YYYYMMDD.bak
--   Log : HospitalDB_LOG_YYYYMMDD_HHMM.trn

-- Backup Folder Structure:
-- C:\SQLBackups\
-- └── HospitalDB\
--     ├── 2025\
--     │   ├── 05\
--     │   │   ├── HospitalDB_FULL_20250525_020000.bak
--     │   │   ├── HospitalDB_DIFF_20250526_020000.bak
--     │   │   ├── HospitalDB_DIFF_20250527_020000.bak
--     │   │   ├── HospitalDB_LOG_20250527_130000.trn
--     │   │   ├── HospitalDB_LOG_20250527_140000.trn
--     │   │   └── ...
--     │   └── 06\
--     │       ├── HospitalDB_FULL_20250601_020000.bak
--     │       └── ...

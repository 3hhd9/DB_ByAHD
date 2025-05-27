-- Trainees Table
CREATE TABLE Trainees ( 
    TraineeID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    Program VARCHAR(50), 
    GraduationDate DATE 
);

-- Job Applicants Table 
CREATE TABLE Applicants ( 
    ApplicantID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    Source VARCHAR(20), -- e.g., "Website", "Referral" 
    AppliedDate DATE 
);
--Sample Data 
-- Insert into Trainees 
INSERT INTO Trainees VALUES 
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'), 
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'), 
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01'); 
 
-- Insert into Applicants 
INSERT INTO Applicants VALUES 
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'), 
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'),
-- same person as trainee 
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');
--part1:
--1. List all unique people (FullName, Email) who either trained or applied using UNION:
SELECT FullName, Email FROM Trainees
UNION
SELECT FullName, Email FROM Applicants;--5rows

--2. Use UNION ALL and explain the change:
SELECT FullName, Email FROM Trainees
UNION ALL
SELECT FullName, Email FROM Applicants;--6 rows
--UNION ALL does not remove duplicates

--3. Find people who are in both tables (simulate INTERSECT using INNER JOIN):
SELECT t.FullName, t.Email
FROM Trainees t
INNER JOIN Applicants a ON t.Email = a.Email;



--Part 2: DROP, DELETE, TRUNCATE Observation

--4. DELETE FROM Trainees WHERE Program = 'Outsystems';
DELETE FROM Trainees WHERE Program = 'Outsystems';

Select * from Trainees
--5.Try TRUNCATE TABLE Applicants.
TRUNCATE TABLE Applicants;
Select * from Applicants
-- all rows deleted 
--6. Try DROP TABLE Applicants.
DROP TABLE Applicants;
Select * from Applicants;    


-- 5.Task:

-- to solve task % i will recreate table Applicants :
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Source VARCHAR(20),
    AppliedDate DATE
);

-- Reinsert sample data (if you have it)
INSERT INTO Applicants VALUES
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'),
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'),
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');

--4.Research:

BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO Applicants (ApplicantID, FullName, Email, Source, AppliedDate)
    VALUES (104, 'Majid Al Abri', 'majid.a@example.com', 'Website', '2025-05-10');

    -- This will fail due to duplicate ApplicantID
    INSERT INTO Applicants (ApplicantID, FullName, Email, Source, AppliedDate)
    VALUES (104, 'Sara Al Zadjali', 'sara.z@example.com', 'Referral', '2025-05-11');

    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION

    PRINT 'Transaction failed and was rolled back.';
    PRINT ERROR_MESSAGE();  -- Optional: show error details
END CATCH


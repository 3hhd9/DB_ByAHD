--Schema (All levels share these tables)
-------------------------------------------------------------------------------
-- Company table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(50),
    City VARCHAR(50)
);
SELECT * FROM Companies;


-- Job Seekers
CREATE TABLE JobSeekers (
    SeekerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    ExperienceYears INT,
    City VARCHAR(50)
);
SELECT * FROM JobSeekers;
-- Job Postings
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    CompanyID INT,
    Salary DECIMAL(10, 2),
    Location VARCHAR(50),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);
SELECT * FROM Jobs;
-- Applications
CREATE TABLE Applications (
    AppID INT PRIMARY KEY,
    JobID INT,
    SeekerID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (SeekerID) REFERENCES JobSeekers(SeekerID)
);
SELECT * FROM Applications;
--Sample Data
-------------------------------------------------------------------------
-- Companies
INSERT INTO Companies VALUES
(1, 'TechWave', 'IT', 'Muscat'),
(2, 'GreenEnergy', 'Energy', 'Sohar'),
(3, 'EduBridge', 'Education', 'Salalah');
-- Job Seekers
INSERT INTO JobSeekers VALUES
(101, 'Sara Al Busaidi', 'sara.b@example.com', 2, 'Muscat'),
(102, 'Ahmed Al Hinai', 'ahmed.h@example.com', 5, 'Nizwa'),
(103, 'Mona Al Zadjali', 'mona.z@example.com', 1, 'Salalah'),
(104, 'Hassan Al Lawati', 'hassan.l@example.com', 3, 'Muscat');
-- Jobs
INSERT INTO Jobs VALUES
(201, 'Software Developer', 1, 900, 'Muscat'),
(202, 'Data Analyst', 1, 800, 'Muscat'),
(203, 'Science Teacher', 3, 700, 'Salalah'),
(204, 'Field Engineer', 2, 950, 'Sohar');
-- Applications
INSERT INTO Applications VALUES
(301, 201, 101, '2025-05-01', 'Pending'),
(302, 202, 104, '2025-05-02', 'Shortlisted'),
(303, 203, 103, '2025-05-03', 'Rejected'),
(304, 204, 102, '2025-05-04', 'Pending');

--task 1: Show each applicant’s name, the job they applied for, and the company name.
--shortcuts (JS -> JobSeekers, J -> Jobs, C -> Companies, A -> Applications).
-- Show applicant full names, job titles, and company names for those who have actually applied
SELECT 
    JS.FullName AS ApplicantName,
    J.Title AS JobTitle,
    C.Name AS CompanyName
FROM 
    Applications A
    JOIN JobSeekers JS ON A.SeekerID = JS.SeekerID
    JOIN Jobs J ON A.JobID = J.JobID
    JOIN Companies C ON J.CompanyID = C.CompanyID;

--Task 2: Task 2 – “Empty Chairs” Show all job titles and their company names, 
--even if nobody has applied to them yet. 
-- Use LEFT JOIN from Jobs ? Applications.
SELECT 
    J.Title AS JobTitle,
    C.Name AS CompanyName
FROM 
    Jobs J
    LEFT JOIN Applications A ON J.JobID = A.JobID
    JOIN Companies C ON J.CompanyID = C.CompanyID
GROUP BY 
    J.JobID, J.Title, C.Name;

--task 3:
--find all job seekers who applied to jobs located in the same city where they live
SELECT 
    JS.FullName AS JobSeekerName,
    J.Title AS JobTitle,
    JS.City AS City
FROM 
    Applications A
    JOIN JobSeekers JS ON A.SeekerID = JS.SeekerID
    JOIN Jobs J ON A.JobID = J.JobID
	-- Only show applicants whose city matches the job location
WHERE 
    JS.City = J.Location; 
	
-- task 4: List all job seekers and, if they have applied,
--show the job titles and application status; 
-- show NULL for job title and status if no application exists
SELECT 
    JS.FullName AS JobSeekerName,
    J.Title AS JobTitle,
    A.Status AS ApplicationStatus
FROM 
    JobSeekers JS
    LEFT JOIN Applications A ON JS.SeekerID = A.SeekerID
    LEFT JOIN Jobs J ON A.JobID = J.JobID;

--task5: 
SELECT 
    J.Title AS JobTitle,
    JS.FullName AS ApplicantName
FROM 
    Jobs J
    LEFT JOIN Applications A ON J.JobID = A.JobID
    LEFT JOIN JobSeekers JS ON A.SeekerID = JS.SeekerID;

-- Task 6: Unapplied Seekers
--  Find job seekers who not applied to any jobs.
--  Use LEFT JOIN from JobSeekers to Applications and filter where Application data is NULL.
SELECT 
    JS.FullName AS JobSeekerName,
    JS.Email AS Email
FROM 
    JobSeekers JS
    LEFT JOIN Applications A ON JS.SeekerID = A.SeekerID
WHERE 
    A.AppID IS NULL; 


-- Task 7: Vacant Companies Find companies that have not posted any jobs.
-- Approach: Use LEFT JOIN from Companies to Jobs and filter where JobID is NULL.

SELECT 
    C.Name AS CompanyName,
    C.City AS City,
    C.Industry AS Industry
FROM 
    Companies C
    LEFT JOIN Jobs J ON C.CompanyID = J.CompanyID
WHERE 
    J.JobID IS NULL; 

-- Task 8: Same City, Different People, List all pairs of job seekers who live in the same city but are not the same person.
-- Use SELF JOIN on JobSeekers table, matching city but different IDs.

SELECT 
    S1.FullName AS Seeker1,
    S2.FullName AS Seeker2,
    S1.City AS SharedCity
FROM 
    JobSeekers S1
    JOIN JobSeekers S2 ON 
        S1.City = S2.City AND  -- Same city
        S1.SeekerID <> S2.SeekerID;  -- Not the same person

-- Task 9: High Salary, Wrong City:Find job seekers who applied to jobs with salaries above 850
-- but in a different city than where they live.
SELECT 
    JS.FullName AS JobSeekerName,
    JS.City AS SeekerCity,
    J.Title AS JobTitle,
    J.Location AS JobCity,
    J.Salary
FROM 
    Applications A
    JOIN JobSeekers JS ON A.SeekerID = JS.SeekerID
    JOIN Jobs J ON A.JobID = J.JobID
WHERE 
    J.Salary > 850 AND
    JS.City <> J.Location;


-- Task 10: Unmatched Applications
--Show all job seekers along with the city they live in and the city of the jobs they applied to.
SELECT
    JS.FullName AS JobSeekerName,
    JS.City AS SeekerCity,
    J.Location AS JobCity
FROM
    JobSeekers JS
    JOIN Applications A ON JS.SeekerID = A.SeekerID
    JOIN Jobs J ON A.JobID = J.JobID;

--task 11:Jobs With No Applicants
--Show all job titles where no applications have been submitted.
SELECT 
    J.Title AS JobTitle,
    J.Location AS JobLocation
FROM 
    Jobs J
    LEFT JOIN Applications A ON J.JobID = A.JobID
WHERE 
    A.AppID IS NULL;  

-- Task 12: Applications From the Same City
--Find job seekers who applied to jobs located in the same city they live in.
SELECT 
    JS.FullName AS JobSeekerName,
    J.Title AS JobTitle,
    JS.City AS City
FROM 
    Applications A
    JOIN JobSeekers JS ON A.SeekerID = JS.SeekerID
    JOIN Jobs J ON A.JobID = J.JobID
WHERE 
    JS.City = J.Location;

-- Task 13: Different Job, Same City Applicants
-- Find pairs of seekers living in the same city but applied to different jobs.

SELECT DISTINCT
    JS1.FullName AS Seeker1,
    JS2.FullName AS Seeker2,
    JS1.City AS SharedCity,
    J1.Title AS Job1,
    J2.Title AS Job2
FROM 
    JobSeekers JS1
    JOIN Applications A1 ON JS1.SeekerID = A1.SeekerID
    JOIN Jobs J1 ON A1.JobID = J1.JobID
    JOIN JobSeekers JS2 ON JS1.City = JS2.City AND JS1.SeekerID <> JS2.SeekerID
    JOIN Applications A2 ON JS2.SeekerID = A2.SeekerID
    JOIN Jobs J2 ON A2.JobID = J2.JobID
WHERE 
    J1.JobID <> J2.JobID;

-- Task 14: Different Job, Same City Applicants
-- Find pairs of seekers living in the same city but applied to different jobs.
SELECT DISTINCT
    JS1.FullName AS Seeker1,
    JS2.FullName AS Seeker2,
    JS1.City AS SharedCity,
    J1.Title AS Job1,
    J2.Title AS Job2
FROM 
    JobSeekers JS1
    JOIN Applications A1 ON JS1.SeekerID = A1.SeekerID
    JOIN Jobs J1 ON A1.JobID = J1.JobID
    JOIN JobSeekers JS2 ON JS1.City = JS2.City AND JS1.SeekerID <> JS2.SeekerID
    JOIN Applications A2 ON JS2.SeekerID = A2.SeekerID
    JOIN Jobs J2 ON A2.JobID = J2.JobID
WHERE 
    J1.JobID <> J2.JobID;

-- Task 15: Jobless City, Active People
-- Find cities with job seekers but no company located there.

SELECT DISTINCT
    JS.City AS CityWithSeekersNoCompany
FROM
    JobSeekers JS
    LEFT JOIN Companies C ON JS.City = C.City
WHERE
    C.City IS NULL;


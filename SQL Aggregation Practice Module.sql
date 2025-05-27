--Step 1: Create the Tables
CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
Title VARCHAR(100),
InstructorID INT,
CategoryID INT,
Price DECIMAL(6,2),
PublishDate DATE,
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
EnrollDate DATE,
CompletionPercent INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

--Step 2: Insert Sample Data
-- Instructors
INSERT INTO Instructors VALUES
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'),
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21');
-- Categories
INSERT INTO Categories VALUES
(1, 'Web Development'),
(2, 'Data Science'),
(3, 'Business');
-- Courses
INSERT INTO Courses VALUES
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'),
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'),
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'),
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01');
-- Students
INSERT INTO Students VALUES
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'),
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'),
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10');
-- Enrollments
INSERT INTO Enrollments VALUES
(1, 201, 101, '2023-04-10', 100, 5),
(2, 202, 102, '2023-04-15', 80, 4),
(3, 203, 101, '2023-04-20', 90, 4),
(4, 201, 102, '2023-04-22', 50, 3),
(5, 202, 103, '2023-04-25', 70, 4),
(6, 203, 104, '2023-04-28', 30, 2),
(7, 201, 104, '2023-05-01', 60, 3);

--biggener:
--1. Count total number of students:
SELECT COUNT(*) AS TotalStudents FROM Students;

--2. Count total number of enrollments:
SELECT COUNT(*) AS TotalEnrollments FROM Enrollments;

--3. Find average rating of each course:
SELECT CourseID, AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;

--4. Total number of courses per instructor:
SELECT InstructorID, COUNT(*) AS TotalCourses
FROM Courses
GROUP BY InstructorID;
--5. Number of courses in each category:
SELECT CategoryID, COUNT(*) AS CourseCount
FROM Courses
GROUP BY CategoryID;
--6. Number of students enrolled in each course.
SELECT CourseID, COUNT(StudentID) AS EnrolledStudents
FROM Enrollments
GROUP BY CourseID;

--7.Average course price per category.
SELECT CategoryID, AVG(Price) AS AvgPrice
FROM Courses
GROUP BY CategoryID;

-- 8.Maximum course price.
SELECT MAX(Price) AS MaxPrice FROM Courses;
--9.Min, Max, and Avg rating per course.
SELECT CourseID, MIN(Rating) AS MinRating, MAX(Rating) AS MaxRating, AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;
--10.Count how many students gave rating = 5.
SELECT COUNT(*) AS RatingFiveCount
FROM Enrollments
WHERE Rating = 5;

-- Intermediate Level

-- 1. Average completion per course
SELECT CourseID, AVG(CompletionPercent) AS AvgCompletion
FROM Enrollments
GROUP BY CourseID;

-- 2. Students enrolled in more than 1 course
SELECT StudentID, COUNT(*) AS CourseCount
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 1;
-- 3. Revenue per course
SELECT E.CourseID, SUM(C.Price) AS Revenue
FROM Enrollments E
JOIN Courses C ON E.CourseID = C.CourseID
GROUP BY E.CourseID;

-- 4. Instructor name + distinct students
SELECT I.FullName, COUNT(DISTINCT E.StudentID) AS TotalStudents
FROM Instructors I
JOIN Courses C ON I.InstructorID = C.InstructorID
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY I.FullName;

-- 5. Average enrollments per category
SELECT C.CategoryID, AVG(EnrollCount) AS AvgEnrollments
FROM (
  SELECT Co.CategoryID, Co.CourseID, COUNT(E.EnrollmentID) AS EnrollCount
  FROM Courses Co
  LEFT JOIN Enrollments E ON Co.CourseID = E.CourseID
  GROUP BY Co.CourseID, Co.CategoryID
) AS C
GROUP BY C.CategoryID;

-- 6. Average course rating by instructor
SELECT I.InstructorID, I.FullName, AVG(E.Rating) AS AvgRating
FROM Instructors I
JOIN Courses C ON I.InstructorID = C.InstructorID
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY I.InstructorID, I.FullName;

-- 7. Top 3 courses by enrollments
SELECT TOP 3 CourseID, COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY CourseID
ORDER BY TotalEnrollments DESC;

-- 8. Average days to complete 100% (mock logic)

-- Assuming CompletionPercent = 100 means completed
-- Assume duration is EnrollDate to a fake CompletionDate (not provided), so skipping implementation
-- 9. % students who completed each course
SELECT CourseID,
  100.0 * SUM(CASE WHEN CompletionPercent = 100 THEN 1 ELSE 0 END) / COUNT(*) AS CompletionRate
FROM Enrollments
GROUP BY CourseID;

-- 10. Courses published per year
SELECT YEAR(PublishDate) AS PublishYear, COUNT(*) AS TotalCourses
FROM Courses
GROUP BY YEAR(PublishDate);

-- Advanced Level

SELECT TOP 1 StudentID, COUNT(*) AS CompletedCourses
FROM Enrollments
WHERE CompletionPercent = 100
GROUP BY StudentID
ORDER BY CompletedCourses DESC;

-- 2. Instructor earnings from enrollments
SELECT I.InstructorID, I.FullName, SUM(C.Price) AS TotalEarnings
FROM Instructors I
JOIN Courses C ON I.InstructorID = C.InstructorID
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY I.InstructorID, I.FullName;
-- 3. Category avg rating (>= 4)
SELECT Ca.CategoryID, Ca.CategoryName, AVG(E.Rating) AS AvgRating
FROM Categories Ca
JOIN Courses C ON Ca.CategoryID = C.CategoryID
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY Ca.CategoryID, Ca.CategoryName
HAVING AVG(E.Rating) >= 4;

-- 4. Students rated below 3 more than once
SELECT StudentID, COUNT(*) AS LowRatings
FROM Enrollments
WHERE Rating < 3
GROUP BY StudentID
HAVING COUNT(*) > 1;

-- 5. Course with lowest average completion
SELECT TOP 1 CourseID, AVG(CompletionPercent) AS AvgCompletion
FROM Enrollments
GROUP BY CourseID
ORDER BY AvgCompletion ASC;

-- 6. Students enrolled in all courses by instructor 1
SELECT StudentID
FROM Enrollments E
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.InstructorID = 1
GROUP BY StudentID
HAVING COUNT(DISTINCT E.CourseID) = (
  SELECT COUNT(*) FROM Courses WHERE InstructorID = 1
);

-- 7. Duplicate ratings check
SELECT StudentID, CourseID, COUNT(*) AS RatingCount
FROM Enrollments
GROUP BY StudentID, CourseID
HAVING COUNT(*) > 1;

-- 8. Category with highest avg rating
SELECT TOP 1 Ca.CategoryID, Ca.CategoryName, AVG(E.Rating) AS AvgRating
FROM Categories Ca
JOIN Courses C ON Ca.CategoryID = C.CategoryID
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY Ca.CategoryID, Ca.CategoryName
ORDER BY AvgRating DESC;

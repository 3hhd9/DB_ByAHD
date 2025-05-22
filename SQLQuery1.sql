create database ENTERTAIN
use ENTERTAIN

CREATE TABLE Users ( 
  UserID INT PRIMARY KEY, 
  FullName VARCHAR(100), 
  JoinDate DATE, 
  SubscriptionType VARCHAR(50) 
); 
CREATE TABLE Movies ( 
  MovieID INT PRIMARY KEY, 
  Title VARCHAR(100), 
  Genre VARCHAR(50), 
  ReleaseYear INT, 
  DurationMinutes INT 
); 
CREATE TABLE WatchHistory ( 
  WatchID INT PRIMARY KEY, 
  UserID INT, 
  MovieID INT, 
  WatchDate DATE, 
  WatchDuration INT); 
--Sample Data (Insert at least 5 records per table) 
-- Users 
INSERT INTO Users VALUES  
(1, 'Alice Johnson', '2023-01-15', 'Premium'), 
(2, 'Bob Smith', '2023-03-20', 'Standard'), 
(3, 'Charlie Lee', '2023-02-05', 'Basic'), 
(4, 'Diana Ray', '2023-04-10', 'Premium'), 
(5, 'Ethan Park', '2023-01-25', 'Standard'); 
-- Movies 
INSERT INTO Movies VALUES 
(101, 'The Great Heist', 'Action', 2022, 120), 
(102, 'Laugh Out Loud', 'Comedy', 2023, 90), 
(103, 'Deep Dive', 'Documentary', 2021, 75), 
(104, 'Speed Chase', 'Action', 2023, 110), 
(105, 'Tears of Time', 'Drama', 2020, 105); 
-- WatchHistory 
INSERT INTO WatchHistory VALUES 
(1001, 1, 101, '2023-05-01', 115), 
(1002, 1, 102, '2023-05-02', 90), 
(1003, 2, 103, '2023-05-03', 75), 
(1004, 3, 104, '2023-05-01', 100), 
(1005, 4, 105, '2023-05-04', 105); 



-- 1. Display all users and their subscription types. 
SELECT FullName, SubscriptionType 
FROM Users;


--2. List all movies and their durations. 
Select  Title, DurationMinutes 
from Movies;

--3. Show all watch history records.
select * from WatchHistory;


--4. Find the titles and genres of all movies released after 2020. 
SELECT Title, Genre 
FROM Movies WHERE ReleaseYear > 2020;

--5. Show names of users who joined after February 2023. 
SELECT FullName 
From Users WHERE JoinDate > '2023-02-28'; 


--6. List movie titles that are longer than 100 minutes. 
SELECT Title FROM Movies WHERE DurationMinutes > 100;

--7. View all watch records by a specific user (e.g., UserID = 1). 
SELECT * FROM WatchHistory WHERE UserID = 1;

--8. Show all user names sorted by join date (newest first). 
SELECT  FullName FROM Users ORDER BY JoinDate DESC;

--9. Retrieve movies that belong to the 'Action' genre. 
SELECT * FROM Movies WHERE Genre = 'Action';

--10. Find all watch entries that happened on '2023-05-01'. 
SELECT * FROM WatchHistory WHERE WatchDate = '2023-05-01';

--11. Display full information of movies released in 2023. 
SELECT * FROM Movies WHERE ReleaseYear = 2023;

--12. Show names and subscription types of users who are not 'Basic' subscribers. 
SELECT FullName, SubscriptionType FROM Users WHERE SubscriptionType <> 'Basic';

--13. Retrieve all users whose names contain the letter 'a' (case insensitive for SQL Server). 
SELECT * FROM Users WHERE FullName LIKE '%a%';

--14. List movie titles that are exactly 90 minutes long. 
SELECT Title FROM Movies WHERE DurationMinutes = 90;

--15. Show all watch history entries where the watch duration was more than 100 minutes. 
SELECT * FROM WatchHistory WHERE WatchDuration > 100;
--16. View user names who joined in January 2023. 
SELECT FullName FROM Users 
WHERE JoinDate >= '2023-01-01' AND JoinDate < '2023-02-01';

--17. Display all movies sorted by title in alphabetical order.
SELECT * FROM Movies ORDER BY Title ASC;

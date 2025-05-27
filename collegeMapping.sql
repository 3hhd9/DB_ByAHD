
USE collegeMapping;
CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    D_name VARCHAR(100) NOT NULL
);
select * from Department;

CREATE TABLE Faculty (
    F_id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Mobile_no VARCHAR(15) UNIQUE,
    Department_id INT NOT NULL,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);
CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY,
    Subject_name VARCHAR(100) NOT NULL,
    F_id INT NOT NULL,
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id)
);
CREATE TABLE Hostel (
    Hostel_id INT PRIMARY KEY,
    Hostel_name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Address VARCHAR(100),
    Pin_code VARCHAR(10),
    No_of_seats INT
);
CREATE TABLE Student (
    S_id INT PRIMARY KEY,
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    Phone_no VARCHAR(15),
    DOB DATE,
    Department_id INT NOT NULL,
    Hostel_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
);
CREATE TABLE Course (
    Course_id INT PRIMARY KEY,
    Course_name VARCHAR(100),
    Duration VARCHAR(50),
    Department_id INT NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);
CREATE TABLE Student_Subject (
    S_id INT,
    Subject_id INT,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);
CREATE TABLE Enrollment (
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);
CREATE TABLE Exam (
    Exam_code INT PRIMARY KEY,
    Exam_date DATE,
    Exam_time TIME,
    Room VARCHAR(50),
    Department_id INT NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);
INSERT INTO Department (Department_id, D_name)
VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Business Administration');
INSERT INTO Faculty (F_id, Name, Mobile_no, Department_id, Salary)
VALUES
(101, 'Dr. Ahmed Al-Harthy', '91234567', 1, 1200.00),
(102, 'Dr. Fatma Al-Zadjali', '92345678', 2, 1100.00),
(103, 'Dr. Khalid Al-Rawahi', '93456789', 3, 1000.00);
INSERT INTO Subject (Subject_id, Subject_name, F_id)
VALUES
(201, 'Database Systems', 101),
(202, 'Thermodynamics', 102),
(203, 'Business Ethics', 103);
INSERT INTO Hostel (Hostel_id, Hostel_name, City, State, Address, Pin_code, No_of_seats)
VALUES
(1, 'Al Noor Hostel', 'Muscat', 'Muscat', 'Al Khuwair', '111', 100),
(2, 'Al Amal Hostel', 'Sohar', 'North Batinah', 'Falaj Al Qabail', '311', 80);
INSERT INTO Student (S_id, F_name, L_name, Phone_no, DOB, Department_id, Hostel_id)
VALUES
(1001, 'Salim', 'Al-Maawali', '95123456', '2003-05-01', 1, 1),
(1002, 'Muna', 'Al-Busaidi', '96234567', '2002-10-15', 2, 2),
(1003, 'Zahra', 'Al-Hinai', '97345678', '2001-12-25', 3, NULL);
INSERT INTO Course (Course_id, Course_name, Duration, Department_id)
VALUES
(301, 'BSc in CS', '4 Years', 1),
(302, 'BSc in ME', '4 Years', 2),
(303, 'BBA', '3 Years', 3);
INSERT INTO Student_Subject (S_id, Subject_id)
VALUES
(1001, 201),
(1002, 202),
(1003, 203),
(1001, 203);
INSERT INTO Enrollment (S_id, Course_id)
VALUES
(1001, 301),
(1002, 302),
(1003, 303);
INSERT INTO Exam (Exam_code, Exam_date, Exam_time, Room, Department_id)
VALUES
(401, '2024-12-10', '09:00:00', 'Room A101', 1),
(402, '2024-12-12', '11:00:00', 'Room B202', 2),
(403, '2024-12-14', '13:00:00', 'Room C303', 3);
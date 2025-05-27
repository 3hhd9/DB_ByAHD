CREATE TABLE Employee (
    SSN INT PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    Sex CHAR(1) CHECK (Sex IN ('M', 'F')),
    Bdate DATE,
    Salary DECIMAL(10,2) CHECK (Salary BETWEEN 500 AND 20000),
    Super_SSN INT,
    FOREIGN KEY (Super_SSN) REFERENCES Employee(SSN)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE Department (
    DNumber INT PRIMARY KEY,
    DName VARCHAR(50) UNIQUE NOT NULL,
    ManagerSSN INT NOT NULL,
    StartDate DATE,
    FOREIGN KEY (ManagerSSN) REFERENCES Employee(SSN)
		ON DELETE NO ACTION
        ON UPDATE CASCADE
);

CREATE TABLE Dept_Locations (
    DNumber INT,
    Location VARCHAR(100),
    PRIMARY KEY (DNumber, Location),
    FOREIGN KEY (DNumber) REFERENCES Department(DNumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Project (
    PNumber INT PRIMARY KEY,
    PName VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    DNumber INT NOT NULL,
    FOREIGN KEY (DNumber) REFERENCES Department(DNumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Works_On (
    SSN INT,
    PNumber INT,
    Hours DECIMAL(4,1) CHECK (Hours >= 0),
    PRIMARY KEY (SSN, PNumber),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
        ON DELETE CASCADE,
    FOREIGN KEY (PNumber) REFERENCES Project(PNumber)
        ON DELETE CASCADE
);

CREATE TABLE Dependent (
    DependentName VARCHAR(50),
    SSN INT,
    Sex CHAR(1) CHECK (Sex IN ('M', 'F')),
    Bdate DATE,
    Relationship VARCHAR(50),
    PRIMARY KEY (SSN, DependentName),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Employee (SSN, Fname, Minit, Lname, Address, Sex, Bdate, Salary, Super_SSN)
VALUES
(101, 'Ahmed', 'A', 'Salim', 'Muscat, Oman', 'M', '1980-05-15', 5000, NULL),
(102, 'Sara', 'K', 'Nasser', 'Sohar, Oman', 'F', '1990-04-22', 3500, 101),
(103, 'Hassan', 'M', 'Al-Balushi', 'Ibri, Oman', 'M', '1985-07-10', 4000, 101);
INSERT INTO Department (DNumber, DName, ManagerSSN, StartDate)
VALUES
(1, 'IT', 101, '2020-01-01'),
(2, 'HR', 102, '2021-03-15');
INSERT INTO Dept_Locations (DNumber, Location)
VALUES
(1, 'Muscat'),
(1, 'Nizwa'),
(2, 'Sohar');
INSERT INTO Project (PNumber, PName, Location, DNumber)
VALUES
(1001, 'ERP System', 'Muscat', 1),
(1002, 'Recruitment Drive', 'Sohar', 2),
(1003, 'Website Redesign', 'Nizwa', 1);
INSERT INTO Works_On (SSN, PNumber, Hours)
VALUES
(101, 1001, 15.5),
(102, 1002, 20.0),
(103, 1001, 10.0),
(103, 1003, 5.5);
INSERT INTO Dependent (DependentName, SSN, Sex, Bdate, Relationship)
VALUES
('Layla', 101, 'F', '2010-11-05', 'Daughter'),
('Khalid', 102, 'M', '2015-06-20', 'Son'),
('Salma', 103, 'F', '2012-03-13', 'Wife');
-- Create a new database called 'DatabaseName'
CREATE DATABASE DatabaseName;

-- Creating a database object, A table

CREATE TABLE department(
    deptid VARCHAR(20),
    name VARCHAR(20) NOT NULL,
    CONSTRAINT PK_DEPT PRIMARY KEY (deptid)
);

-- Inssert data into the table
INSERT INTO department (deptid, name) VALUES 
('D1', 'Management'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'IT'),
('D5', 'Marketing'),
('D6', 'Sales'),
('D7', 'Support'),
('D8', 'Development'),
('D9', 'Research'),
('D10', 'Administration');

-- view the top 2 data in the table
SELECT * FROM department LIMIT 2;

-- creating table for employee
CREATE TABLE employee (
    empid int,
    name VARCHAR(20) UNIQUE,
    join_date DATE NOT NULL,
    department CHAR(2)
    CHECK (department IN ('D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10')),
    salary int,
    manager int,
    CONSTRAINT PK_EMP PRIMARY KEY (empid),
    CONSTRAINT FK_DEPT FOREIGN KEY (department) REFERENCES department(deptid)
);

-- Insert data into the employee table
INSERT into employee VALUES
(101, 'David', '2009-07-14', 'D1', 50000, NULL),
(102, 'Sam', '2010-06-24', 'D1', 40000, 101),
(103, 'Alicia', '2011-05-11', 'D2', 30000, 102),
(104, 'Alex', '2012-04-15', 'D2', 20000, 102),
(105, 'Robbi', '2013-08-14', 'D2', 20000, 102),
(106, 'Jack', '2014-09-19', 'D3', 8000, 101),
(107, 'Tom', '2015-11-12', NULL, 5000, 116),
(108, 'Lily', '2016-07-28', 'D1', 1000, 106),
(109, 'Heidi', '2017-03-22', 'D9', 80000, 104);

-- view the top 2 data in the table
SELECT * FROM employee LIMIT 2;

-- Creating table for project
CREATE TABLE project (
    person VARCHAR(20),
    proj_name VARCHAR(20),
    job_description VARCHAR(100)
);
-- Insert data into the project table
INSERT INTO project VALUES
('David', 'Ecommerce', 'generate and manage sales via online channels'),
('Sam', 'Inventory', 'manage location and pricing of inventory'),
('Alicia', 'Inventory', 'manage products that are in storage or transit'),
('Ryan', 'Ecommerce', 'advertising and marketing efforts of a company'),
('Ellen', 'Inventory', 'manage overall operations and help employees'),
('Jack', 'Ecommerce', 'manage the flow of goods and services'),
('Heidi', 'Inventory', 'manage the flow of goods and services'),
('Robbi', 'Inventory', 'manage the flow of goods and services'),
('Alex', 'Inventory', 'manage the flow of goods and services');

-- Creating table for Sale
DROP TABLE IF EXISTS sale;

CREATE TABLE sale (
    category VARCHAR(20),
    brand VARCHAR(20),
    name VARCHAR(50) NOT NULL,
    quantity INT CHECK (quantity >= 0),
    price FLOAT NOT NULL,
    stock BOOLEAN,
    CONSTRAINT PK_CITY PRIMARY KEY(name)
);

-- Insert data into the sale table
INSERT INTO sale VALUES
('Phone', 'Apple', 'iPhone 13', 4, 1300, '0'),
('Phone', 'Apple', 'iPhone 12', 6, 1100, '1'),
('Phone', 'Samsung', 'Galaxy Note 20', 5, 1200, '1'),
('Phone', 'Samsung', 'Galaxy S21', 4, 1100, '0'),
('Laptop', 'Apple', 'MacBook Pro 13', 3, 2000, '1'),
('Laptop', 'Apple', 'MacBook Air', 2, 1200, '1'),
('Laptop', 'Dell', 'XPS 13', 1, 2000, '0'),
('Laptop', 'Dell', 'XPS 15', 2, 2300, '1'),
('Tablet', 'Apple', 'ipad 7th gen', 3, 560, '0'),
('Tablet', 'Samsung', 'Galaxy Tab A7', 2, 220, '1');

-- view the top 2 data in the table
SELECT * FROM sale LIMIT 2;

-- Creating a backup table
DROP TABLE IF EXISTS Backup;
-- duplicating the employee table to Backup table
CREATE TABLE Backup AS SELECT * FROM employee;

-- Updating data in the employee table
UPDATE employee
SET manager = 106, department = 'D5'
WHERE name = 'Tom';

UPDATE employee
SET department = 'D3', salary = 10000
WHERE name = 'Lily';

-- Delete data from department table
DELETE FROM department
WHERE deptid = 'D10 ';

-- Deleting Multiple records from employee table
DELETE FROM employee
WHERE name IN ('Alicia', 'Jack', 'Heidi');

-- performing operators on the employee table
SELECT name, salary
FROM employee
WHERE salary > 10000
ORDER BY name ASC
LIMIT 3;

-- Fetching product in stock with price range
SELECT name, brand, price, stock
FROM sale
WHERE price BETWEEN 1000 AND 2000
AND stock IN ('1')
ORDER BY price DESC;

-- Fetch employee data who join on April
SELECT * FROM employee
WHERE extract(MONTH FROM join_date) = '04';

-- Categorize employees based on their salary
SELECT name, salary,
CASE
WHEN salary >= 30000 THEN 'High'
WHEN salary BETWEEN 10000 AND 30000 THEN 'Medium'
ELSE 'Low'
END AS Salary_Range
FROM employee
ORDER BY salary DESC;

-- employee that work on projects
SELECT e.name, p.proj_name, p.job_description
FROM employee e
JOIN project p ON e.name = p.person
ORDER BY e.name, p.proj_name;

SELECT name FROM employee
INTERSECT
SELECT person FROM project;
-- employee that work on projects
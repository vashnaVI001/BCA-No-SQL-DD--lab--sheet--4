-- Q12: Employee CRUD using CQL
CREATE KEYSPACE IF NOT EXISTS CompanyDB
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE CompanyDB;

CREATE TABLE IF NOT EXISTS Employees (
    employee_id text PRIMARY KEY,
    name text,
    department text,
    role text,
    salary decimal
);

INSERT INTO Employees (employee_id, name, department, role, salary)
VALUES ('E101', 'Aman', 'IT', 'Developer', 45000);
INSERT INTO Employees (employee_id, name, department, role, salary)
VALUES ('E102', 'Riya', 'HR', 'Executive', 40000);
SELECT * FROM Employees;
SELECT * FROM Employees WHERE employee_id = 'E101';
UPDATE Employees SET role = 'Senior Developer', salary = 55000 WHERE employee_id = 'E101';
DELETE FROM Employees WHERE employee_id = 'E102';
SELECT * FROM Employees;

-- Create Table : employee

CREATE TABLE employee (
    eid NUMBER(2),
    name VARCHAR2(20),
    jid NUMBER(3),
    did NUMBER(4),
    salary NUMBER(8)
);

-- modify length 
ALTER TABLE employee MODIFY (eid NUMBER(3));

ALTER TABLE employee MODIFY (salary NUMBER(8));

-- insert values 
INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (101, 'Alice', 10, 2, 450000);

INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (102, 'Brion', 11, 2, 52000);

INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (105, 'Clota', 12, 3, 47000);

INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (104, 'Derek', 13, 4, 43000);

-- Employee with Minimum Salary
SELECT *
FROM employee
WHERE salary = (SELECT MIN(salary) FROM employee);

-- Employee with Salary Equal to EID 101
SELECT *
FROM employee
WHERE salary = (SELECT salary FROM employee WHERE eid = 101);

-- Employee with Matching JID and Higher Salary
SELECT *
FROM employee
WHERE jid = (SELECT jid FROM employee WHERE eid = 102)
  AND salary > (SELECT salary FROM employee WHERE eid = 105);

-- Employees Earning Their Department's Minimum
SELECT *
FROM employee e
WHERE e.salary = (
    SELECT MIN(salary)
    FROM employee
    WHERE did = e.did
);

-- Job ID with the Lowest Average Salary
SELECT jid
FROM employee
GROUP BY jid
HAVING AVG(salary) = (
    SELECT MIN(AVG(salary))
    FROM (
        SELECT AVG(salary) AS Avg_Sal
        FROM employee
        GROUP BY jid
    ) t
);

-- Departments with High Minimum Salaries
SELECT did, MIN(salary)
FROM employee
GROUP BY did
HAVING MIN(salary) >= (SELECT MIN(salary) FROM employee WHERE did = 4);


# practical 6

-- create table of department
CREATE TABLE department (
    did NUMBER(4) PRIMARY KEY,
    dname VARCHAR2(30),
    location VARCHAR2(50)
);

-- insert values
INSERT INTO department (did, dname, location)
VALUES (2, 'Engineering', 'Main Campus');

INSERT INTO department (did, dname, location)
VALUES (3, 'Sales', 'Headquarters');

INSERT INTO department (did, dname, location)
VALUES (4, 'Marketing', 'East Wing');

-- 3.Link Your Tables 
ALTER TABLE employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (did)
REFERENCES department(did);

-- count()
SELECT
    did,
    COUNT(eid) AS employee_count,
    AVG(salary) AS average_salary
FROM
    employee
GROUP BY
    did;

-- 1. SUM(): Total Salary per Department 
SELECT
    did,
    SUM(salary) AS total_payroll
FROM
    employee
GROUP BY
    did;

-- 2. MAX(): Highest Salary per Department
SELECT
    did,
    MAX(salary) AS highest_salary
FROM
    employee
GROUP BY
    did;

-- 3. MIN(): Lowest Salary per Department 
SELECT
    did,
    MIN(salary) AS lowest_salary
FROM
    employee
GROUP BY
    did;

-- 4. Using HAVING: Filtering the Groups
SELECT
    did,
    SUM(salary) AS total_payroll
FROM
    employee
GROUP BY
    did
HAVING
    SUM(salary) < 100000;




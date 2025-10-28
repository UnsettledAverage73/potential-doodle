CREATE TABLE employee (
    eid NUMBER(2),
    name VARCHAR2(20),
    jid NUMBER(3),
    did NUMBER(4),
    salary NUMBER(8)
);

ALTER TABLE employee MODIFY (eid NUMBER(3));

ALTER TABLE employee MODIFY (salary NUMBER(8));

INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (101, 'Alice', 10, 2, 450000);

INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (102, 'Brion', 11, 2, 52000);

INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (105, 'Clota', 12, 3, 47000);

INSERT INTO employee (eid, name, jid, did, salary) 
VALUES (104, 'Derek', 13, 4, 43000);

SELECT *
FROM employee
WHERE salary = (SELECT MIN(salary) FROM employee);

SELECT *
FROM employee
WHERE salary = (SELECT salary FROM employee WHERE eid = 101);

SELECT *
FROM employee
WHERE jid = (SELECT jid FROM employee WHERE eid = 102)
  AND salary > (SELECT salary FROM employee WHERE eid = 105);

SELECT *
FROM employee e
WHERE e.salary = (
    SELECT MIN(salary)
    FROM employee
    WHERE did = e.did
);

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

SELECT did, MIN(salary)
FROM employee
GROUP BY did
HAVING MIN(salary) >= (SELECT MIN(salary) FROM employee WHERE did = 4);


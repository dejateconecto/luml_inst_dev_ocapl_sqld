/*#################################################################################################################
*                                                            1
*                                      Retrieving Data Using the SQL SELECT Statement
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--
--1)
SELECT
  last_name
  ,job_id
  ,salary AS Sal
FROM employees;
--True

--2)
SELECT * 
FROM job_grades;
--True

--3)
SELECT
  employee_id
  ,last_name
  sal x 12 ANNUAL SALARY  
FROM employees;
-- Comma symbol is missing, use "*" not "x" for multiplication op and "USE Doble quote for aliases phrases Case Sensitive"

--########################################              Part 2            #######################################--

--4)
DESC departments;
SELECT * 
FROM departments;

--5)
DESC employees;

SELECT
  employee_id
  ,last_name
  ,job_id
  ,hire_date STARTDATE
FROM employees;
-- saved as lab_01_05.sql

--6)
--Verified

--7)
SELECT 
  DISTINCT(job_id)
FROM employees;

--########################################              Part 3            #######################################--

--8)
SELECT
  employee_id "Emp #"
  ,last_name "Employee"
  ,job_id "Job"
  ,hire_date "Hire Date"
FROM employees;

--9)
SELECT
  last_name
  || q'<, >'
  || job_id "Employee and Title"
FROM employees;

--10)
SELECT
  employee_id
  || q'<,>'
  || first_name
  || q'<,>'
  || last_name
  || q'<,>'
  || email
  || q'<,>'
  || phone_number
  || q'<,>'
  || hire_date
  || q'<,>'
  || job_id
  || q'<,>'
  || salary
  || q'<,>'
  || commission_pct
  || q'<,>'
  || manager_id
  || q'<,>'
  || department_id THE_OUTPUT
FROM employees;

/*#################################################################################################################                                                           
*                                                      End of practice 1        
*################################################################################################################*/


/*#################################################################################################################
*                                                            2
*                                               Restrincting and Sorting Data
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)
SELECT 
  last_name
  ,salary
FROM employees
WHERE salary > 12000;
--saved as lab_02_01.sql

--2
SELECT
  last_name
  ,department_id
FROM employees
WHERE employee_id = 176;

--3)
SELECT 
  last_name
  ,salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;
--saved as lab_02_03.sql
  
--4)
SELECT
  last_name
  ,job_id
  ,hire_date
FROM employees
WHERE last_name IN ('Matos','Taylor')
ORDER BY hire_date;

--5
SELECT
  last_name
  ,department_id
FROM employees  
WHERE (department_id = 20 OR department_id = 50)
ORDER BY last_name;

--6)
SELECT 
  last_name "Employee"
  ,salary "Monthly Salary"
FROM employees
WHERE salary BETWEEN 5000 AND 12000
AND department_id IN (20,50);
--saved as lab_02_06.sql

--7)
SELECT 
  last_name
  ,hire_date
FROM employees
WHERE hire_date LIKE '%94';

--8)
SELECT
  last_name
  ,job_id
FROM employees
WHERE manager_id IS NULL;

--9)
SELECT
  last_name
  ,salary
  ,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY 2 DESC, 3 DESC;

--10)
SELECT 
  last_name
  ,salary
FROM employees
WHERE salary > &var_salary
ORDER BY salary;

--11)
SELECT 
  employee_id
  ,last_name
  ,salary
  ,department_id
FROM employees
WHERE manager_id = &var_manager_id
ORDER BY &var_column;

--12)
SELECT
  last_name
FROM employees
WHERE INSTR(last_name,'a',1) = 3;
--last_name LIKE '__a%';

--13)
SELECT 
  last_name
FROM employees
WHERE (last_name LIKE '%a%' AND last_name LIKE '%e%');

--14)
SELECT 
  last_name
  ,job_id
  ,salary
FROM employees
WHERE job_id IN ('SA_REP','ST_CLERK')
  AND salary NOT IN (2500,3500,7000);

--15)
SELECT 
  last_name "Employee"
  ,salary "Monthly Salary"
  ,commission_pct
FROM employees
WHERE commission_pct = 0.2;
--saved as lab_02_15.sql

/*#################################################################################################################                                                           
*                                                      End of practice 2        
*################################################################################################################*/


/*#################################################################################################################
*                                                            3
*                                     Using Single-Row Functions to Customize Output
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)
SELECT 
  SYSDATE "Date"
FROM dual;

--2)
SELECT 
  employee_id
  ,last_name
  ,salary
  ,ROUND(salary * 1.155, 0) "New Salary"
FROM employees;
--saved as lab_03_02.sql

--3)
--run lab_03_02.sql

--4)
SELECT 
  employee_id
  ,last_name
  ,salary
  ,ROUND ( salary * 1.155, 0 ) "New Salary"
  ,ROUND ( (salary * 1.155), 0 ) - salary "Increase"
FROM employees;
--saved as lab_03_04.sql

--5)
SELECT 
  INITCAP(first_name) "Name"
  ,LENGTH(last_name) "Length"
FROM employees
WHERE first_name LIKE 'J%'
  OR first_name LIKE 'A%'
  OR first_name LIKE 'M%';

SELECT 
  INITCAP(first_name) "Name"
  ,LENGTH(last_name) "Length"
FROM employees
WHERE first_name LIKE '&var_letter%'
ORDER BY last_name;

SELECT 
  INITCAP(first_name) "Name"
  ,LENGTH(last_name) "Length"
FROM employees
WHERE first_name LIKE UPPER('&var_letter%')
ORDER BY last_name;

--6)
SELECT
  last_name
  ,ROUND ( MONTHS_BETWEEN( SYSDATE , hire_date )) MONTHS_WORKED
FROM employees


--7)
SELECT
  last_name
  ,LPAD(salary,15,'$') SALARY 
FROM employees;

--8)
SELECT 
  RPAD(last_name, 8 ) 
  || q'< >'
  || RPAD(' ', salary/1000+1,'*') EMPLOYEE_AND_THEIR_SALARIES
FROM employees
ORDER BY salary DESC;

--9)
SELECT 
  last_name 
  ,TRUNC((SYSDATE - hire_date) / 7 ) AS TENURE
FROM employees
WHERE department_id = 90
ORDER BY TENURE DESC;
/*#################################################################################################################                                                           
*                                                      End of practice 3        
*################################################################################################################*/


/*#################################################################################################################
*                                                            4
*                                  Using Conversion Functions and Conditional Expressions
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)
SELECT 
  last_name
  || q'< earns >'
  || TO_CHAR ( salary, 'fm$99,999.00' )
  || q'< monthly but wants >'
  || TO_CHAR ( salary * 3, 'fm$99,999.00' ) "Dream Salaries"
FROM employees;

--2)
SELECT
  last_name
  ,hire_date
  , TO_CHAR ( NEXT_DAY ( ADD_MONTHS ( hire_date, 6), 'MONDAY' ), 'fmDay, "the" Ddspth "of" Month, YYYY') REVIEW
FROM employees;

--3)
SELECT
  last_name
  ,hire_date
  ,TO_CHAR (hire_date, 'DAY') DAY
FROM employees
ORDER BY TO_CHAR (hire_date, 'd');

--4)
SELECT
  last_name
  ,CASE 
    WHEN commission_pct IS NULL  
      THEN 'No Commission'
    ELSE TO_CHAR (commission_pct)
  END COMM 
FROM employees;

--5)
SELECT
  job_id
  , DECODE 
      (job_id, 
        'AD_PRES','A',
        'ST_MAN','B',
        'IT_PROG','C',
        'SA_REP','D',
        'ST_CLERK','E'
        ,0) GRADE
FROM jobs;

--6)
SELECT
  job_id
  , CASE 
       job_id WHEN 'AD_PRES' THEN 'A'--,
              WHEN 'ST_MAN' THEN 'B'
              WHEN 'IT_PROG' THEN 'C'
              WHEN 'SA_REP' THEN 'D'
              WHEN 'ST_CLERK' THEN 'E'
      ELSE TO_CHAR(0) 
    END GRADE
FROM jobs;

/*#################################################################################################################                                                           
*                                                      End of practice 4        
*################################################################################################################*/


/*#################################################################################################################
*                                                            5
*                                  Reporting Aggregated Data Using the Group Functions
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)True
--2)False
--3)True

--4)
SELECT 
  ROUND ( MAX(salary) ) "Maximum"
  ,ROUND ( MIN(salary) ) "Minimum"
  ,ROUND ( SUM(salary) ) "Sum"
  ,ROUND ( AVG(salary) ) "Average"
FROM employees;
-- saved as lab_05_04.sql

--5)
SELECT 
  ROUND ( MAX(salary) ) "Maximum"
  ,ROUND ( MIN(salary) ) "Minimum"
  ,ROUND ( SUM(salary) ) "Sum"
  ,ROUND ( AVG(salary) ) "Average"
FROM employees
GROUP BY job_id;
-- saved as lab_05_05.sql

--6)
SELECT 
  job_id
  ,COUNT(*)
FROM employees
GROUP BY job_id;

SELECT 
  job_id
  ,COUNT(*)
FROM employees
WHERE job_id = '&var_job_id'
GROUP BY job_id;
-- saved as lab_05_06.sql

--7)
SELECT 
  COUNT(DISTINCT (manager_id)) "Number of Managers"
FROM employees;

--8)
SELECT 
  MAX(salary)-MIN(salary) DIFFERECE
FROM employees;


--9)
SELECT 
  manager_id
  ,MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000
ORDER BY 2 DESC;

--10)
SELECT
  (SELECT COUNT(*) FROM employees) TOTAL
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%01' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2001"
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%02' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2002"
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%03' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2003"
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%04' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2004"
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%05' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2005"
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%06' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2006"
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%07' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2007"
  ,(SELECT COUNT(*) FROM employees WHERE hire_date LIKE '%08' GROUP BY TO_CHAR ( hire_date, 'YYYY') ) "2008"
FROM dual;


--11)
SELECT
  job_id "Job"
  ,SUM (DECODE (department_id, 20, salary )) "Dept 20"
  ,SUM (DECODE (department_id, 50, salary )) "Dept 50"
  ,SUM (DECODE (department_id, 80, salary )) "Dept 80"
  ,SUM (DECODE (department_id, 90, salary )) "Dept 90"
FROM employees
GROUP BY job_id;



/*#################################################################################################################                                                           
*                                                      End of practice 5        
*################################################################################################################*/


/*#################################################################################################################
*                                                            6
*                                      Displaying Data from Multiple Tables Using Joins
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)
SELECT
  l.location_id
  ,l.street_address
  ,l.city
  ,l.state_province
  ,c.country_name
FROM locations l NATURAL JOIN countries c;

--2)
SELECT
  last_name
  ,department_id
  ,department_name
FROM employees JOIN departments
USING (department_id);

--3)
SELECT
  e.last_name
  ,e.job_id
  ,e.department_id
  ,d.department_name
FROM employees e LEFT JOIN departments d
ON (e.department_id = d.department_id)
LEFT JOIN locations l
ON (d.location_id = l.location_id)
WHERE l.location_name = 'Toronto';

--4)
SELECT
  e.last_name "Employee"
  ,e.employee_id "EMP#"
  ,m.last_name "Manager"
  ,m.employee_id "MGR#"
FROM employees e JOIN employees m
ON (e.manager_id = m.employee_id);
--saved as lab_06_04.sql

--5)
SELECT
  e.last_name "Employee"
  ,e.employee_id "EMP#"
  ,m.last_name "Manager"
  ,m.employee_id "MGR#"
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id)
ORDER BY 2;
--saved as lab_06_05.sql

--6)
SELECT
  e.department_id DEPARTMENT
  ,e.last_name EMPLOYEE
  ,c.last_name COLLEAGUE
FROM employees e JOIN employees c
ON (e.department_id = c.department_id)
WHERE e.employee_id != c.employee_id
ORDER BY e.department_id, e.last_name, c.last_name;
--saved as lab_06_06.sql

--7)
DESC job_grades;

SELECT
  e.last_name
  ,e.job_id
  ,d.department_name
  ,e.salary
  ,j.grade_level
FROM employees e LEFT JOIN departments d
ON (e.department_id = d.department_id)
LEFT JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

--8)
SELECT
  e1.last_name
  ,e1.hire_date
FROM employees e1 LEFT JOIN employees e2
ON (e2.last_name = 'Davies')
WHERE e2.hire_date < e1.hire_date;

--9)
SELECT
  e.last_name
  ,e.hire_date
  ,m.last_name
  ,m.hire_date
FROM employees e LEFT JOIN employees m
ON (e.manager_id = m.employee_id)
WHERE e.hire_date < m.hire_date;




/*#################################################################################################################                                                           
*                                                      End of practice 6        
*################################################################################################################*/


/*#################################################################################################################
*                                                            7
*                                            Using Subqueries to Solve Queries
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)
UNDEFINE var_last_name;
SELECT 
 last_name
 ,hire_date
FROM employees
WHERE department_id = (
    SELECT 
      department_id 
    FROM employees
    WHERE UPPER(last_name) = UPPER('&&var_last_name') )
AND UPPER(last_name) != UPPER('&var_last_name');

--2)
SELECT 
  employee_id
  ,last_name
  ,salary
FROM employees
WHERE salary > (
    SELECT 
      AVG(salary)
    FROM employees )
ORDER BY salary ASC;

--3)
SELECT
  employee_id
  ,last_name
FROM employees
WHERE department_id IN (
    SELECT 
      department_id
    FROM employees
    WHERE last_name LIKE '%u%');
--saved as lab_07_03.sql

--4)
SELECT
  last_name
  ,department_id
  ,job_id
FROM employees
WHERE department_id IN (
    SELECT
      department_id
    FROM departments
    WHERE location_id = 1700);
--saved as lab_07_04.sql

--5)
SELECT
  last_name
  ,salary
FROM employees
WHERE manager_id IN (
    SELECT
      manager_id
    FROM employees
    WHERE UPPER(last_name) = UPPER('king'));

--6)
SELECT
  department_id
  ,last_name
  ,job_id
FROM employees
WHERE department_id IN (
    SELECT
      department_id
    FROM departments
    WHERE UPPER(department_name) = UPPER('Executive'));

--7)
SELECT
  *
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department_id = 60);

--8)
SELECT
  employee_id
  ,last_name
  ,salary
FROM employees
WHERE department_id IN (
    SELECT 
      department_id
    FROM employees
    WHERE last_name LIKE '%u%')
AND salary > (
    SELECT
      AVG(salary)
    FROM employees);
--saved as lab_07_08.sql


/*#################################################################################################################                                                           
*                                                      End of practice 7        
*################################################################################################################*/


/*#################################################################################################################
*                                                            8
*                                                   Using the Set Operators
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)
SELECT
  department_id
FROM departments
MINUS
SELECT
  department_id
FROM employees
WHERE job_id = 'ST_CLERK';

--2)
SELECT
  country_id
  ,country_name
FROM countries
MINUS
SELECT
  l.country_id
  ,c.country_name
FROM locations l LEFT JOIN countries c 
ON (l.country_id = c.country_id)
LEFT JOIN departments d
ON (d.location_id = l.location_id);

--3)
SELECT
  DISTINCT job_id
  ,department_id
FROM employees
WHERE department_id = 10
UNION ALL
SELECT
  DISTINCT job_id
  ,department_id
FROM employees
WHERE department_id = 50
UNION ALL
SELECT
  DISTINCT job_id
  ,department_id
FROM employees
WHERE department_id = 20;

--4)
SELECT
  employee_id
  , job_id
FROM employees
INTERSECT
SELECT
  employee_id
  ,job_id
FROM job_history;

--5)
SELECT
  last_name
  ,department_id
  ,TO_CHAR(null)
FROM employees
UNION
SELECT
  TO_CHAR(null)
  ,department_id
  ,department_name
FROM departments;





/*#################################################################################################################                                                           
*                                                      End of practice 8        
*################################################################################################################*/


/*#################################################################################################################
*                                                            9
*                                                     Manipulating Data
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--

--1)


/*#################################################################################################################                                                           
*                                                      End of practice 9        
*################################################################################################################*/


/*#################################################################################################################
*                                                            10
*                                      Using DDL Statements to Create and Manage Tables
*                                                         Practice     
*################################################################################################################*/

--########################################              Part 1            #######################################--


--1)
CREATE TABLE dept(
  id NUMBER(7) CONSTRAINT dept_id_pk PRIMARY KEY (id),
  name VARCHAR2(25)
);

DESC dept;


--2)
INSERT INTO dept (id, name)
  SELECT 
    department_id
    ,department_name
  FROM departments;

--3)
CREATE TABLE emp(
  id NUMBER(7),
  last_name VARCHAR2(25 BYTE),
  first_name VARCHAR2(25 BYTE),
  dept_id NUMBER (7)
  CONSTRAINT emp_dept_id_fk FOREIGN KEY (dept_id)
  REFERENCES dept(id)
);

DESC emp;

--4)
CREATE TABLE employees2(
  id NUMBER(6,0),
  first_name VARCHAR2(20 BYTE),
  last_name VARCHAR2(25 BYTE) CONSTRAINT emp2_last_name_nn NOT NULL ENABLE, 
  salary NUMBER (8,2),
  dept_id NUMBER(4,0),
  CONSTRAINT emp2_id_pk PRIMARY KEY (id),
  CONSTRAINT emp2_salary_min CHECK (salary > 0) ENABLE,
  CONSTRAINT emp2_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept (id) ENABLE
);

COMMENT ON COLUMN employees2.id is 'Primary key of employees2 table.';
COMMENT ON COLUMN employees2.first_name is 'First name of the employee.';
COMMENT ON COLUMN employees2.last_name is 'Last name of the employee. A not null column.';
COMMENT ON COLUMN employees2.salary is 'Monthly salary of the employee. Must be greater than zero (enforced by constraint emp2_salary_min)';
COMMENT ON COLUMN employees2.department_id is 'Department id where employee works; foreign key to id column of the dept table';
--saved as lab_10_03.sql

--5)
ALTER TABLE employees2 READ ONLY;

--6)
INSERT INTO employees2 
VALUES (34,'Grant','Marcie',5678,10);
/*Error starting at line 24 in command:
INSERT INTO employees2 
VALUES (34,'Grant','Marcie',5678,10)
Error at Command Line:24 Column:12
Error report:
SQL Error: ORA-12081: update operation not allowed on table "FORT"."EMPLOYEES2"
12081. 00000 -  "update operation not allowed on table \"%s\".\"%s\""
*Cause:    An attempt was made to update a read-only materialized view.
*Action:   No action required. Only Oracle is allowed to update a
           read-only materialized view.*/

--7)
ALTER TABLE employees2 READ WRITE;
INSERT INTO employees2 
VALUES (34,'Grant','Marcie',5678,10);

--8)
DROP TABLE employees2;
/*#################################################################################################################                                                           
*                                                      End of practice 10        
*################################################################################################################*/
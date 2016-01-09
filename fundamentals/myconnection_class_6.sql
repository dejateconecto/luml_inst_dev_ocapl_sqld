/*#################################################################################################################
* 
*                                                 Class 6  Dec 5th, 2015
*                                                                    
*################################################################################################################*/

SELECT 
  e.last_name
  ,e.hire_date
  ,d.department_name
FROM 
hr.employees e LEFT JOIN hr.departments d
ON e.department_id = d.department_id
WHERE 
  d.department_id IN (
    SELECT 
      f.department_id
    FROM hr.employees c LEFT JOIN hr.departments f
    ON c.department_id = f.department_id
    WHERE UPPER (c.last_name) = UPPER('&&l_n')
  )
  AND UPPER(e.last_name) != UPPER('&l_n')
ORDER BY 1;


SELECT 
  e.employee_id
  ,e.last_name
  ,e.salary
FROM hr.employees e
WHERE e.salary > (SELECT 
                    AVG(d.salary)
                  FROM hr.employees d)
ORDER BY 3;

SELECT 
  e.last_name
  ,e.department_id
  ,e.job_id
FROM hr.employees e
WHERE e.department_id IN (
      SELECT 
        d.department_id
      FROM hr.departments d
      WHERE d.location_id = 1700
);

SELECT last_name, salary
FROM employees WHERE manager_id IN (SELECT employee_id FROM employees WHERE last_name = 'King' AND manager_id IS NULL);

-- DML Data Manipulation Language
-- DDL Data Definition Language
-- DCL Data Control Language


INSERT INTO employees (employee_id, first_name, last_name,email,hire_date,job_id)
VALUES ('207','Joan','Sebastian','jsabastian@develop.com.mx',sysdate,'IT_PROG');
INSERT INTO employees (employee_id, first_name, last_name,email,hire_date,job_id)
VALUES ('208','Juan','Gabriel','jgabriel@develop.com.mx',sysdate,'IT_PROG');
INSERT INTO employees (employee_id, first_name, last_name,email,hire_date,job_id)
VALUES ('209','Vicente','Fernandez','vfernandez@develop.com.mx',sysdate,'IT_PROG');
INSERT INTO employees (employee_id, first_name, last_name,email,hire_date,job_id)
VALUES ('210','Agustin','Lara','alara@develop.com.mx',sysdate,'IT_PROG');
INSERT INTO employees (employee_id, first_name, last_name,email,hire_date,job_id)
VALUES ('211','Pedro','Infante','pinfante@develop.com.mx',sysdate,'IT_PROG');


SELECT * FROM employees; WHERE hire_date >TRUNC(sysdate)-1;

UPDATE employees SET department_id = 110
WHERE hire_date >TRUNC(sysdate);


UPDATE employees SET (phone_number,salary,commission_pct,department_id,manager_id) = (SELECT 
                                                                                          phone_number
                                                                                          ,salary
                                                                                          ,commission_pct
                                                                                          ,department_id
                                                                                          ,manager_id
                                                                                      FROM employees
                                                                                      WHERE employee_id = 146)
WHERE hire_date >TRUNC(sysdate)-2;


ALTER TABLE HR.JOB_HISTORY ENABLE CONSTRAINT JHIST_EMP_ID_ST_DATE_PK;

update employees SET HIRE_DATE = TRUNC(sysdate) -1 
WHERE hire_date >TRUNC(sysdate);



SELECT 
                                                                                          phone_number
                                                                                          ,salary
                                                                                          ,commission_pct
                                                                                          ,manager_id
                                                                                          department_id
                                                                                      FROM employees
                                                                                      WHERE employee_id = 146;
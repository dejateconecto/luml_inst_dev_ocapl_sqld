SELECT sysdate FROM dual;
SELECT * FROM all_tables;
SELECT * FROM all_tab_columns;
SELECT * FROM sys.all_objects;
SELECT DISTINCT(owner) FROM all_tables;
SELECT DISTINCT(object_type) FROM sys.all_objects;

SELECT DISTINCT hire_date FROM employees;
--SELECT DISTINCT (*) FROM employees;
SELECT DISTINCT * FROM employees;
SELECT hire_date, hire_date FROM employees;
DESCRIBE employees;
--or
DESC employees;

--#### Operaciones con NULL devuelve NULL
SELECT 3 + NULL FROM dual;
SELECT 3 - NULL FROM dual;
SELECT 3 * NULL FROM dual;
SELECT 3 / NULL FROM dual;
--#### Operaciones aritmetcias OK
SELECT 3 + 3 FROM dual;
SELECT 3 - 3 FROM dual;
SELECT 3 * 3 FROM dual;
SELECT 3 / 3 FROM dual;

SELECT last_name
  ,salary
  ,(salary + 300) / 5
  ,salary + 300 / 5
  FROM employees;
  
SELECT 'Hola mundo' FROM dual;
SELECT 'Hola mundo' FROM employees;
SELECT 'Hola '||first_name FROM employees;
SELECT 'Hola '||null FROM employees; -- Como en JAVA


SELECT q'[Cáracteres especi@les]' FROM dual;

SELECT * FROM EMPLOYEES;
SELECT department_name || q'[ Department's Manager Id: ]' 
  || manager_id 
  AS "Deparment and Manager"
FROM departments;

SELECT Q'[Hola mi nombre es ]' 
  || first_name 
  || Q'[ y mi salario es $]' 
  || salary
  || Q'[ pesos y espero ganar el ]' 
  || commission_pct*100
  || Q'[% más, es decir $]' 
  || (commission_pct*salary + salary)
  || Q'[ pesos.]' -- Functional (),[] or <> 
  AS "Sentencia 1"
  FROM employees
WHERE commission_pct IS NOT NULL;

SELECT HOST FROM dual;



SELECT first_name + last_name FROM employees;


---## WHERE clause
SELECT * FROM employees
WHERE department_id = 90;

SELECT * FROM employees
WHERE department_id = '90';  --Oracle implicit convertion, from string to number

SELECT last_name, job_id, department_id FROM employees
WHERE last_name = 'Whalen';

SELECT last_name FROM employees
WHERE hire_date = '17-SEP-03';

--## Comparison Operators  =, >, >=, <, <=, <>, BETWEEN...AND.., IN(set), LIKE and IS NULL.
SELECT * FROM employees
WHERE employee_id = 102;

SELECT * FROM employees
WHERE salary > 20000;

SELECT * FROM employees
WHERE commission_pct >= .4;

SELECT * FROM employees
WHERE department_id < 20;

SELECT * FROM employees
WHERE department_id <= 30;

SELECT * FROM employees
WHERE manager_id <> 100;

SELECT * FROM employees
WHERE hire_date --='01-ENE-02';
BETWEEN '01-ENE-02'
AND '31-DEC-04';

SELECT * FROM employees
WHERE manager_id IN (100,104,122,144);

SELECT * FROM employees
WHERE last_name LIKE '%all%';

SELECT * FROM employees
WHERE department_id IS NULL;


--## Wildcard-comodin _
SELECT * FROM employees
WHERE last_name LIKE '%o_';



SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'SA_REP'
OR job_id = 'AD_PRES'
AND salary > 15000;

SELECT last_name, job_id, salary
FROM employees
WHERE (job_id = 'SA_REP'
OR job_id = 'AD_PRES')
AND salary > 15000;


--### ORDER BY

SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'SA_REP'
OR job_id = 'AD_PRES'
AND salary > 15000
ORDER BY salary DESC;-- ASC is default ordering value but can be wrote explicity


--##SINGLE-AMPERSAND 

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_num;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_num
AND manager_id <> &&manager_num;

SELECT &asas FROM employees;

--## DEFINE crea una variable en memoria 
DEFINE employee_num = 200

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_num;

UNDEFINE employee_num;



---## VERIFY
SET VERIFY ON
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_num;


DEFINE salary_num = 20000
SELECT Q'[Hola mi nombre es ]' 
  || first_name 
  || Q'[ y mi salario es $]' 
  || salary
  || Q'[ pesos y espero ganar el ]' 
  || commission_pct*100
  || Q'[% más, es decir $]' 
  || (commission_pct*salary + salary)
  || Q'[ pesos.]' -- Functional (),[] or <> 
  AS "Sentencia 1"
  FROM employees
WHERE commission_pct IS NOT NULL
AND salary <=&salary_num
AND hire_date BETWEEN '01-ENE-97'
AND '31-DEC-15'
AND manager_id NOT IN (100,102)
AND (job_id = 'SA_REP' OR job_id = 'AD_PRES');
UNDEFINE salary_num;

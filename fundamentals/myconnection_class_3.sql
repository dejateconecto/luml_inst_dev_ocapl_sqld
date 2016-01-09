/*#################################################################################################################
* 
*                                                 Class 3  Nov 14th, 2015
*                              
*################################################################################################################*/
SELECT DISTINCT (commission_pct) FROM employees;--commission_pct
SELECT commission_pct, COUNT (commission_pct) FROM employees GROUP BY commission_pct;--commission_pct

--Funciones GROUP, devuelven un solo resultado por un conjunto de datos
SELECT AVG(salary) --AVERAGE 
      ,MAX(salary) --MAXIMUN
      ,MIN(salary) --MINIMUM
      ,SUM(salary) --SUM
FROM
  employees
WHERE job_id LIKE '%REP%';

SELECT MIN(hire_date) --MAXIMUN
      ,MAX(hire_date) --MINIMUM
FROM
  employees;

--Busqueda del "menor" (representado por el orden ascendete alfabeticamente) nombre y mayor nombre (representado por el orden descendete alfabeticamente)
SELECT MIN(first_name)
      ,MAX(first_name)
FROM 
  employees;
  
--Cuenta el número de registros "commission_pct" del departamento 80 *No discrimina repetidos ni nulos
SELECT COUNT(commission_pct)
FROM  employees
WHERE department_id = 80;

--Cuenta el número de registros "commission_pct" del departamento 80 discriminando repetidos
SELECT COUNT(DISTINCT (commission_pct))
FROM  employees
WHERE department_id = 80;

--Promedio sin considerar nulos
SELECT AVG(commission_pct)
FROM employees;

--Promedio, obligando a tomar en cuenta los valores nulos ( aunque en este caso, al asignar a un nulo un valor de 0, no se afecta el resultado)
SELECT AVG(NVL(commission_pct,0))
FROM employees;

--Retorna el promedio de los salarios, agrupados por departamento
SELECT department_id
      ,AVG(salary)
FROM employees
GROUP BY department_id;


--Mostrar salario minimo por departamento
SELECT department_id
      ,MIN(salary)
FROM employees
--WHERE deparment_id 
GROUP BY department_id
ORDER BY 2;

--Mostrar salario minimo por departamento
SELECT AVG(salary)
FROM employees
--WHERE deparment_id 
GROUP BY department_id
ORDER BY 1;


SELECT * FROM all_directories;
--CREATE DIRECTORY dump_dir AS 'oracle/dump_dir';  -- "insufficient privileges" cha!   :'( 

--Suma el salario total agrupando por puesto y por departamento
SELECT department_id
      ,job_id
      ,SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY job_id;

--Uso de la clausula "HAVING" para realizar restricciones a grupos
SELECT department_id
      ,AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 8000
ORDER BY 2;

--Indica el departamento, puesto y cuenta empleados por puesto y departamento, solo empleados que tengan comisión donde el númedo de empleados sea mayor que 5
SELECT department_id
      ,job_id
      ,COUNT (employee_id)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id, job_id
HAVING COUNT (employee_id) > 5;

--Round 1 :D  

--Indica el departamento, puesto y cuenta empleados por puesto y departamento, solo empleados que tengan comisión donde el númedo de empleados sea mayor que 5
--fecha de contratación mayor que 2004 y menor 2008, salario min mayor a 10000 y saber si el promedio de ellos multiplicado 30% se encuentra entre 15000 y 16000 
--1,000,000.00
SELECT department_id
      ,job_id
      --,COUNT (employee_id) AS NUM_OF_EMP
      ,CASE 
        WHEN AVG(salary*.3) > 15000 AND (AVG(salary*.3)) < 16000 THEN 'En rango:' || ' ' || TO_CHAR( AVG(salary)*.3 , '$999,999.00')
        WHEN AVG(salary*.3) < 15000 THEN 'Abajo de rango:' || ' ' || TO_CHAR( AVG(salary*.3) , '$999,999.00')
        WHEN AVG(salary*.3) > 16000 THEN 'Arriba de rango:' || ' ' || TO_CHAR( AVG(salary*.3) , '$999,999.00')
        ELSE 'Fuera de rango'
      END AS "AVG_DESC"
FROM employees
WHERE commission_pct IS NOT NULL
AND hire_date BETWEEN '01-ENE-04'
AND '31-DEC-08'
GROUP BY department_id, job_id
HAVING --COUNT (employee_id) > 5
       --AND 
       MIN(salary) > 10000;
       
--Round 2 :D            .... ok:
--Indica el departamento, puesto y cuenta empleados por puesto y departamento, solo empleados que tengan comisión donde el númedo de empleados sea mayor que 5
--fecha de contratación mayor que 2004 y menor 2008, salario min mayor a 10000 y saber si el promedio de ellos multiplicado 30% se encuentra entre 15000 y 16000 
--1,000,000.00
SELECT department_id
      ,job_id
      ,COUNT (employee_id) AS NUM_OF_EMP
      ,'En rango:' || ' ' || TO_CHAR( ROUND ( AVG(salary*1.3) , 2) , '$999,999.00') AS "AVG_DESC"
FROM employees
WHERE commission_pct IS NOT NULL
AND hire_date BETWEEN '01-ENE-05'   -- Between es "Inclusivo"
AND '31-DEC-07'
GROUP BY department_id, job_id
HAVING MIN(salary) > 10000
       AND ROUND ( AVG(salary*1.3) , 2 ) BETWEEN 15001 AND 15999;
       
       
--Quienes son? R:146,147,140
SELECT department_id
      ,job_id
      ,first_name || ' ' || last_name
      ,employee_id
      --,'En rango:' || ' ' || TO_CHAR( ROUND ( AVG(salary*1.3) , 2) , '$999,999.00') AS "AVG_DESC"
FROM employees
WHERE commission_pct IS NOT NULL
AND hire_date BETWEEN '01-ENE-05'   -- Between es "Inclusivo"
AND '31-DEC-07'
AND job_id = 'SA_MAN';
--GROUP BY department_id, job_id;
       
       
SELECT * FROM employees WHERE job_id = 'SA_REP' AND department_id = 80;


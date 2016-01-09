/*#################################################################################################################
* 
*                                                 Class 5  Nov 28th, 2015
*                                                                    
*################################################################################################################*/

SELECT 
  last_name
  ,salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Abel');
              
              
SELECT 
  last_name
  ,job_id
  ,salary
FROM employees
WHERE job_id =(
                SELECT job_id
                FROM employees
                WHERE last_name = 'McCain')
AND   salary = (SELECT salary
                FROM employees
                WHERE last_name = 'McCain');
                
                
--review this query              
SELECT * FROM departments d 
WHERE EXISTS
(SELECT 1 FROM employees e
WHERE e.department_id = d.department_id);

--Operaciones con conjuntos
SELECT 
  employee_id empleado
  ,salary
  ,job_id
FROM employees
UNION--UNION ALL -- 117     --UNION --115
SELECT 
  employee_id
  ,1
  ,job_id
FROM job_history;


--Operaciones con conjuntos
SELECT 
  employee_id 
  ,job_id
FROM employees
INTERSECT
SELECT 
  employee_id
  ,job_id
FROM job_history;



--Operaciones con conjuntos
SELECT 
  employee_id 
FROM employees
MINUS
SELECT 
  employee_id
FROM job_history;

SELECT
  location_id
  ,department_name "Department"
  ,TO_CHAR(NULL) "Warehouse location"
FROM departments
UNION
SELECT 
  location_id
  ,TO_CHAR(NULL) "Department"
  ,state_province
FROM locations;


SELECT 
  oec.cust_last_name
  ,oec.cust_geo_location
FROM oe.customers oec
WHERE oec.credit_limit IN (1000,2000,3000);

SELECT 
  oec.cust_last_name
  ,oec.cust_geo_location
FROM oe.customers oec
WHERE oec.credit_limit = 1000
      OR oec.credit_limit = 2000
      OR oec.credit_limit =3000;
      
      SELECT oec.* FROM oe.customers oec
      LEFT JOIN hr.employees hre
      ON oec.customer_id = hre.employee_id
      LEFT JOIN (
      SELECT LAST_NAME FROM EMPLOYEES
      WHERE last_name = 'Taylor'
      ) aux
      ON AUX.LAST_NAME = hre.last_name;


                
              
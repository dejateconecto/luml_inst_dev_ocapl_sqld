/*#################################################################################################################
* 
*                                                 Class 4  Nov 21st, 2015
*                                                       J O I N S             
*################################################################################################################*/

--GRANT|REVOKE SELECT|DELETE|INSERT|UPDATE ON table_name|all TO scheme;
GRANT UPDATE ON emp_details_view TO hr;
SELECT 
  department_id
  ,department_name
  ,location_id,
  city
FROM departments
NATURAL JOIN locations;

SELECT * FROM departments;
SELECT * FROM locations;


SELECT 
   e.employee_id
  ,e.last_name
  ,d.location_id
  ,department_id--,d.department_id  -- así truena
FROM employees e JOIN departments d
USING (department_id);

SELECT * FROM employees;
--UPDATE employees SET first_name = 'Steven' WHERE employee_id = 128 AND first_name = 'Steve';
--UPDATE test_emp_details_view SET first_name = 'Steven' WHERE employee_id = 128 AND first_name = 'Steve';
--DROP VIEW test_emp_details_view;


SELECT 
  worker.last_name emp
  ,manager.last_name mgr
FROM
  employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

---???????
SELECT 
  COUNT (emp)
  ,mgr
FROM
    (SELECT 
       worker.last_name emp
      ,manager.last_name mgr
    FROM
      employees worker JOIN employees manager
    ON (worker.manager_id = manager.employee_id))
GROUP BY mgr;

SELECT 
  COUNT (worker.last_name) emp
  ,manager.last_name mgr
FROM
  employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id)
GROUP BY manager.last_name;

SELECT 
  e.last_name
  ,e.salary
  ,j.grade_level
FROM employees JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND highest_sal);

--###################################################################################
/** LEFT trae todos los registros de al TABLA IZQUIERDA (employees), si no hace match con la tabla derecha (deparments)
devuelve NULL (por ejemplo el empleado Grant, no tiene departamento asignado, por lo tanto trae NULL tanto en deparment_id como 
en deparment_name)*/
SELECT
  e.last_name
  ,e.department_id
  ,d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);
--###################################################################################


--###################################################################################
/** RIGHT trae todos los registros de al TABLA DERECHA (departments), si no hace match con la tabla izquierda (employees)
devuelve NULL (por ejemplo el departamento Benefits, no empleados, por lo tanto devuelve NULL en el campo last_name )*/
SELECT
  e.last_name
  ,e.department_id
  ,d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);
--###################################################################################


--###################################################################################
/** FULL trae todos los registros de ls TABLA DERECHA o IZQUIERDA, si no hace match con la tabla opuesta
devuelve NULL*/
SELECT
  e.last_name
  ,e.department_id
  ,d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);
--###################################################################################


--###################################################################################
/** Syntaxis de ORACLE equivalente a LEFT*/
SELECT
  e.last_name
  ,e.department_id
  ,d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);
--###################################################################################


--###################################################################################
/** Syntaxis de ORACLE equivalente a RIGHT*/
SELECT
  e.last_name
  ,e.department_id
  ,d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;
--###################################################################################

/*#################################################################################################################
*                                    Parametros de i nstalación de esquemas          
*################################################################################################################*/
  /*--Ejecutar programa: oe_main.sql
  --@path_to_oe_schema/oe_main.sql
  params:
    1:oe
    2:users
    3:temp
    4:hr
    5:sys
    6:oraclehome/...
    7:oraclehome/...rdbms/log
    8:v3

  paths: C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\log*/
  
  
  
--SELECT * FROM all_tables WHERE owner = 'OE';
--DESC all_tables;

--##########################################################
/** Joins con la tabla orders del esquema OE*/
SELECT 
  hre.employee_id
  ,hre.last_name
  ,oeo.sales_rep_id
  ,oeo.order_id
  ,oeo.order_status
FROM hr.employees hre 
JOIN oe.orders oeo
ON (hre.employee_id = oeo.sales_rep_id);


NATURAL JOIN 
(LEFT OUTER JOIN ,
RIGHT OUTER JOIN ,
FULL OUTER JOIN ) --equijoins, simple joins
CROSS JOIN --producto cartesiano 
SELF JOIN  -- referencia a la misma tabla p.ej Manager y Emplyee se encuentran en la misma tabla



/*#################################################################################################################
* 
*                                                 Class 2  Nov 7th, 2015
*
*################################################################################################################*/
--Ejercicios clase 2
--Ejercicio final clase 2
SELECT LOWER ('CADA OSO CON SU MAMA') "fuction(LOW)"
  , UPPER ('CADA OSO CON SU MAMA') "fuction(UP)"
  , INITCAP ('CADA OSO CON SU MAMA') "fuction(INI)"
  FROM dual;

SELECT LOWER (first_name) FROM employees; 
SELECT UPPER (first_name) FROM employees; 
SELECT INITCAP (first_name) FROM employees; 

SELECT INITCAP (first_name) 
  || ' '
  || INITCAP (last_name)
  "Char functions :P"
FROM employees;
SELECT LOWER (first_name) 
  || ' '
  || LOWER (last_name)
  "Char functions :P"
FROM employees;
SELECT UPPER (first_name) 
  || ' '
  || UPPER (last_name)
  "Char functions :P"
FROM employees;

SELECT CONCAT('Luis','ito') FROM dual;
SELECT SUBSTR('ALTER SESSION SET',7,7) FROM dual; -- this function starts from 1
SELECT LENGTH('ALTER SESSION SET') FROM dual;
SELECT LENGTH(1234543) FROM dual;
SELECT INSTR('ALTER SESSION SET','TER') FROM dual;
  SELECT INSTR('ALTER SESSION SET','S',1) FROM dual;-- Retorna la posición de la 1 aparición de 'S'
    SELECT INSTR('ALTER SESSION SET','S',8,1) FROM dual;--Revisar
SELECT REPLACE('ALTER SESSION SET','S','X') FROM dual;
SELECT TRIM('S' FROM 'ALTER SESSION SET') FROM dual;

SELECT employee_id, CONCAT (first_name,last_name) NAME
  ,job_id
  ,LENGTH(last_name)
  ,INSTR(last_name,'a') "Contiene 'a'?"
FROM employees
WHERE SUBSTR (job_id , 4) = 'REP';

SELECT employee_id, CONCAT (first_name,last_name) NAME
  ,job_id
  ,LENGTH(last_name)
  ,INSTR(last_name,'a') "Contiene 'a'?"
FROM employees
WHERE SUBSTR (job_id , -2) = 'EP';


SELECT ROUND(45.932,2)
  ,ROUND(45.932,0)
  ,ROUND(45.932,-1)
  ,ROUND(45.932,-2)
FROM dual;


SELECT TRUNC(ROUND(156.00,-1),-1) FROM dual;
SELECT ROUND(156.00,-1) FROM dual;
SELECT TRUNC(173,-1) FROM dual;  -- actua sobre la "UNIDAD" y la baja a cero


SELECT last_name, salary, MOD(salary,5000), MOD(NULL,5000), MOD(salary,NULL)
  FROM employees
WHERE job_id = 'SA_REP';


SELECT MONTHS_BETWEEN (TO_DATE('11-30-1989','MM-DD-YYYY'),sysdate) FROM dual;

/*Aumentar el salario en un 30 porciento de los empleados del departamento 80 que tengan mas de un año de antiguedad. Proyectar
Nombre y apellido juntos, meses transcurridos como meses, salario y salario aumentado como aumento*/
SELECT CONCAT (first_name, last_name), TRUNC ( MONTHS_BETWEEN (SYSDATE ,hire_date) ) meses, TO_CHAR ( salary , '$999,999.00'),
  TO_CHAR (
    CASE WHEN MONTHS_BETWEEN (SYSDATE ,hire_date) > 12
        THEN salary*0.3 + salary
        ELSE salary
    END, '$999,999.00')  AS "aumentado (con CASE)"--,
  --DECODE (1,2,3)  --wtf!!!!!!
FROM employees
WHERE
  department_id = 80;
  
  

SELECT NEXT_DAY(SYSDATE,'VIERNES') FROM dual;-- Devuelme la fecha en que caerá el que se pide como pametro, partiendo de la fecha dada
SELECT LAST_DAY(SYSDATE) FROM dual; --Devuelme mi cumpleaños :) :D ... devuelve el ultimo día del mes de la fecha que se pasa como parametro


SELECT employee_id, TO_CHAR(hire_date, 'MM/YY'), TO_CHAR(hire_date, 'DD/MM/YY HH24:MM:SS') AS TIEMPO FROM employees;
--SOME MASKS: YYYY | YEAR | MM | MONTH | MON | DY | 







SELECT TO_CHAR(
    ROUND(
      (salary/7),2
    ),'99G999D99', 'NLS_NUMERIC_CHARACTERS = '',.'''
  )  "Formatted Salary"
FROM employees;

SELECT TO_CHAR(
    ROUND(
      (salary/7),2
    ),'99G999D99', 'NLS_NUMERIC_CHARACTERS = '',.'''
  )  "Formatted Salary",
    ROUND(
      (salary/7),2
    ) "Unformatted Salary"
FROM employees;



SELECT employee_id
  ,commission_pct
  ,NVL(commission_pct,0)
  ,hire_date
  ,NVL(hire_date,'01-ENE-99')
  ,job_id
  ,NVL(job_id,'No job yet')
FROM employees;

SELECT last_name, salary, NVL(commission_pct,0),
  (salary*12) + (salary*12+NVL(commission_pct,0)) AN_SALARY
FROM employees
ORDER BY commission_pct NULLS LAST;


SELECT last_name, salary, commission_pct,
  NVL2(commission_pct,'SAL+COM','SAL') income
FROM employees
ORDER BY commission_pct NULLS FIRST;


SELECT first_name,  
  LENGTH(first_name) "expr1",
  LENGTH(last_name) "expr2",
  NULLIF(LENGTH(first_name), LENGTH(last_name))  RESULT--- WTF ??? Don't understand ¿SELECT?
FROM employees;


SELECT last_name, employee_id,
  COALESCE (TO_CHAR(commission_pct),TO_CHAR(manager_id),'No commission and no manager')
FROM employees;

SELECT last_name, job_id, salary,
    DECODE(
      job_id, 'IT_PROD', 1.10 * salary,
              'ST_CLERK', 1.15 * salary,
              'SA_REP', 1.20 * salary,
      salary
    ) REVISED_SALARY
FROM employees;

 SET serveroutput ON;
EXECUTE secure_dml();

--LPAD(PARAMETRO,LONGITUD,CARACTER)


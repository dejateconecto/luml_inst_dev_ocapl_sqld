/*#################################################################################################################
* 
*                                                 Chapter 3 and 4  Apr 9th, 2016
*
*################################################################################################################*/

SELECT UPPER('hello world!') FROM dual; --result: HELLO WORLD!
SELECT LOWER('HELLO WORLD!') FROM dual; --result: hello world!
SELECT INITCAP('HELLO WORLD!') FROM dual; --result: Hello World!
SELECT UPPER('hello world!')
  , LOWER('HELLO WORLD!')
  , INITCAP('HELLO WORLD!')
  , INITCAP('hello world!') 
FROM dual;

SELECT CONCAT('Luis','Abraham') FROM dual; --result: LuisAbraham, only 2 params are allowed
SELECT SUBSTR('LUIS',2) FROM dual;--result: LUI
SELECT SUBSTR('LUIS',2,2) FROM dual;--result: UI
SELECT LENGTH('1234567890abcdefghijklmnopqrstwxyz') FROM dual;
SELECT INSTR('102|LUIS|ABRAHAM|DE LA LUZ', '|',5,2) FROM dual;
SELECT LPAD('dejateconecto@outlook.com',50,'*') FROM dual;
SELECT RPAD('dejateconecto@outlook.com',50,'*') FROM dual;
SELECT TRIM(CHR(32) FROM 'Hello World !') FROM dual;
SELECT REPLACE('Hello World !', ' ', '_') FROM dual;


SELECT ROUND(45.123,2), ROUND(45.123,0), ROUND(45.123,-1) FROM dual;
SELECT TRUNC(45.123,2), TRUNC(45.123,0), TRUNC(45.123,-1) FROM dual;

SELECT ROUND(45,2), ROUND(45,0), ROUND(45,-1) FROM dual;
SELECT TRUNC(45,2), TRUNC(45,0), TRUNC(45,-1) FROM dual;

SELECT employee_id, TO_CHAR(hire_date,'DD/MON/YYYY') FROM employees;
SELECT employee_id, TO_CHAR(hire_date,'DD/MON/YYYY') FROM employees WHERE hire_date > TO_DATE('21/SEP/05','DD/MON/YY');


SELECT TO_CHAR(hire_date, 'YYYY') YYYY
  , TO_CHAR(hire_date, 'YY') YY
  , TO_CHAR(hire_date, 'YEAR') YEAR
  , TO_CHAR(hire_date, 'RRRR') RRRR
  , TO_CHAR(hire_date, 'RR') RR
  , TO_CHAR(hire_date, 'MM') MM
  , TO_CHAR(hire_date, 'MON') MON
  , TO_CHAR(hire_date, 'MONTH') MONTH
  , TO_CHAR(hire_date, 'DD') DD
  , TO_CHAR(hire_date, 'DY') DY
  , TO_CHAR(hire_date, 'DAY') DAY
  , TO_CHAR(hire_date, 'SCC') SCC
  , TO_CHAR(hire_date, 'CC') CC
  , TO_CHAR(hire_date, 'SYYYY') SYYYY
  , TO_CHAR(hire_date, 'Y,YYY') "Y,YYY"
  , TO_CHAR(hire_date, 'IYYY') IYYY
  , TO_CHAR(hire_date, 'BC') BC
  , TO_CHAR(hire_date, 'AD') AD
  , TO_CHAR(hire_date, 'Q') Q
  , TO_CHAR(hire_date, 'RM') RM
  , TO_CHAR(hire_date, 'WW') W
  , TO_CHAR(hire_date, 'J') J
  , TO_CHAR(hire_date, 'IW') IW
  
FROM employees;


--ALTER SESSION SET NLS_DATE_LANGUAGE  = 'English';
SELECT TO_CHAR(hire_date, 'fmDay", the" ddspth "of" Month "of" year" at" fmHH12:MI:SS AM') "My spelled date"
FROM employees;

SELECT TO_CHAR(hire_date, 'HH') HH 
  ,TO_CHAR(hire_date, 'AM') AM
  ,TO_CHAR(hire_date, 'PM') PM
  ,TO_CHAR(hire_date, 'A.M.') "A.M."
  ,TO_CHAR(hire_date, 'P.M.') "P.M."
  ,TO_CHAR(hire_date, 'HH12') H12
  ,TO_CHAR(hire_date, 'HH24') HH24
  ,TO_CHAR(hire_date, 'HH12') H12
  ,TO_CHAR(hire_date, 'MI') MI
  ,TO_CHAR(hire_date, 'SS') SS
  ,TO_CHAR(hire_date, 'SSSS') SSSS
FROM employees;
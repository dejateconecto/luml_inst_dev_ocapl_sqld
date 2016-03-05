/*#################################################################################################################
* 
*                                                 Class 13  Mar 5th, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON;
/*
DECLARE
  TYPE t_emp IS TABLE OF
  hr.employees%rowtype
  INDEX BY PLS_INTEGER;
  
  emp_tab t_emp;
  
  CURSOR c_data
  IS
  SELECT * 
  FROM
  hr.employees;
  
  v_option NUMBER := 2;
  v_id     NUMBER := 0;
  v_salary NUMBER := 15000;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Program is starting...');
  IF v_option = 2 
    THEN
      DBMS_OUTPUT.PUT_LINE('v_option = 2');
      DBMS_OUTPUT.PUT_LINE('Employees whom earn more than ' || v_salary);
      FOR i IN c_data LOOP
        v_id := v_id + 1;
        --DBMS_OUTPUT.PUT_LINE('v_id: ' || v_id);
        SELECT * 
        INTO emp_tab(v_id)
        FROM hr.employees
        WHERE employee_id = i.employee_id;
        
        
        IF  emp_tab(v_id).salary > v_salary
          THEN
            DBMS_OUTPUT.PUT_LINE(emp_tab(v_id).first_name || ' ' || emp_tab(v_id).last_name);
        END IF;
        --DBMS_OUTPUT.PUT_LINE('Employee ' || v_id || ' is called ' || emp_tab(v_id).first_name || ' ' || emp_tab(v_id).last_name);
      END LOOP;
  END IF;
END;
*/


/*Crece hasta 2 GB de espacio, no acepta negativos y su llave es entera*/
/*DECLARE
  TYPE t_emp IS TABLE OF
  hr.employees%rowtype
  INDEX BY PLS_INTEGER;
  
  emp_tab t_emp;
  
  CURSOR c_data
  IS
  SELECT * 
  FROM
  hr.employees;
  
  v_cursor c_data%ROWTYPE;
  v_option NUMBER := 2;
  v_id     NUMBER := 0;
  v_salary NUMBER := 15000;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Program is starting...');
  DBMS_OUTPUT.PUT_LINE('A t r i b u t t e s');
  
  DBMS_OUTPUT.PUT_LINE('IS OPEN?');
  IF c_data%ISOPEN = TRUE THEN
    DBMS_OUTPUT.PUT_LINE('TRUE');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('FALSE');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('OPENING CURSOR...');
  OPEN c_data;
  
  DBMS_OUTPUT.PUT_LINE('IS OPEN?');
  IF c_data%ISOPEN = TRUE THEN
    DBMS_OUTPUT.PUT_LINE('TRUE');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('FALSE');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('ROWCOUNT OPEN CURSOR NOT FETCHED');
  DBMS_OUTPUT.PUT_LINE(c_data%ROWCOUNT);
  
  DBMS_OUTPUT.PUT_LINE('FOUND ? (WITH OPEN CURSOR NOT FETCHED)');
  IF c_data%FOUND = TRUE THEN
    DBMS_OUTPUT.PUT_LINE('TRUE');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('FALSE');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('OPEN CURSOR');
  
  FETCH c_data INTO v_cursor;
  DBMS_OUTPUT.PUT_LINE('FOUND ? (WITH OPEN CURSOR FETCHED)');
  IF c_data%FOUND = TRUE THEN
    DBMS_OUTPUT.PUT_LINE('TRUE');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('FALSE');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('ROWCOUNT FETCH');
  DBMS_OUTPUT.PUT_LINE(c_data%ROWCOUNT);
  
  DBMS_OUTPUT.PUT_LINE('CLOSING CURSOR...');
  CLOSE c_data;
  DBMS_OUTPUT.PUT_LINE('IS OPEN?');
  IF c_data%ISOPEN = TRUE THEN
    DBMS_OUTPUT.PUT_LINE('TRUE');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('FALSE');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('FOUND ? (WITH CLOSE CURSOR)');
  IF c_data%FOUND = TRUE THEN
    DBMS_OUTPUT.PUT_LINE('TRUE');
  ELSIF c_data%FOUND = FALSE THEN 
    DBMS_OUTPUT.PUT_LINE('FALSE');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('NULL');
  END IF;
END;*/



/*DECLARE 
  e_insert_too_long_col EXCEPTION;
  w NUMBER := 2;
  PRAGMA EXCEPTION_INIT (e_insert_too_long_col, -12899);
BEGIN
  UPDATE employees SET first_name =  'my_12345678my_12345678my_12345678' WHERE employee_id = 100;
  EXCEPTION 
    WHEN e_insert_too_long_col THEN 
      DBMS_OUTPUT.PUT_LINE('HANDLED');
END;*/

-- ERRORES https://docs.oracle.com/cd/E11882_01/server.112/e17766/toc.htm

DECLARE 
  v_mgr NUMBER := 23456;
BEGIN
  DELETE FROM employees
    WHERE manager_id = v_mgr;
 /* IF SQL%NOTFOUND THEN
    RAISE_APPLICATION_ERROR (-20202, 'ID ' || v_mgr || ' is not a valid manager id',TRUE);
  END IF;*/
  
  /*OR IN THE EXCEPTIONS SECTION:*/
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR (-20202, 'This is not a valid manager');
    
END;
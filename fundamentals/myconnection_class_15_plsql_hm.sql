/*#################################################################################################################
* 
*                                                 Class 15  Apr 2nd, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON;

--connect sys as sysdba:
--CREATE OR REPLACE DIRECTORY sqlfiles AS 'C:\Users\Administrador\Documents\Repositories\GitHub\dejateconecto\luml_inst_dev_ocapl_sqld\fundamentals';
--GRANT READ, WRITE ON DIRECTORY SQLFILES TO hr;
--GRANT EXECUTE ON UTL_FILE TO hr;
--As sysdba. Note* Do not create any directory, it is only the object in the database 
--SELECT * FROM all_directories;


/*CREATE OR REPLACE PROCEDURE read_file(p_dir VARCHAR2, p_filename VARCHAR2) IS
  f_file UTL_FILE.FILE_TYPE;
  v_buffer VARCHAR2(200);
  v_lines PLS_INTEGER := 0;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Start');
    IF NOT UTL_FILE.IS_OPEN(f_file) THEN
      DBMS_OUTPUT.PUT_LINE('Open');
      f_file := UTL_FILE.FOPEN (p_dir, p_filename, 'R');
      DBMS_OUTPUT.PUT_LINE('Opened');
      BEGIN
        LOOP
          UTL_FILE.GET_LINE(f_file,v_buffer);
          v_lines := v_lines + 1;
          DBMS_OUTPUT.PUT_LINE('Line ' || TO_CHAR(v_lines) || ': ' || v_buffer);
        END LOOP;
      END;
    END IF;
  END read_file;*/
  
  
  CREATE OR REPLACE PROCEDURE crate_table_from_file(p_dir VARCHAR2, p_filename VARCHAR2) IS
  f_file UTL_FILE.FILE_TYPE;
  v_buffer VARCHAR2(200);
  v_lines PLS_INTEGER := 0;
  v_string VARCHAR2(50);
  v_contains NUMBER(2);
  v_str1 VARCHAR2(50);
  TYPE t_array is TABLE OF VARCHAR2(50)INDEX BY BINARY_INTEGER;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Start');
    IF NOT UTL_FILE.IS_OPEN(f_file) THEN
      DBMS_OUTPUT.PUT_LINE('Open');
      f_file := UTL_FILE.FOPEN (p_dir, p_filename, 'R');
      DBMS_OUTPUT.PUT_LINE('Opened');
      BEGIN
        LOOP
          UTL_FILE.GET_LINE(f_file,v_buffer);
          v_lines := v_lines + 1;
          --v_contains := INSTR(v_buffer,'|');
          --v_str1 := SUBSTR(v_buffer,0,v_contains-1);
          
          STRING_FNC.SPLIT (v_buffer, '|');
          DBMS_OUTPUT.PUT_LINE(v_str1);
        END LOOP;
      END;
    END IF;
  END crate_table_from_file;


BEGIN
  --read_file('SQLFILES','test');
  crate_table_from_file('SQLFILES','wroten');
END;

/*CREATE OR REPLACE PROCEDURE export_tables(p_dir VARCHAR2, p_base_filename VARCHAR2) IS
  f_file UTL_FILE.FILE_TYPE;
  v_buffer VARCHAR2(200);
  v_lines PLS_INTEGER := 0;
  v_report VARCHAR2(4000);
  v_bonus NUMBER (8,3);
  TYPE t_emp IS TABLE OF hr.employees%rowtype INDEX BY PLS_INTEGER;
  emp_tab t_emp;
  CURSOR c_data IS SELECT * FROM hr.employees;
  v_id     NUMBER := 0;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Program is starting...');
    f_file := UTL_FILE.FOPEN (p_dir, p_filename, 'W');
     FOR i IN c_data LOOP
        v_id := v_id + 1;
        SELECT * 
        INTO emp_tab(v_id)
        FROM hr.employees
        WHERE employee_id = i.employee_id;
        v_bonus := NVL(emp_tab(v_id).salary,0)+(NVL(emp_tab(v_id).salary,0)*.16);
        v_report := --'jola';
          TO_CHAR(emp_tab(v_id).employee_id) || '|' 
          || emp_tab(v_id).first_name || '|'
          || emp_tab(v_id).last_name || '|'
          || emp_tab(v_id).email || '|'
          || emp_tab(v_id).phone_number || '|'
          || emp_tab(v_id).hire_date || '|'
          || emp_tab(v_id).job_id || '|'
          || TO_CHAR(emp_tab(v_id).salary) || '|'
          || emp_tab(v_id).commission_pct || '|'
          || TO_CHAR(emp_tab(v_id).manager_id) || '|'
          || TO_CHAR(emp_tab(v_id).department_id) || '|'
          || TO_CHAR(v_bonus);
          UTL_FILE.PUT_LINE(f_file,v_report);
          --UTL_FILE.NEW_LINE (f_file);
      END LOOP;
      UTL_FILE.FCLOSE (f_file);
    DBMS_OUTPUT.PUT_LINE('Close');
  END write_file;
*/

/*
BEGIN
  write_file('SQLFILES','wroten');
END;*/

--SELECT * FROM employees;


--SMTP MAIL (AS SYS), pasos

--1.- SQL> @C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\utlmail.sql
--2.- SQL> @C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\prvtmail.plb
--3.- SQL> ALTER SYSTEM SET SMTP_OUT_SERVER = 'smtp.gmail.com' SCOPE=SPFILE;
--PROCEDURE
/*4.- SQL> BEGIN
  2  UTL_MAIL.SEND('dejateconecto2.0@gmail.com', 'dejateconecto@outlook.com', me
ssage => 'hola', subject => 'luml_from_oracle_db');
  3  END;*/
BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE DIN_TAB (id NUMBER)';
END;
  
  
BEGIN
  EXECUTE IMMEDIATE 'UPDATE HR.COPY_EMP SET SALARY = 100000 WHERE manager_id = 100';
END;


--BIND Variable


BEGIN
  EXECUTE IMMEDIATE 'UPDATE HR.COPY_EMP SET SALARY = 12000 WHERE manager_id = :x' USING 101;
END;


BEGIN
  EXECUTE IMMEDIATE 'UPDATE HR.COPY_EMP SET SALARY = 33333 WHERE manager_id = :x AND employee_id = :y' USING 122,133;
END;



--BIND 
DECLARE 
  v_id NUMBER;
  v_name VARCHAR2(100);
BEGIN
  EXECUTE IMMEDIATE 'SELECT department_id, department_name FROM departments WHERE department_id = :y' INTO v_id, v_name USING 60;
  DBMS_OUTPUT.PUT_LINE(v_id);
  DBMS_OUTPUT.PUT_LINE(v_name);
END;


BEGIN
  DBMS_OUTPUT.PUT_LINE( SPLIT('luis.abraham', ','));
END;

--https://sistemasgrainhill.wordpress.com/2013/06/07/funcion-split-en-plsql/
/*create or replace package STRING_FNC
IS 
  type t_array is TABLE OF VARCHAR2(50)INDEX BY BINARY_INTEGER;
  FUNCTION SPLIT(in_string VARCHAR2, delim VARCHAR2 ) return t_array;
END;*/

 /*
CREATE OR REPLACE PACKAGE BODY STRING_FNC 
IS
FUNCTION SPLIT (in_string VARCHAR2, delim VARCHAR2) RETURN t_array
    IS
    i number := 0;
    pos number :=0;
    lv_str varchar2(1000) := in_string;
   
    strings t_array;
   
    BEGIN
      pos := instr(lv_str, delim,1,1);
     
      WHILE ( pos != 0) LOOP
        i := i + 1;
       
        strings(i) := substr(lv_str,1,pos);
        lv_str :=  substr(lv_str, pos+1,length(lv_str));
        pos := instr(lv_str, delim, 1, 1);
       
        If pos = 0 THEN
          strings (i+1) := lv_str;
         
          END IF;
         
          END LOOP;
         
          RETURN strings;
          END SPLIT;
         
END STRING_FNC;*/




/*DECLARE
CURSOR c_tables IS SELECT table_name FROM all_tables
WHERE owner = 'HR';
CURSOR c_data IS SELECT 'test' FROM dual;
v_id_table    NUMBER := 0;
v_id     NUMBER := 0;
BEGIN
  FOR i IN c_tables LOOP
        v_id_table := v_id_table + 1;
        DBMS_OUTPUT.PUT_LINE(i.table_name);
        c_data IS SELECT * FROM i.table_name;
  END LOOP;
END;*/
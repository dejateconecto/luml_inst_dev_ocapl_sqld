/*#################################################################################################################
* 
*                                                 Class 15  Apr 2nd, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON;


--CREATE OR REPLACE DIRECTORY sqlfiles AS 'C:\Users\CURSO\Documents\Notas';
--GRANT EXECUTE ON UTL_FILE TO hr;
--As sysdba. Note* Do not create any directory, it is only the object in the database 


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
  END read_file;
*/

/*BEGIN
  --SELECT DIRECTORY_NAME FROM sys.all_directories;
  read_file('SQLFILES','test');
END;*/



CREATE OR REPLACE PROCEDURE write_file(p_dir VARCHAR2, p_filename VARCHAR2) IS
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


BEGIN
  --SELECT DIRECTORY_NAME FROM sys.all_directories;
  write_file('SQLFILES','wroten');
END;

SELECT * FROM employees;


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
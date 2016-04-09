/*#################################################################################################################
* 
*                                                 Class 16  Apr 9th, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON;


/*
CREATE OR REPLACE FUNCTION delete_all_rows
  (p_table_name VARCHAR2) RETURN NUMBER IS
  v_cur_id INTEGER;
  v_rows_del NUMBER;
BEGIN
  v_cur_id := DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(v_cur_id,
    'DELETE FROM ' || p_table_name, DBMS_SQL.NATIVE);
  v_rows_del := DBMS_SQL.EXECUTE(v_cur_id);
  DBMS_SQL.CLOSE_CURSOR(v_cur_id);
  RETURN v_rows_del;
END;
*/

/*DROP TABLE temp_emp;
CREATE TABLE temp_emp AS SELECT * FROM employees;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Rows Deleted: ' ||
    delete_all_rows('TEMP_EMP'));
END;*/


/*
CREATE PROCEDURE insert_row (p_table_name VARCHAR2,
  p_id VARCHAR2, p_name VARCHAR2, p_region NUMBER) IS
  ...*/
  
  
/*##################################################################################################################
#
#                                                   T r i g g e r s
#
###################################################################################################################*/
--DROP TRIGGER secure_emp;
/*CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON temp_emp
  BEGIN
    IF (TO_CHAR(SYSDATE,'DY') IN ('SÁB','DOM')) OR
      (TO_CHAR(SYSDATE, 'HH24:MI') 
      NOT BETWEEN '08:00'  AND '18:00') THEN
      RAISE_APPLICATION_ERROR (-20500, 'You may insert into EMPLOYEES table only during normal business hours.');
    END IF;
  END;*/
CREATE OR REPLACE TRIGGER secure_emp_by_op
BEFORE INSERT OR UPDATE OR DELETE ON temp_emp
  BEGIN
    IF (TO_CHAR(SYSDATE,'DY') IN ('SÁB','DOM')) OR
      (TO_CHAR(SYSDATE, 'HH24:MI') 
      NOT BETWEEN '08:00'  AND '18:00') THEN
      IF DELETING THEN 
          RAISE_APPLICATION_ERROR (-20500, 'You may delete from EMPLOYEES table only during normal business hours.');
        ELSIF INSERTING THEN 
          RAISE_APPLICATION_ERROR (-20500, 'You may insert into EMPLOYEES table only during normal business hours.');
        ELSIF UPDATING THEN
          RAISE_APPLICATION_ERROR (-20500, 'You may update EMPLOYEES table only during normal business hours.');
        ELSE 
          RAISE_APPLICATION_ERROR (-20500, 'You may update EMPLOYEES table only during normal business hours.');
      END IF;
    END IF;
  END;
  
  
SELECT TO_CHAR(SYSDATE,'DY') FROM dual;
  
  
--INSERT INTO TEMP_EMP VALUES (207,	'Ab', 'De la Luz',	'ABDELALUZ',	'011.44.1344.987668',	SYSDATE,	'SA_REP',	7500,	0.2,	145,	80);
DELETE FROM temp_emp WHERE employee_id = 206;

--ALTER TRIGGER secure_emp_by_op DISABLE;
--ALTER TRIGGER secure_emp DISABLE;
ALTER TRIGGER restrict_salary DISABLE;
DROP TRIGGER restrict_salary;

CREATE OR REPLACE TRIGGER restrict_salary
BEFORE INSERT OR UPDATE OF salary ON temp_emp
FOR EACH ROW
BEGIN
  IF NOT (:NEW.job_id IN ('AD_PRESS','AD_VP'))
   AND :NEW.salary > 15000 THEN
     RAISE_APPLICATION_ERROR (-20202, 'Employee cannot earn more than $15,000.');
  END IF;
END;
  

UPDATE temp_emp SET salary = 20000 WHERE employee_id = 205;

INSERT INTO TEMP_EMP VALUES (207,	'Ab', 'De la Luz',	'ABDELALUZ',	'011.44.1344.987668',	SYSDATE,	'SA_REP',	75000,	0.2,	145,	80);

--id_operation
--created_date
--user_creat
--last_update_date
--last_update_user
--operation

CREATE TABLE bitacora (
id_operation NUMBER(2),
created_date DATE DEFAULT SYSDATE,
user_creat VARCHAR2(140),
last_update_date DATE DEFAULT SYSDATE,
last_update_user VARCHAR2(140),
operation_desc VARCHAR2(140),
host_name VARCHAR2(140)
);


CREATE OR REPLACE TRIGGER bitacora_operations
AFTER INSERT OR UPDATE OR DELETE ON temp_emp
BEGIN
  IF DELETING THEN 
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Delete on temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
    ELSIF INSERTING THEN 
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Insert into temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
    ELSIF UPDATING THEN
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Update temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
    ELSE 
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Update into temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
  END IF;
END;


DROP SEQUENCE bitacora_seq;
CREATE SEQUENCE bitacora_seq
  INCREMENT BY 1
  START WITH 1
  MAXVALUE 9999
  NOCACHE
  NOCYCLE;


SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') 
   FROM DUAL;
UPDATE temp_emp SET salary = 20000 WHERE last_name = 'Russell';
DELETE FROM temp_emp WHERE last_name = 'Russell';
INSERT INTO TEMP_EMP VALUES (207,	'Ab', 'De la Luz',	'ABDELALUZ',	'011.44.1344.987668',	SYSDATE,	'SA_REP',	75000,	0.2,	145,	80);




CREATE OR REPLACE TRIGGER bo_old_new
AFTER INSERT OR UPDATE OR DELETE ON temp_emp
BEGIN
  IF DELETING THEN 
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Delete on temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
    ELSIF INSERTING THEN 
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Insert into temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
    ELSIF UPDATING THEN
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Update temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
    ELSE 
      INSERT INTO bitacora (id_operation,user_creat,last_update_user,operation_desc,host_name ) 
      VALUES (bitacora_seq.NEXTVAL,	SYS_CONTEXT ('USERENV', 'SESSION_USER') ,	SYS_CONTEXT ('USERENV', 'SESSION_USER'),	'Update into temp_emp table' , SYS_CONTEXT ('USERENV', 'HOST'));
  END IF;
END;






CREATE OR REPLACE TRIGGER derive_commission_pct
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
ENABLE
WHEN (NEW.job_id = 'SA_REP')
BEGIN
  IF INSERTING THEN
    :NEW.commission_pct := 0;
  ELSIF :OLD.commission_pct IS NULL THEN
    :NEW.commission_pct := 0;
  ELSE
    :NEW.commission_pct := :OLD.commission_pct+0.05;
  END IF;
END;



UPDATE employees SET department_id = 999
WHERE employee_id = 170;


BEGIN
  NULL; -- WTF?
END;




Microsoft Windows [Versión 6.1.7601]
Copyright (c) 2009 Microsoft Corporation. Reservados todos los derechos.

C:\Users\CURSO>cd Escritorio
El sistema no puede encontrar la ruta especificada.

C:\Users\CURSO>CD C:\Users\CURSO\Documents\Notas

C:\Users\CURSO\Documents\Notas>WRAP INAME=myconnection_class_16_plsql.sql

PL/SQL Wrapper: Release 11.2.0.2.0- 64bit Production on Sßb Abr 09 14:31:49 2016

Copyright (c) 1993, 2009, Oracle.  All rights reserved.

Processing myconnection_class_16_plsql.sql to myconnection_class_16_plsql.plb

C:\Users\CURSO\Documents\Notas>





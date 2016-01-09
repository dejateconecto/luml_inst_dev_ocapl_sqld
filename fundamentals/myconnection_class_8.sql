/*#################################################################################################################
* 
*                                                 Class 8  Jan 9th, 2016
*                                                                    
*################################################################################################################*/

/* Las vistas son creadas en tiempo de ejecución, no están guardadas en la base de datos
    Objetos 
      Tables
      Views
*/

SELECT COUNT(*), department_id FROM employees GROUP BY department_id ORDER BY 1;
CREATE VIEW empvu80
  AS SELECT employee_id, last_name, salary
     FROM employees
     WHERE department_id = 80;
DESC empvu80;
--DROP VIEW empvu80;
     
--con alias
CREATE VIEW salvu50
  AS SELECT employee_id ID_NUMBER
        , last_name NAME
        , salary*12 ANN_SALARY
     FROM employees
     WHERE department_id = 50;
DESC salvu50;
--DROP VIEW empvu80;


CREATE VIEW sal30_V(
  emp_number,
  name,
  ann_sal
)
  AS SELECT employee_id
        , last_name
        , salary*12
     FROM employees
     WHERE department_id = 30;
DESC sal30_V;
--DROP VIEW sal30_V;

-- Throws error ORA-00955: name is already used by an existing object
CREATE VIEW sal30_V(
  employee_number,
  name,
  ann_sal
)
  AS SELECT employee_id
        , last_name
        , salary*12
     FROM employees
     WHERE department_id = 30
     AND manager_id IS NOT NULL;

CREATE OR REPLACE VIEW sal30_V(
  employee_number,
  name,
  ann_sal
)
  AS SELECT employee_id
        , last_name
        , salary*12
     FROM employees
     WHERE department_id = 30
     AND manager_id IS NOT NULL;
     
CREATE OR REPLACE VIEW emp20_v
AS SELECT * 
   FROM employees 
   WHERE department_id = 20
   WITH CHECK OPTION CONSTRAINT emp20_v;
   
DESC emp20_v;

SELECT * FROM employees WHERE employee_id IN (200,201);
SELECT * FROM emp20_v;
Insert into emp20_v (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (employees_seq.nextval,'Ashish','Whalen','ASH','515.123.4244',to_date('09/01/16','DD/MM/RR'),'AD_ASST',4400,null,101,10);
Insert into emp20_v (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (employees_seq.nextval,'Narasinga','Allipilli','NAR','515.123.5355',to_date('09/01/16','DD/MM/RR'),'MK_MAN',13000,null,100,20);

--With read only option
CREATE OR REPLACE VIEW emp20_v
AS SELECT * 
   FROM employees 
   WHERE department_id = 20
   --WITH CHECK OPTION CONSTRAINT emp20_v
   WITH READ ONLY;

-- Throws error ORA-42399: cannot perform a DML operation on a read-only view
UPDATE emp20_v SET salary = 2000;

CREATE SEQUENCE dept_deptid_seq
  INCREMENT BY 10
  START WITH 1010
  MAXVALUE 9999
  NOCACHE
  NOCYCLE;

SELECT departments_seq.CURRVAL FROM dual;
--Sequences
INSERT INTO departments (department_id,department_name, location_id)
VALUES (dept_deptid_seq.NEXTVAL,'Support',2500);

SELECT dept_deptid_seq.CURRVAL FROM dual;

--Para alterar se debe de ser dueño del objeto 
ALTER SEQUENCE dept_deptid_seq
  INCREMENT BY 10
  --START WITH 3000--00000 -  "cannot alter starting sequence number"
  MAXVALUE 9999
  NOCACHE
  NOCYCLE;


--DROP SEQUENCE dept_deptid_seq;

CREATE INDEX emp_last_name_idx
ON employees(last_name);
--DROP INDEX index_name;



CREATE OR REPLACE SYNONYM oe.wtf 
FOR hr.employees;

DROP SYNONYM wtf ;

SELECT * FROM wtf;

grant select on wtf to oe;
  
  DESC wtf;

  CREATE OR REPLACE SYNONYM oe.locations 
FOR hr.locations;


/*
los grants a usar son:
  GRANT PUBLIC SYNONYM ON scheme_name.synonym_name TO object_owner_scheme_name.object_name;
  GRANT SYNONYM ON scheme_name.synonym_name TO object_owner_scheme_name.object_name;
  -- not to use GRANT ANY SYNONYM
*/

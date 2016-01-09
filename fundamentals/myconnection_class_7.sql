/*#################################################################################################################
* 
*                                                 Class 7  Dec 12nd, 2015
*                                                                    
*################################################################################################################*/

--DESC employees;

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id)
SELECT (SELECT MAX(employee_id)+5 FROM employees)+ROWNUM
, first_name || 'est'
,last_name || 'est'
, email || 'EST'
,sysdate-5
,job_id
FROM employees WHERE department_id = 100;
SAVEPOINT a;
UPDATE hr.employees 
SET 
  salary = NVL(salary,0) + 10000 + (ROWNUM*5000)
  ,phone_number = 5566778899
  ,commission_pct = NVL(commission_pct,ROWNUM*.1)
  ,manager_id = 101
WHERE employee_id >=212;
ROLLBACK TO a;
COMMIT;
SELECT * FROM employees WHERE employee_id >=212;
DELETE FROM hr.employees WHERE employee_id >=212;

--CORRER INSERT, CONECTAR A ESQUEMA OE Y HACER SELECT A LOS REGISTROS QUE EN TEORIA NO SE DEBERIAN DE VER


SELECT employee_id
  ,salary
  ,commission_pct
  ,job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE
ORDER BY employee_id;


GRANT UPDATE ON EMPLOYEES TO OE;



---#####################################################################

CREATE TABLE MiTablaDePrueba (ide NUMBER, name_q VARCHAR2(30));

DROP TABLE MiTablaDePrueba;

--####################################################################

CREATE TABLE dept
  (
    deptno NUMBER(2)
    ,dname VARCHAR(14)
    ,loc VARCHAR(13)
    ,create_date DATE DEFAULT SYSDATE
    ,CONSTRAINT deptno_id_pk PRIMARY KEY(deptno)
  );
  
CREATE TABLE dept_child
  (
    dept_id NUMBER(2)
    ,dname VARCHAR(14)
    ,loc VARCHAR(13)
    ,create_date DATE DEFAULT SYSDATE
    ,CONSTRAINT deptno_id_child_pk FOREIGN KEY(dept_id) REFERENCES dept(deptno)
  );
DROP TABLE dept CASCADE CONSTRAINTS; -- Borra también las dependencias de las tablas hijas, eliminando todas las constraints
DROP TABLE dept;  
DROP TABLE dept_child;  
  
  SELECT * FROM all_constraints WHERE table_name = 'EMPLOYEES';
/*#################################################################################################################
* 
*                                                 Class 14  Mar 12th, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON;

/*CREATE OR REPLACE PROCEDURE p_my_package
(v_emp_id IN NUMBER,
v_salary IN OUT NUMBER) 
IS 
BEGIN
  DBMS_OUTPUT.PUT_LINE('Program is starting...');
  DBMS_OUTPUT.PUT_LINE('in-param v_salary: ' || v_salary);
  SELECT salary INTO v_salary FROM employees WHERE employee_id = v_emp_id;
  DBMS_OUTPUT.PUT_LINE('out-param v_salary: ' || v_salary);
  DBMS_OUTPUT.PUT_LINE('Program has finished successfully.');
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SP exception');
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;*/

/*DECLARE
  v_emp_id NUMBER := 100;
  v_salary NUMBER := 100;
  c_emp_id CONSTANT NUMBER := 121;
BEGIN
  v_salary := 9;
  --p_my_package(101, v_salary);
  --p_my_package(50*3, v_salary);
  --p_my_package(c_emp_id, v_salary);
  --p_my_package(v_emp_id, v_salary);
  --p_my_package(101, 200); -- error: expression cannot be used as an assignment target
  p_my_package(101, v_salary);
  
  --p_my_package( v_emp_id => 115, v_salary);
  DBMS_OUTPUT.PUT_LINE('Salario: ' || v_salary);
END;*/

/*CREATE OR REPLACE PROCEDURE add_dept (
p_dept_id IN departments.department_id%TYPE,
p_name IN departments.department_name%TYPE,
--p_loc IN departments.location_id%TYPE DEFAULT 2400,
p_loc IN departments.location_id%TYPE :=  1700,
p_mgr_id IN departments.manager_id%TYPE)
AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('location_id: ' || p_loc);
  INSERT INTO departments(department_id, department_name, location_id, manager_id)
  VALUES (p_dept_id, p_name, p_loc, p_mgr_id);
END add_dept;*/

/*
DECLARE
  v_dept_id NUMBER := 280;
  v_name VARCHAR2 (10) := 'IT QA';
  v_loc NUMBER := 1700;
  v_mgr_id NUMBER := 100;
BEGIN
  --add_dept(v_dept_id,v_name,v_loc,v_mgr_id);
  --add_dept(v_dept_id,v_name,p_mgr_id => v_mgr_id, p_loc => v_loc );
  add_dept(p_mgr_id => v_mgr_id, p_loc => v_loc, p_name => v_name, p_dept_id => v_dept_id );
END;*/


--EXECUTE add_dept(p_mgr_id => 100, p_name => 'IT QA', p_dept_id => 280 );
--EXECUTE add_dept(p_mgr_id => null, p_name => 'IT QA', p_dept_id => 280 );
--EXECUTE add_dept(p_mgr_id => null, p_name => 'IT QA', p_dept_id => 280 , p_loc => null );  --pasa ok
--EXECUTE add_dept(p_mgr_id => null, p_name => 'IT QA', p_dept_id => 280 );


--EXECUTE add_dept(p_mgr_id => 100, p_name => 'IT QA', p_dept_id => 290, p_loc => 2500  );


/*DECLARE
  v_sal NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Caller program starts...');
  p_my_package(1, v_sal);
  DBMS_OUTPUT.PUT_LINE('Caller program is ending...');
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An exception was thrown...');
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;*/

/*DESCRIBE user_source; --all_source -- dba_source

SELECT text
FROM user_source
WHERE name = 'ADD_DEPT' AND type = 'PROCEDURE';*/

/*CREATE OR REPLACE FUNCTION get_sal
(p_id employees.employee_id%TYPE)
RETURN NUMBER
IS v_sal employees.salary%TYPE := 0;
BEGIN
  SELECT salary
  INTO v_sal
  FROM employees 
  WHERE employee_id = p_id;
  IF v_sal > 15000 THEN
    RETURN 25000;
  ELSE
    RETURN v_sal;
  END IF;
END get_sal;

EXECUTE DBMS_OUTPUT.PUT_LINE(get_sal(100));*/

/*DECLARE
  sal employees.salary%TYPE;
BEGIN
  sal := get_sal(100);
  DBMS_OUTPUT.PUT_LINE('The salary is: ' || sal);
END;*/

/*CREATE OR REPLACE FUNCTION dml_call_sql (p_sal NUMBER)
RETURN NUMBER IS
BEGIN
  INSERT INTO employees ( employee_id, last_name, email, hire_date, job_id, salary)
  VALUES (1,'Frost','jfrost@company.com',SYSDATE, 'SA_MAN',p_sal);
  RETURN (p_sal + 100);
END dml_call_sql;*/

/*UPDATE employees
SET salary = dml_call_sql (2000)
WHERE employee_id = 170;*/

/*#################################################################################################################
* 
*                                                  Creating Packages
*                                                                    
*################################################################################################################*/
-- The package spec with a public variable and a
-- public procedure that are accessible from
-- outside the package.
/*CREATE OR REPLACE PACKAGE comm_pkg IS
  v_std_comm NUMBER; --:= 0.10; --initialized to o.1o
PROCEDURE reset_comm ( p_new_comm NUMBER );
END comm_pkg;*/

/*DECLARE
  v_my_sal NUMBER := 2000;
BEGIN
  hr.comm_pkg.v_std_comm := .1;
  DBMS_OUTPUT.PUT_LINE('Mi salario es ' || v_my_sal || ' y aumentado en un ' || 100*hr.comm_pkg.v_std_comm || '%, es ' || (v_my_sal + v_my_sal * hr.comm_pkg.v_std_comm));
END;*/



/*CREATE OR REPLACE PACKAGE BODY comm_pkg IS
  FUNCTION validate(p_comm NUMBER) RETURN BOOLEAN IS v_max_comm employees.commission_pct%TYPE;
  BEGIN
    SELECT MAX(commission_pct) INTO v_max_comm
    FROM employees;
    RETURN (p_comm BETWEEN 0.0 AND v_max_comm);
  END validate;
  
  PROCEDURE reset_comm ( p_new_comm NUMBER ) IS
  BEGIN
    IF validate(p_new_comm) THEN
      v_std_comm := p_new_comm; --reset public var
    ELSE 
      RAISE_APPLICATION_ERROR (-20210,'Bad Commission');
    END IF;
  END reset_comm;
END comm_pkg;*/
--EXECUTE hr.comm_pkg.reset_comm (-0.1);

CREATE OR REPLACE PACKAGE forward_pkg IS
PROCEDURE award_bonus;
END forward_pkg;
CREATE OR REPLACE PACKAGE BODY forward_pkg IS
  PROCEDURE calc_rating;
  PROCEDURE award_bonus IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('award_bonus');
    calc_rating();
  END award_bonus;

  PROCEDURE calc_rating IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('calc_rating');
  END calc_rating;
END forward_pkg;
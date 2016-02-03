/*#################################################################################################################
* 
*                                                 Class 11  Jan 30rd, 2016
*                                                                    
*################################################################################################################*/

-- identificadores, literales, delimitadores y comentarios (lexico)
SET SERVEROUTPUT ON;
--CL SCR;
/*
DECLARE
  v_fname VARCHAR2(25);
BEGIN
  SELECT first_name INTO v_fname  
  FROM employees WHERE employee_id = 200; --WHERE employee_id = 20000;
  DBMS_OUTPUT.PUT_LINE('First name is: ' || v_fname);
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;*/
/*
DECLARE
  v_e_hiredate employees.hire_date%TYPE;
  v_e_salary employees.salary%TYPE;
BEGIN
  SELECT 
    hire_date
    ,salary * 12 INTO v_e_hiredate , v_e_salary
  FROM employees WHERE employee_id =  100;
  DBMS_OUTPUT.PUT_LINE('Hire date: ' || TO_CHAR(v_e_hiredate, 'DD-MON-YYYY'));
  DBMS_OUTPUT.PUT_LINE('Annual salary: ' || v_e_salary);
END;*/
/*BEGIN
  INSERT INTO employees
    (employee_id
    ,first_name
    ,last_name
    ,email
    ,hire_date
    ,job_id
    ,salary)
  VALUES (
    employees_seq.NEXTVAL
    ,'Ruth'
    ,'Cores'
    ,'RCORES'
    ,CURRENT_DATE
    ,'AD_ASST'
    ,4000
  );
END;*/
/*DECLARE
  sal_increase employees.salary%TYPE := 800;
BEGIN
  UPDATE employees
  SET salary = salary + sal_increase
  WHERE job_id = 'ST_CLERK';
END;*/
/*CREATE TABLE copy_emp AS
SELECT * FROM employees WHERE employee_id = 200;
DESC copy_emp;*/
/*BEGIN
MERGE INTO
  copy_emp c
    USING employees e
    ON (e.employee_id = c.employee_id)
  WHEN MATCHED THEN
    UPDATE SET
    c.first_name = e.first_name,
    c.last_name = e.last_name,
    c.email = e.email,
    c.department_id = e.department_id
  WHEN NOT MATCHED THEN
    INSERT VALUES(
    e.employee_id,
    e.first_name,
    e.last_name,
    e.email,
    e.phone_number,
    e.hire_date,
    e.job_id,
    e.salary,
    e.commission_pct,
    e.manager_id,
    e.department_id
    );
    COMMIT;
END;*/

--TRUNCATE TABLE copy_emp;
/*DECLARE
  v_rows_deleted VARCHAR(20);
  v_empno copy_emp.employee_id%TYPE := 200;
BEGIN
  DELETE FROM copy_emp
  WHERE employee_id = v_empno;
  v_rows_deleted := (SQL%ROWCOUNT ||
                      ' row deleted.');
  CASE 
    WHEN SQL%ROWCOUNT > 0 THEN 
      DBMS_OUTPUT.PUT_LINE(v_rows_deleted);
    ELSE 
      DBMS_OUTPUT.PUT_LINE('Any row was deleted');
  END CASE;
  --COMMIT;
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;*/

/*DECLARE
  v_my_age NUMBER := 26;
BEGIN
  IF v_my_age < 11 THEN
    DBMS_OUTPUT.PUT_LINE('I am a child');
  ELSE 
    IF v_my_age > 20 THEN
      DBMS_OUTPUT.PUT_LINE('I am a ancient');
    END IF;
  END IF;
END;*/
/*
DECLARE
  v_emp_id NUMBER(3) := emp_id_PONER_AND_PERSON;
  v_lname copy_emp.last_name%TYPE;
  v_hdate copy_emp.hire_date%TYPE;
  v_rows_deleted VARCHAR(40);
  v_rows_updated VARCHAR(40);
  v_rows NUMBER(4);
BEGIN
  SELECT last_name, hire_date INTO v_lname, v_hdate FROM copy_emp WHERE employee_id = v_emp_id;
  DBMS_OUTPUT.PUT_LINE('Employee "' || v_lname || '" was hired on ' || TO_CHAR(v_hdate,'DD-MON-YYYY'));
  DELETE FROM copy_emp
  WHERE hire_date < v_hdate;
  v_rows_deleted := ( SQL%ROWCOUNT || ' row(s) was/were deleted');
  DBMS_OUTPUT.PUT_LINE(v_rows_deleted);
  v_rows := SQL%ROWCOUNT;
  IF v_rows > 10 THEN
    DBMS_OUTPUT.PUT_LINE(v_rows || ' is greater than 10');
  ELSIF v_rows < 10 THEN
    DBMS_OUTPUT.PUT_LINE(v_rows || ' is less than 10');
  END IF;
  UPDATE copy_emp
  SET salary = salary + (salary * 0.30);
  v_rows_updated := ( SQL%ROWCOUNT || ' row(s) was/were updated');
  DBMS_OUTPUT.PUT_LINE(v_rows_updated);
  v_rows := SQL%ROWCOUNT;
  IF v_rows > 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_rows || ' employee(s) was/were benefited with an 30% of salary increase');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('Any employee was benefited with an 30% of salary increase');
  END IF;
  ROLLBACK;
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
--buscar al emp
--antes 1 ene 2004, boorar y pintaaar cuanto se eliminiraton
--si se eliminan mas de 10 mensaje al gusto, menos de 10 mensaje algusto
--los que se quedaron au,emto salario en 30%

/*
id dinamico, evaluar fecha, 
  si es menor al 1 Ene 97, me van a despedir por que llevo mucho tiempo aqui, DELETE
  pero en mi lugar se que queda
  insertarme como empleado
  y el nuevo empleado se llama, nombre apellido, cuanto va a ganar, y salario +  mi comissión en total gano
  
  else mi nombre es, mi antigueda es de N años, N meses, N dias
    update 30% 
    if trabaja en ventas, yo trabajo en ventas 
      si despues del aumento supera los 8000 
        mi salario ahora es de $$$$
        si tiene comissión pintar salario mas commissión
      si no es mayor a 8000
        mi salario de becario y le tengo que echar ganas
    else if IT 
      yo trabajo en IT y tengo un bono mensual del 40% de mi salario base
        si tiene comisión
          pero como tengo comisión ahora gano
        si no tiene comisión
          si su jefe es 'Alexander Hundo?
            insertar un nuevo puesto de trabajo
            update mi reggistro y ponernos como IT manager 
    else
      yo trabajo en el dpto "tal" 
        si tiene comissión
          update a 0
          me quitaron mi comissión por que no soy vendedor, ahora me quedo ganando "salary"
*/


DECLARE
  v_emp_id NUMBER(3) := &emp_id;
  v_fname copy_emp.first_name%TYPE;
  v_lname_bye copy_emp.last_name%TYPE;
  v_jobid_bye copy_emp.job_id%TYPE;
  v_salary_bye copy_emp.salary%TYPE;
  v_cpct_bye copy_emp.salary%TYPE;
  v_mgr_id_bye copy_emp.manager_id%TYPE;
  v_deparment_id_bye copy_emp.department_id%TYPE;
  v_lname copy_emp.last_name%TYPE;
  v_salary copy_emp.salary%TYPE;
  v_tsalary copy_emp.salary%TYPE;
  v_hdate_bye copy_emp.hire_date%TYPE;
  v_rows_deleted VARCHAR(40);
  v_rows_inserted VARCHAR(40);
  v_rows_updated VARCHAR(40);
  v_rows NUMBER(4);
  v_months NUMBER(4);
  v_years NUMBER(2);
  v_days NUMBER(8);
BEGIN
  SELECT last_name, hire_date, job_id, salary, commission_pct, manager_id, department_id 
    INTO v_lname_bye, v_hdate_bye, v_jobid_bye,v_salary_bye,v_cpct_bye ,v_mgr_id_bye, v_deparment_id_bye
  FROM copy_emp WHERE employee_id = v_emp_id;
  DBMS_OUTPUT.PUT_LINE('El empleado "' || v_lname || '" fue contratado el ' || TO_CHAR(v_hdate_bye,'DD-MON-YYYY'));
  IF v_hdate_bye < TO_DATE('01-ENE-99','DD-MON-RR') THEN
    DBMS_OUTPUT.PUT_LINE('Me van a despedir por que llevo mucho tiempo aqui');
    DELETE FROM copy_emp
    WHERE employee_id = v_emp_id;
    v_rows_deleted := ( SQL%ROWCOUNT || ' row(s) was/were deleted');
    DBMS_OUTPUT.PUT_LINE(v_rows_deleted);
    v_rows := SQL%ROWCOUNT;
    INSERT INTO copy_emp VALUES(2016,'Luis','De la Luz','dejateconecto','543.123.123',TO_DATE('30-ENE-16','DD-MON-YY'),'IT_PROG',50000,0.3,null,1000);
    v_rows_inserted := ( SQL%ROWCOUNT || ' row(s) was/were inserted');
    DBMS_OUTPUT.PUT_LINE(v_rows_inserted);
    v_rows := SQL%ROWCOUNT;
    SELECT first_name, last_name, salary, salary + salary * commission_pct INTO v_fname, v_lname, v_salary, v_tsalary
    FROM copy_emp
    WHERE employee_id = 2016;
    DBMS_OUTPUT.PUT_LINE('Pero en mi lugar se que queda ' || v_fname || ' ' || v_lname || ' ganando un salario bruto de $' || v_salary || ' y en total $' || v_tsalary);  
  ELSE
    v_months := TRUNC(MONTHS_BETWEEN(SYSDATE,v_hdate_bye));
    v_years := TRUNC(v_months/12);
    v_days := SYSDATE - v_hdate_bye;
    DBMS_OUTPUT.PUT_LINE('Años ' || v_months || ' meses' || ' dias' || v_days);
    DBMS_OUTPUT.PUT_LINE('Mi nombre es "' || v_lname || '" fui contratado el ' || TO_CHAR(v_hdate_bye,'DD-MON-YYYY'));
    UPDATE copy_emp
    SET salary = salary + (salary * 0.30)
    WHERE employee_id = v_emp_id;
    v_rows_updated := ( SQL%ROWCOUNT || ' row(s) was/were updated');
    DBMS_OUTPUT.PUT_LINE(v_rows_updated);
    IF v_jobid_bye = 'SA_REP' THEN
      DBMS_OUTPUT.PUT_LINE('Yo trabajo en ventas');
      SELECT salary, salary + salary * commission_pct INTO v_salary_bye, v_cpct_bye
      FROM copy_emp WHERE employee_id = v_emp_id;
      IF v_salary_bye > 8000 THEN
        DBMS_OUTPUT.PUT_LINE('Mi salario ahora es de ' || v_salary_bye || ' y con comisión ' || v_cpct_bye);
      END IF;
    ELSIF v_jobid_bye = 'IT_PROG' THEN
      DBMS_OUTPUT.PUT_LINE('Yo trabajo en TI y tengo un bono mensual del 40% de mi salario base que es ' || v_salary_bye);
      IF NVL(v_cpct_bye,0) > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Pero como tengo comisión ahora gano ' || v_salary_bye + v_salary_bye * v_cpct_bye);
      ELSE
        IF v_mgr_id_bye = 115 THEN
          INSERT INTO jobs VALUES('DBA_IT','Database administrator',50000,120000);
          v_rows_inserted := ( SQL%ROWCOUNT || ' row(s) was/were inserted');
          DBMS_OUTPUT.PUT_LINE(v_rows_inserted);
          v_rows := SQL%ROWCOUNT;
          UPDATE copy_emp
          SET job_id = 'DBA_IT'
          WHERE employee_id = v_empno;
          v_rows_updated := ( SQL%ROWCOUNT || ' row(s) was/were updated');
          DBMS_OUTPUT.PUT_LINE(v_rows_updated);
        END IF;
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Yo trabajo en el departamento' || v_deparment_id_bye);
      IF NVL(v_cpct_bye,0) > 0 THEN
        UPDATE copy_emp
        SET commission_pct = 0
        WHERE employee_id = v_emp_id;
        v_rows_updated := ( SQL%ROWCOUNT || ' row(s) was/were updated');
        DBMS_OUTPUT.PUT_LINE(v_rows_updated);
        DBMS_OUTPUT.PUT_LINE('Me quitaron mi comisión por que no soy vendedor, ahora me quedo ganando ' || v_salary_bye);
      END IF;
    END IF;
  END IF;
  ROLLBACK;
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;
END;
/*#################################################################################################################
* 
*                                                 Class 8  Jan 9th, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON

--ANONYMOUS BLOCK
DECLARE --[DECLARE]
  v_saludo VARCHAR2(10) := 'Saludo';
BEGIN
  DBMS_OUTPUT.PUT_LINE(v_saludo);
END;


--ANONYMOUS BLOCK
DECLARE --[DECLARE]
  v_FNAME VARCHAR2(10);
BEGIN
  SELECT first_name INTO v_fname FROM employees
  WHERE employee_id=100;
  DBMS_OUTPUT.PUT_LINE(v_fname);
END;


-- los sp son objecto que viven en la BD, las funciones no
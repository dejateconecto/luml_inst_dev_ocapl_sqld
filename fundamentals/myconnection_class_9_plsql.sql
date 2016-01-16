/*#################################################################################################################
* 
*                                                 Class 9  Jan 16th, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON
/*
--ANONYMOUS BLOCK
DECLARE --[DECLARE]
  v_salutation VARCHAR2(10) := 'Saludo';
  v_error VARCHAR2(30) := 'Error found...';
BEGIN
  v_salutation := '12345678910';
  DBMS_OUTPUT.PUT_LINE(v_salutation);
  EXCEPTION WHEN OTHERS THEN -- plsql patern exception
    DBMS_OUTPUT.PUT_LINE(v_error || ' ' || SQLERRM || ', error code' || SQLCODE);
  
END;

DECLARE
  myVar VARCHAR2(5); -- it has to start with a letter
  myVar2 VARCHAR2(5); -- it can include numbers
  my_Var$ VARCHAR2(5); -- it can include the following special characters: $, # and _
  myVar1234567890myVar1234567890 VARCHAR2(5); -- Is has a maximum lenght 30 characters
  myVarSELECT VARCHAR2(5); -- Is has not to be a keyword
BEGIN
  DBMS_OUTPUT.PUT_LINE(myVar || myVar2 || my_Var$ || myVar1234567890myVar1234567890 || myVarSELECT);
END;




DECLARE
  v_hiredate DATE;
  v_deptno NUMBER(2) NOT NULL  := 10;
  v_location VARCHAR2(13) DEFAULT 'Atlanta';
  c_comm CONSTANT NUMBER :=  1400; --DEFAULT not alloed
  c_string CONSTANT VARCHAR(4) := 'hola';
BEGIN
  --c_comm := 2; -- Not allowed
  DBMS_OUTPUT.PUT_LINE(v_hiredate || v_deptno || v_location || c_comm);
END;


DECLARE
  v_event VARCHAR2(15);
BEGIN
  v_event := q'!FATHER'S DAY!';
  DBMS_OUTPUT.PUT_LINE('3rd Sunday in June is : ' || v_event );
  v_event := q'[Mother's day]';
  DBMS_OUTPUT.PUT_LINE('2nd Sunday in May is: ' || v_event );
END;

--- Variables
--Scalar (almacenan un solo valor, por ej. VARCHAR2, NUMBER, DATE and BOOLEAN), reference (son apuntadores), large object(LOB, tipo de dato multimendia) 
--and composite (tipos de datos compuestos records que almacenan más de un solo valor)



DECLARE
  v_emp_job VARCHAR2(9);
  v_count_loop BINARY_INTEGER := 0;
  v_dept_total_sal NUMBER(9,2) :=1155507.34;
  v_orderdate DATE := SYSDATE + 7;
  c_tax_rate CONSTANT NUMBER (3,2) := 8.25;
  v_valid BOOLEAN NOT NULL := TRUE;
BEGIN
  DBMS_OUTPUT.PUT_LINE(v_emp_job);
  DBMS_OUTPUT.PUT_LINE(v_count_loop);
  DBMS_OUTPUT.PUT_LINE(v_dept_total_sal);
  DBMS_OUTPUT.PUT_LINE(v_orderdate);
  DBMS_OUTPUT.PUT_LINE(c_tax_rate);
  CASE WHEN v_valid = TRUE THEN 
    DBMS_OUTPUT.PUT_LINE('true');-- DECODE did not work :'( , we had to use CASE statement
  ELSE 
    DBMS_OUTPUT.PUT_LINE('false');
  END CASE;
END;



--Bind variables
UNDEFINE b_result
VARIABLE b_result NUMBER
BEGIN
  SELECT (salary*12) + NVL(commission_pct,0) INTO :b_result
  FROM employees WHERE employee_id = 144;
END;
/
PRINT b_result


*/


DECLARE 
  startsWithLetter VARCHAR2(5) := 'hey!';
  digit#1 NUMBER(1) DEFAULT 1;
  var_yesteday DATE := SYSDATE - 1;
  var_today DATE := SYSDATE;
  myVar1234567890myVar1234567890 VARCHAR2(1) NOT NULL DEFAULT 'A';
  varBoo BOOLEAN DEFAULT TRUE;
  v_emp_id employees.employee_id%TYPE;
BEGIN
  SELECT TRUNC(AVG(employee_id))*DBMS_RANDOM.VALUE INTO v_emp_id FROM employees;
  IF v_emp_id > 45 THEN  --45:FALSE   --200 exception
    varBoo := FALSE;
  ELSE
    varBoo := TRUE;
    --myVar1234567890myVar1234567890 := 'This is not a CHAR value!!!';
  END IF;
  CASE 
    WHEN varBoo = TRUE THEN
      DBMS_OUTPUT.PUT_LINE(startsWithLetter || q'! Luis, yesterday was !' || var_yesteday || q'/ ( value evaluated /' || v_emp_id || q'< )>');
    ELSE
      DBMS_OUTPUT.PUT_LINE(q'<error type >' || myVar1234567890myVar1234567890  || q'/ ( value evaluated /' || v_emp_id || q'< )>');
  END CASE;
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(q'?error description not found code?' || SQLCODE  || q'/ ( value evaluated /' || v_emp_id || q'< )>');
END;
-- other, toomanyrows,nodatafound
/*#################################################################################################################
* 
*                                                 Class 10  Jan 23rd, 2016
*                                                                    
*################################################################################################################*/

SET SERVEROUTPUT ON
/*
DECLARE
  v_your_name VARCHAR2(100);
  v_your_birthday VARCHAR2(10);
BEGIN
  -- mas de 50 c pinta tamaño + msg
  v_your_name := TRIM(UPPER('&give_me_your_name'));
  --DBMS_OUTPUT.PUT_LINE(LENGTH(v_your_name));
  IF LENGTH(v_your_name) > 50 THEN
    DBMS_OUTPUT.PUT_LINE('Your name is too long '|| v_your_name || ', are you Indian?');
  ELSE
    v_your_birthday := TRIM(UPPER('&give_me_your_birthday'));
    IF MONTHS_BETWEEN (SYSDATE,TO_DATE(v_your_birthday,'DD-MM-YYYY')) < 18*12 THEN
      DBMS_OUTPUT.PUT_LINE('You are too young ' || v_your_name);
    ELSE
      DBMS_OUTPUT.PUT_LINE('You are too old ' || v_your_name);
    END IF;
    
  END IF;
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Incorrect data format' || SQLCODE || SQLERRM );
END;


DECLARE
  v_my_date DATE := '01-DEC-15';
  v_my_number_str VARCHAR2(2) := '20';
  v_my_number NUMBER(2) := 25;
BEGIN
  IF SYSDATE > v_my_date THEN
    DBMS_OUTPUT.PUT_LINE(SYSDATE || ' is bigger than ' || v_my_date);
  ELSE
    DBMS_OUTPUT.PUT_LINE(v_my_date || ' is bigger than ' || SYSDATE);
  END IF;
  
  IF v_my_number > v_my_number_str THEN
    DBMS_OUTPUT.PUT_LINE(v_my_number || ' is bigger than ' || v_my_number_str);
  ELSE
    DBMS_OUTPUT.PUT_LINE(v_my_number || ' is bigger than ' || v_my_number);
  END IF;
  DBMS_OUTPUT.PUT_LINE(q'<Use of 'TO_CHAR()' function >' || TO_CHAR(v_my_date,'DD-MON-YYYY HH:MI:SS'));
  DBMS_OUTPUT.PUT_LINE(q'<Use of 'TO_DATE() function >' || TO_CHAR(TO_DATE('12-12-2000','DD-MM-YYYY'),'DD-MM-YYYY'));
  
END;



DECLARE
  v_outer_variable VARCHAR2(29) := 'GLOBAL VARIABLE';
BEGIN
  DECLARE
    v_inner_variable VARCHAR2(29) := 'LOCAL VARIABLE';
  BEGIN
    DBMS_OUTPUT.PUT_LINE(v_inner_variable);
    DBMS_OUTPUT.PUT_LINE(v_outer_variable);
  END;
  DBMS_OUTPUT.PUT_LINE(v_outer_variable);
  DBMS_OUTPUT.PUT_LINE(v_inner_variable);
END;
<<l_outer_date>>
DECLARE
  v_father_name VARCHAR2(20) := 'Patrik';
  v_date_of_birth DATE := '20-04-1972';
BEGIN
  DECLARE
    v_child_name VARCHAR2(20) := 'Mike';
    v_date_of_birth DATE := '12-12-2002';
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Father''s Name: ' || v_father_name);
    DBMS_OUTPUT.PUT_LINE('Day of birth: ' || v_date_of_birth);
    DBMS_OUTPUT.PUT_LINE('Child''s Name: ' || v_child_name);
    DBMS_OUTPUT.PUT_LINE('Day (outer) of birth: ' || l_outer_date.v_date_of_birth);
    l_outer_date.v_date_of_birth := '31-12-1999';
    DBMS_OUTPUT.PUT_LINE('Day (modified outer in inner block) of birth: ' || l_outer_date.v_date_of_birth);
  END;
  DBMS_OUTPUT.PUT_LINE('Day of birth: ' || v_date_of_birth);
END;

-- identificadores, literales, delimitadores y comentarios (lexico)
*/
<<outer_block>>
DECLARE
  v_my_date DATE := SYSDATE;
  v_round NUMBER (3,2);
  v_random NUMBER (20) DEFAULT 0;
  custume_exception EXCEPTION;
  v_div_by_zero NUMBER (1) DEFAULT 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE(q'<<-- outer block starts here-->>');
  DBMS_OUTPUT.PUT_LINE(q'<Today is >' || SYSDATE);
  <<inner_block>>
  DECLARE
    v_my_date VARCHAR2(10) := '01-01-2000';
    v_months NUMBER(5,2) DEFAULT 0;
    v_random NUMBER (20) DEFAULT 0;
  BEGIN
    DBMS_OUTPUT.PUT_LINE(q'<<-- inner block starts here-->>');
    DBMS_OUTPUT.PUT_LINE(ROUND ( MONTHS_BETWEEN ( outer_block.v_my_date , TO_DATE(v_my_date,'DD-MM-YY') ) , 2));
    v_months := ROUND ( MONTHS_BETWEEN ( outer_block.v_my_date , TO_DATE(v_my_date,'DD-MM-YY') ) , 2);
    DBMS_OUTPUT.PUT_LINE(q'<Months without TRUNC() function: >' || v_months);
    v_months := TRUNC(v_months);
    DBMS_OUTPUT.PUT_LINE(q'<Months with TRUNC() function: >' || v_months);
    outer_block.v_random := DBMS_RANDOM.RANDOM/1000000000;
    DBMS_OUTPUT.PUT_LINE(q'<Random value: >' || outer_block.v_random);
    v_random := outer_block.v_random*v_months;
    DBMS_OUTPUT.PUT_LINE(q'<Random (random*months) value: >' || v_random);
    CASE WHEN v_random > 0 THEN
        DBMS_OUTPUT.PUT_LINE(q'<random (random*months) value >' || v_random || q'< is POSITIVE>');
      WHEN v_random = 0 THEN
        DBMS_OUTPUT.PUT_LINE(q'<random (random*months) value >' || v_random || q'< is ZERO>');
        DBMS_OUTPUT.PUT_LINE(q'<division by zero>');
        v_div_by_zero := 100 / v_div_by_zero;
      ELSE
        RAISE custume_exception;
        --DBMS_OUTPUT.PUT_LINE(q'<random (random*months) value >' || v_random || q'< is NEGATIVE>');
    END CASE;
    DBMS_OUTPUT.PUT_LINE(q'<<-- inner block ends here-->>');
  END;
  DBMS_OUTPUT.PUT_LINE(q'<<-- outer block ends here-->>');
  DBMS_OUTPUT.PUT_LINE(q'<<-- FINISHED SUCCESSFULLY-->>');
  EXCEPTION WHEN custume_exception THEN
    DBMS_OUTPUT.PUT_LINE(q'<<-- An unhandled exception was thrown due to an invalid negative number -->>');
    --DBMS_OUTPUT.PUT_LINE(q'<<-- exception was thrown -->>');
    --DBMS_OUTPUT.PUT_LINE('An error occured, code ' || SQLCODE || ', description' || SQLERRM);
END;

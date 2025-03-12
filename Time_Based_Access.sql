--1) create function 
CREATE OR REPLACE FUNCTION check_office_hours ( 
     p_schema VARCHAR2, 
     p_object VARCHAR2 
) 
RETURN VARCHAR2 
IS 
   current_time NUMBER; 
BEGIN 
      SELECT TO_NUMBER(TO_CHAR (SYSDATE, 'HH24')) INTO current_time 
FROM DUAL; 
 
    IF current_time BETWEEN 8 AND 17 THEN 
        -- Allow access (return NULL predicate) 
        RETURN NULL; 
    ELSE 
        -- Deny access (return a false predicate) 
        RETURN '1=0'; 
    END IF; 
EXCEPTION 
    WHEN OTHERS THEN 
        RETURN '1=0';  -- restrict access for any errors 
END check_office_hours; 
/
--------------------------------------------------------------
--2) Add policy function 
BEGIN 
    DBMS_RLS.ADD_POLICY( 
        object_schema   => 'HR', 
        object_name     => 'EMPLOYEES', 
        policy_name     => 'office_hours_policy', 
        policy_function => 'check_office_hours', 
        statement_types => 'SELECT' 
          ); 
END; 
/ 

--------------------------------------------------------------
--For test use the users I created before and run this command ti see the result 
SELECT * FROM HR.EMPLOYEES;

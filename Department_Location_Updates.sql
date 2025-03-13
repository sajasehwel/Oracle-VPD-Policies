--1)Create function  
CREATE OR REPLACE FUNCTION department_location_policy ( 
    p_schema VARCHAR2, 
    p_object VARCHAR2 
) RETURN VARCHAR2 
AS 
    v_condition   VARCHAR2(4000); 
    v_username    VARCHAR2(200); 
    v_emp_id      NUMBER; 
    v_job_id      VARCHAR2(10); 
BEGIN 
  -- Get the session username using SYS_CONTEXT 
    SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') INTO v_username FROM 
dual; 
             
  -- Get Employee details based on the username 
    BEGIN 
        SELECT EMPLOYEE_ID, JOB_ID 
        INTO v_emp_id, v_job_id 
        FROM HR.EMPLOYEES 
        WHERE LOWER(FIRST_NAME) = LOWER(v_username); 
     
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'Invalid user: ' || v_username); 
        WHEN OTHERS THEN 
            RAISE_APPLICATION_ERROR(-20002, 'An error occurred in the VPD function: ' 
|| SQLERRM); 
    END; 
 
    -- Apply Row-Level Security Conditions 
    IF v_job_id = 'HR_REP' THEN   
        -- HR Managers have full access 
        v_condition := ''; 
    ELSE 
        -- enables department managers to update only their department locations 
        v_condition := 'manager_id = ' || v_emp_id; 
       
    END IF; 
 
    RETURN v_condition; 
EXCEPTION 
 WHEN NO_DATA_FOUND THEN 
 RAISE_APPLICATION_ERROR(-20001, 'Invalid user: ' ||  
v_username); 
 WHEN OTHERS THEN 
 RAISE_APPLICATION_ERROR(-20002, 'An error occurred in  
the VPD policy function. ' || SQLERRM); 
END; 
/

--2)Add the policy  
BEGIN 
    dbms_rls.add_policy( 
        object_schema   => 'HR', 
        object_name     => 'DEPARTMENTS', 
        policy_name     => 'update_departments_policy', 
        policy_function => 'Department_Location_policy', 
        statement_types => 'UPDATE', 
        update_check    => TRUE 
    ); 
END; 
/ 
--3)Fot Testing-------------------------
--I Create user that is manager of Public Relation department 

GRANT CREATE SESSION, RESOURCE TO Hermann 
IDENTIFIED BY 123; 
 
grant select ,update on hr.departments to Hermann; 

--It will update one row 
update hr.departments set Location_id=2100;


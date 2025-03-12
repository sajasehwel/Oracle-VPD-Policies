--1) create FUNCTION Salary_Policy 
CREATE OR REPLACE FUNCTION Salary_Policy ( 
 p_schema IN VARCHAR2, 
 p_object IN VARCHAR2 
) RETURN VARCHAR2 AS 
 condition VARCHAR2(200); 
 v_username VARCHAR2(200); 
 v_emp_id  NUMBER; 
 v_job_id VARCHAR2(10); 
 
BEGIN  
 SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') INTO  
v_username FROM dual; 
 
 -- Get Employee details based on the username 
        SELECT EMPLOYEE_ID, JOB_ID 
        INTO v_emp_id, v_job_id 
        FROM HR.EMPLOYEES 
        WHERE LOWER(FIRST_NAME) = LOWER(v_username); -- Apply column-Level Security Conditions --allow for HR Managers and Financial Managers to view all data 
 IF v_job_id = 'FI_MGR' OR v_job_id = 'HR_REP' THEN 
 condition := ''; 
 ELSE  
 condition := 'EMPLOYEE_ID= ' || v_emp_id ; 
 END IF; 
 RETURN condition; 
EXCEPTION 
 WHEN NO_DATA_FOUND THEN 
 RAISE_APPLICATION_ERROR(-20001, 'Invalid user: ' ||  
v_username); 
 WHEN OTHERS THEN 
 RAISE_APPLICATION_ERROR(-20002, 'An error occurred in  
the VPD policy function. ' || SQLERRM); 
END; 
/ 
----------------------------------------------------------------------
2) add policy 
BEGIN 
DBMS_RLS.add_policy 
 (object_schema => 'HR', 
 object_name => 'employees', 
 policy_name => 'SALARY_CFCF', 
 policy_function => 'Salary_Policy', 
 statement_types => 'SELECT', 
 sec_relevant_cols => 'salary', 
 sec_relevant_cols_opt => DBMS_RLS.ALL_ROWS); 
END;
/
--Notice  that I add  sec_relevant_cols_opt => DBMS_RLS.ALL_ROWS 
--which means that we want “all rows” returned, but we want the policy to 
--filter or mask values at the column level 
----------------------------------------------------------------------
--For the test .. I use the same users I created before 

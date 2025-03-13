--1
CREATE CONTEXT hr_context USING hr_context_pkg;

--2
CREATE OR REPLACE PACKAGE hr_context_pkg AS
    PROCEDURE set_HR_context;

END hr_context_pkg;
/

--3
CREATE OR REPLACE PACKAGE BODY hr_context_pkg AS
 
    PROCEDURE set_HR_context AS
        v_job_id VARCHAR2(200);
        v_employee_id NUMBER;
        
    BEGIN
       
        SELECT
            job_id, employee_id
        INTO v_job_id,v_employee_id
        FROM
            HR.EMPLOYEES
        WHERE
            email = sys_context('USERENV', 'SESSION_USER');
    
        dbms_session.set_context('HR_CONTEXT', 'EMP_JOB_ID', v_job_id);
        dbms_session.set_context('HR_CONTEXT', 'EMP_ID', v_employee_id);
    EXCEPTION
        WHEN no_data_found THEN
            NULL;
    END set_HR_context;

 
END hr_context_pkg;
/

--4

CREATE OR REPLACE TRIGGER set_hr_context_on_login AFTER LOGON ON DATABASE BEGIN
    hr_context_pkg.set_HR_context;
    
END;

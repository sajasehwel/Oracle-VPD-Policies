
--1
create or replace FUNCTION POL_1_JOB_HIST_FUNC(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
   v_job_id  VARCHAR2(200);
  v_employee_id NUMBER(6,0);
   username VARCHAR2(200); 
BEGIN
    SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') INTO username FROM dual; 
    
   v_job_id :=sys_context ('HR_CONTEXT', 'EMP_JOB_ID');
  v_employee_id := SYS_CONTEXT('HR_CONTEXT', 'EMP_ID');
  
   IF   v_job_id = 'HR_REP' OR username = 'HR' THEN
    cond := '';
  
  ELSIF v_employee_id IS NOT NULL THEN
   cond := 'employee_id = ' || v_employee_id || ' OR employee_id IN ' ||
            '(SELECT employee_id FROM hr.employees WHERE manager_id = ' || v_employee_id || ')';
 
  ELSE
   cond := '1=0';
  END IF;

  RETURN cond;
END POL_1_JOB_HIST_FUNC;

/

--2
BEGIN
DBMS_RLS.ADD_POLICY(
      object_schema   => 'HR',
      object_name     => 'JOB_HISTORY',
      policy_name     => 'POL_1_JOB_HIST',
      policy_function => 'POL_1_JOB_HIST_FUNC',
      statement_types => 'SELECT, INDEX');
END;

/

--3
//HR_REP

GRANT CREATE SESSION, RESOURCE TO SMAVRIS
IDENTIFIED BY User123; 
//manager
GRANT CREATE SESSION, RESOURCE TO SKING
IDENTIFIED BY User123; 

//normal emp
GRANT CREATE SESSION, RESOURCE TO JWHALEN
IDENTIFIED BY User123; 

--4

grant select on HR.JOB_HISTORY to  SKING,JWHALEN,SMAVRIS;



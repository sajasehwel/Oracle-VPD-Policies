--For test -> create 2 users each of them has data in job_history 
--As SYS
--1)Neena user Its a manager
GRANT CREATE SESSION, RESOURCE TO Neena 
IDENTIFIED BY 123; 
 
grant select on hr.job_history to Neena; 

--2)Jonathon user
GRANT CREATE SESSION, RESOURCE TO Jonathon 
IDENTIFIED BY 123; 
 
grant select on hr.job_history to Jonathon; 

--3)Susan user with job_id= 'HR_REP' that means she has access for all records 

GRANT CREATE SESSION, RESOURCE TO Susan 
IDENTIFIED BY 123; 
 
grant select on hr.job_history to Susan; 

--Now connect to each user and try to select from hr.job_history table and see the result:)

# Oracle-VPD-Policies

What is Virtual Private Database (VPD)?
Oracle's Virtual Private Database (VPD) is a security feature that allows fine-grained access control at the row and column levels. It dynamically modifies SQL queries to enforce security policies based on user credentials, ensuring that users only see or modify the data they are authorized to access.

Types of VPD Policies in Oracle

🔹 Row-Level Security (RLS): Controls which rows a user can see or modify based on conditions.

🔹 Column-Level Security: Masks or restricts access to specific columns for unauthorized users.

🔹 Time-Based Access Control: Restricts access to data based on specific time conditions.

🔹 Operation-Specific Policies: Applies security policies only to specific operations like SELECT, UPDATE, DELETE, etc.

Overview

This project demonstrates the implementation of Virtual Private Database (VPD) policies in an Oracle Database. The VPD mechanism enhances row-level and column-level security by dynamically applying security conditions to SQL queries.

Features

🔹 Job History Access Control -(Table Fire with Row Filter Policy): Restricts employees to view only their job history or  the job history 
    of their managed employees unless they have HR privileges.
🔹 Salary Data Protection -(Column Fire with Column Filter): This column-level policy allows employees to access their own data inside 
   EMPLOYEES table, including salary information, as well as the data of other employees, with the exception of salary information, while 
   granting full access to HR Managers and Financial Managers to view.
  all data including salaries of all employees.
🔹 Time-Based Access Control - Allows access to employee data only during office hours.
🔹 Department Location Updates - (Table Fire with Row Filter Policy): For the DEPARTMENTS table, this row-level policy enables department managers to update only their department locations (LOCATION_ID column), while granting HR Managers the ability to update all records.  

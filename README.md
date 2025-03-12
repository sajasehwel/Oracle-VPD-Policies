# Oracle-VPD-Policies

## What is Virtual Private Database (VPD)?

Oracle's **Virtual Private Database (VPD)** is a security feature that allows fine-grained access control at the row and column levels. It dynamically modifies SQL queries to enforce security policies based on user credentials, ensuring that users only see or modify the data they are authorized to access.

### **Types of VPD Policies in Oracle**
1. **Row-Level Security (RLS)**: Controls which rows a user can see or modify based on conditions.
2. **Column-Level Security**: Masks or restricts access to specific columns for unauthorized users.
3. **Time-Based Access Control**: Restricts access to data based on specific time conditions.
4. **Operation-Specific Policies**: Applies security policies only to specific operations like SELECT, UPDATE, DELETE, etc.

## Overview

This project demonstrates the implementation of **Virtual Private Database (VPD)** policies in an **Oracle Database**. The VPD mechanism enhances **row-level and column-level security** by dynamically applying security conditions to SQL queries.

## Features

🔹 **Job History Access Control** - (Table Fire with Row Filter Policy): Restricts employees to view only their job history or  the job history .\
🔹 **Salary Data Protection** - (Column Fire with Column Filter): This column-level policy allows employees to access their own data inside EMPLOYEES table, including salary information, as well as the data of other employees, with the exception of salary information, while granting full access to HR Managers and Financial Managers to view. all data including salaries of all employees..\
🔹 **Time-Based Access Control** - Allows access to employee data only during office hours.\
🔹 **Department Location Updates** - (Table Fire with Row Filter Policy): For the DEPARTMENTS table, this row-level policy enables department managers to update only their department locations (LOCATION_ID column), while granting HR Managers the ability to update all records.  

## Folder Structure

```
📂 VPD-Implementation
│── 📜 README.md                # Project documentation
│── 📜 1_Job_History_Access.sql  # Row-level security for job history
│── 📜 2_Salary_Policy.sql       # Column-level security for salary
│── 📜 3_Time_Based_Access.sql   # Restricting access to work hours
│── 📜 4_Department_Location_Updates.sql  # Restrict updates to managers
│── 📜 test_users_setup.sql      # Creating test users for validation
```

## Installation & Setup

### Prerequisites

- Oracle Database (12c or later recommended)
- SQL\*Plus or any Oracle SQL Client
- HR Schema with sample data

### Steps to Run

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/VPD-Implementation.git
   cd VPD-Implementation
   ```
2. **Connect to Oracle Database:**
   ```sql
   sqlplus sys/password@localhost as sysdba
   ```
3. **Run the scripts in order:**
   ```sql
   @test_users_setup.sql
   @1_Job_History_Access.sql
   @2_Salary_Policy.sql
   @3_Time_Based_Access.sql
   @4_Department_Location_Updates.sql
   ```
4. **Test with different users and permissions.**

## Testing

Create test users and check access permissions:

```sql
GRANT CREATE SESSION, RESOURCE TO Neena IDENTIFIED BY 123;
GRANT SELECT ON HR.JOB_HISTORY TO Neena;
```

Try running queries as different users to verify access restrictions.


## Author
👤 **Saja Sehweil**


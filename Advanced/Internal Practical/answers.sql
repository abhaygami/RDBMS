-- Tables:
-- 1. DEPARTMENT (DEPTID, DEPTNAME)

CREATE TABLE DEPARTMENT(
    DEPTID INTEGER PRIMARY KEY,
    DEPTNAME VARCHAR2(50)
);

INSERT ALL
    INTO DEPARTMENT (DEPTID, DEPTNAME) VALUES (1, 'Human Resource')
    INTO DEPARTMENT (DEPTID, DEPTNAME) VALUES (2, 'Finance')
    INTO DEPARTMENT (DEPTID, DEPTNAME) VALUES (3, 'IT')
    INTO DEPARTMENT (DEPTID, DEPTNAME) VALUES (4, 'Marketing')
    INTO DEPARTMENT (DEPTID, DEPTNAME) VALUES (5, 'Operations')
SELECT * FROM DUAL;

-- 2. EMPLOYEE (EMPID, EMPNAME, DEPTID, SALARY)

CREATE TABLE EMPLOYEE (
    EMPID INTEGER PRIMARY KEY,
    EMPNAME VARCHAR2(50),
    DEPTID INTEGER,
    SALARY INTEGER,
    FOREIGN KEY (DEPTID) REFERENCES DEPARTMENT(DEPTID)
);

INSERT ALL
    INTO EMPLOYEE (EMPID, EMPNAME, DEPTID, SALARY) VALUES (101, 'Rohit Sharma', 3, 55000)
    INTO EMPLOYEE (EMPID, EMPNAME, DEPTID, SALARY) VALUES (102, 'Virat Kohli', 2, 60000)
    INTO EMPLOYEE (EMPID, EMPNAME, DEPTID, SALARY) VALUES (103, 'Hardik Pandya', 3, 52000)
    INTO EMPLOYEE (EMPID, EMPNAME, DEPTID, SALARY) VALUES (104, 'KL Rahul', 1, 45000)
    INTO EMPLOYEE (EMPID, EMPNAME, DEPTID, SALARY) VALUES (105, 'Shubman Gill', 4, 48000)
SELECT * FROM DUAL;

-- 3. CREATE TABLE PROJECT (PROJECTID, PROJECTNAME, DEPTID, BUDGET)

CREATE TABLE PROJECT (
    PROJECTID INTEGER PRIMARY KEY,
    PROJECTNAME VARCHAR2(50),
    DEPTID INTEGER,
    BUDGET INTEGER,
    FOREIGN KEY (DEPTID) REFERENCES DEPARTMENT(DEPTID)
);

INSERT ALL
    INTO PROJECT (PROJECTID, PROJECTNAME, DEPTID, BUDGET) VALUES (201, 'Website Upgrade', 3, 200000)
    INTO PROJECT (PROJECTID, PROJECTNAME, DEPTID, BUDGET) VALUES (202, 'Payroll Automation', 2, 150000)
    INTO PROJECT (PROJECTID, PROJECTNAME, DEPTID, BUDGET) VALUES (203, 'Employee Training Program', 1, 80000)
    INTO PROJECT (PROJECTID, PROJECTNAME, DEPTID, BUDGET) VALUES (204, 'Marketing Campaign', 4, 120000)
    INTO PROJECT (PROJECTID, PROJECTNAME, DEPTID, BUDGET) VALUES (205, 'Inventory Optimization', 5, 100000)
SELECT * FROM DUAL;

-- 4. CREATE TABLE ASSIGMENT (ASSIGNID, EMPID, PROJECTID, HOURSWORKED)

CREATE TABLE ASSIGMENT (
    ASSIGNID INTEGER PRIMARY KEY,
    EMPID INTEGER,
    PROJECTID INTEGER,
    HOURSWORKED INTEGER,
    FOREIGN KEY (EMPID) REFERENCES EMPLOYEE(EMPID),
    FOREIGN KEY (PROJECTID) REFERENCES PROJECT(PROJECTID)
);

-- Questions:
-- Q1:
-- Write a PL/SQL procedure named assign_employee_to_project which takes three inputs: empid
-- (Employee ID), projectid (Project ID), hoursworked (Number of hours worked).
-- The procedure should:
-- ➢ Check if the given employee (empid) exists in the employee table. If not, raise a user-defined
-- exception “employee_not_found”.
-- ➢ Check if the given project (projectid) exists in the project table. If not, raise a user-defined
-- exception “project_not_found”.
-- If both exist, insert a record into the assignment table.
-- ➢ The assignid should be auto-generated using a sequence (say seq_assign).
-- ➢ Display a success message when the record is inserted successfully.

--Sequence for assignId 
CREATE SEQUENCE seq_assign
START WITH 1000
INCREMENT BY 1
MINVALUE 1000
MAXVALUE 2000
NOCYCLE
NOCACHE;


CREATE OR REPLACE PROCEDURE assign_employee_to_project (
    VEMPID EMPLOYEE.EMPID%TYPE,
    VPROJECTID PROJECT.PROJECTID%TYPE,
    VHOURSWORKED ASSIGMENT.HOURSWORKED%TYPE
)
AS 
    emp_not_found EXCEPTION;
    proj_not_found EXCEPTION;
    VCOUNTEMP NUMBER;
    VCOUNTPROJ NUMBER; 
BEGIN
    -- Checks total no. of Employee
    SELECT COUNT(*) INTO VCOUNTEMP FROM EMPLOYEE WHERE EMPID = VEMPID;

    -- Checks total no. of Projects
    SELECT COUNT(*) INTO VCOUNTPROJ FROM PROJECT WHERE PROJECTID = VPROJECTID;

    IF VCOUNTEMP = 0 THEN 
        RAISE emp_not_found; --Employee Not Found
    END IF;

    IF VCOUNTPROJ = 0 THEN
        RAISE proj_not_found; --Projrct not Found
    END IF;

    INSERT INTO ASSIGMENT VALUES (seq_assign.NEXTVAL, VEMPID, VPROJECTID, VHOURSWORKED);
    DBMS_OUTPUT.PUT_LINE('Assignment assigned');
    COMMIT;

EXCEPTION
    WHEN emp_not_found THEN 
        DBMS_OUTPUT.PUT_LINE('Employee not found!');
    
    WHEN proj_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Project not found!');
END;

-- Calling

BEGIN
    assign_employee_to_project(201,301,50);
END;


-- Q2:
-- Create a procedure that will take deptid and percentage as input that includes
-- ➢ Employees which are working in that department will get increment in their salary by that
-- much of percentage
-- ➢ If increased salary is greater than 100000 then raise exception and rollback one step

CREATE OR REPLACE PROCEDURE increment_salary (
    VDEPTID DEPARTMENT.DEPTID%TYPE,
    VPER NUMBER
)
AS
    CURSOR C1 IS SELECT EMPID, SALARY FROM EMPLOYEE WHERE DEPTID = VDEPTID;
    -- Gets Employee whose working in given department

    salary_limit EXCEPTION;
    -- User Defined Exception

    NEWSAL NUMBER;
BEGIN
    FOR EMP IN C1 LOOP
        NEWSAL := EMP.SALARY + (EMP.SALARY * VPER)/100;
        -- Increased salary

        IF NEWSAL > 100000 THEN -- Checks limit(100000)
            RAISE salary_limit;
        END IF;

        UPDATE EMPLOYEE 
        SET SALARY = NEWSAL
        WHERE EMPID = EMP.EMPID;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN salary_limit THEN 
        DBMS_OUTPUT.PUT_LINE('Salary Limit Reached');
        ROLLBACK;
END;

-- Calling

BEGIN
    increment_salary(3,82);
END;

-- Q3:
-- Create procedure which takes departname as input and it should display the employees of that department with salary and also display the projects of that department

CREATE OR REPLACE PROCEDURE display_dept_details (
    VDEPTNAME DEPARTMENT.DEPTNAME%TYPE
)
AS
    CURSOR C1 IS SELECT EMPNAME, SALARY FROM EMPLOYEE WHERE DEPTID IN (
        SELECT DEPTID FROM DEPARTMENT WHERE DEPTNAME = VDEPTNAME
    );
    -- Gets Employee details

    CURSOR C2 IS SELECT PROJECTNAME, BUDGET FROM PROJECT WHERE DEPTID IN (
        SELECT DEPTID FROM DEPARTMENT WHERE DEPTNAME = VDEPTNAME
    );
    -- Gets Student Details

    VEMPCOUNT NUMBER := 0;
    VPROJCOUNT NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Employees : ');
    FOR EMP IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE('Name : '|| EMP.EMPNAME || ' Salary : ' || EMP.SALARY);
        VEMPCOUNT := VEMPCOUNT + 1; --Increase total no. of employee
    END LOOP;

    IF VEMPCOUNT = 0 THEN  --No Employee found
        DBMS_OUTPUT.PUT_LINE('No Employee Found!');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Projects : ');
    FOR PROJ IN C2 LOOP
        DBMS_OUTPUT.PUT_LINE('Title : ' || PROJ.PROJECTNAME || 'Budget : ' || PROJ.BUDGET);
        VPROJCOUNT := VPROJCOUNT + 1;
    END LOOP;

    IF VPROJCOUNT = 0 THEN --No Project Found
        DBMS_OUTPUT.PUT_LINE('No Project Found!');
    END IF;
END;

-- Calling

BEGIN
    display_dept_details('Operations');
END;

-- Q4.
-- Write a PL/SQL procedure transfer_employee that takes empid, new_deptid as input.
-- The procedure should:
-- 1. Check whether the employee exists.
-- o If not, raise exception emp_not_found.
-- 2. Check whether the new department exists.
-- o If not, raise exception dept_not_found.
-- 3. Update the employee's department.
-- 4. Insert a record into a table emp_transfer_log with:
-- o transfer_id (auto-generated using a sequence seq_transfer)
-- o empid
-- o old_deptid
-- o new_deptid
-- o transfer_date
-- 5. Display a success message.

CREATE SEQUENCE seq_transfer
START WITH 100
INCREMENT BY 1
MINVALUE 100
MAXVALUE 1000
NOCYCLE
NOCACHE;

CREATE OR REPLACE PROCEDURE transfer_employee (
    VEMPID EMPLOYEE.EMPID%TYPE,
    VNEWDEPTID EMPLOYEE.DEPTID%TYPE
)
AS
    VOLDEPTID EMPLOYEE.DEPTID%TYPE;
    emp_not_found EXCEPTION;
    dept_not_found EXCEPTION;
    VEMPCOUNT NUMBER;
    VDEPTCOUNT NUMBER;
BEGIN
   

    SELECT COUNT(*) INTO VDEPTCOUNT
    FROM DEPARTMENT WHERE DEPTID = VNEWDEPTID;

    IF VDEPTCOUNT = 0 THEN 
        RAISE dept_not_found;
    END IF;

    SELECT COUNT(*) INTO VEMPCOUNT
    FROM EMPLOYEE WHERE EMPID = VEMPID;

    IF VEMPCOUNT = 0 THEN 
        RAISE emp_not_found;
    END IF;

    SELECT DEPTID INTO VOLDEPTID
    FROM EMPLOYEE
    WHERE EMPID = VEMPID;

    UPDATE EMPLOYEE
    SET DEPTID = VNEWDEPTID
    WHERE EMPID = VEMPID;

    INSERT INTO emp_transfer_log VALUES (seq_transfer.NEXTVAL, VEMPID, VOLDEPTID, VNEWDEPTID, SYSDATE);

    DBMS_OUTPUT.PUT_LINE('Updation Done!');
EXCEPTION
    WHEN emp_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Emloyee Not Found');

    WHEN dept_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Department Not Found');
END;

-- Calling

BEGIN
    transfer_employee(101,1);
END;

-- Q2.
-- Write a PL/SQL procedure update_project_budget that takes projectid,
-- increment_percent.
-- 1. Check if project exists.
-- 2. Calculate new budget = old budget + (old budget * percentage/100).
-- 3. If new budget exceeds 5,00,00,000, raise exception budget_limit_exceeded.
-- 4. If no exception, update the project table.
-- 5. Use SAVEPOINT before update; rollback only this update if exception occurs.

CREATE OR REPLACE PROCEDURE update_project_budget (
    VPROJECTID PROJECT.PROJECTID%TYPE,
    VPER NUMBER
)
AS 
    VNEWBUDGET PROJECT.BUDGET%TYPE;
    budget_limit_exceeded EXCEPTION;
    proj_not_found EXCEPTION;
    VPROJCOUNT NUMBER;

BEGIN
    SELECT COUNT(*) INTO VPROJCOUNT
    FROM PROJECT WHERE PROJECTID = VPROJECTID;

    IF VPROJCOUNT = 0 THEN
        RAISE proj_not_found;
    END IF;

    SELECT (BUDGET + (BUDGET*VPER/100)) INTO VNEWBUDGET 
    FROM PROJECT
    WHERE PROJECTID = VPROJECTID;

    SAVEPOINT A;

    UPDATE PROJECT
    SET BUDGET = VNEWBUDGET
    WHERE PROJECTID = VPROJECTID;

    IF VNEWBUDGET > 50000000 THEN 
        RAISE budget_limit_exceeded;
    END IF;
    COMMIT;
EXCEPTION
    WHEN proj_not_found THEN
        DBMS_OUTPUT.PUT_LINE('PROJECT NOT FOUND');

    WHEN budget_limit_exceeded THEN
        DBMS_OUTPUT.PUT_LINE('BUDGET EXCEED');
        ROLLBACK TO A;
END;


-- Q3.
-- Create a BEFORE INSERT trigger check_salary_trigger on EMPLOYEE.
-- Trigger should:
-- 1. Check if salary > 2,00,000 then raise exception excess_salary_error.
-- 2. Check if deptid exists, if not raise invalid_department_error.
-- 3. Automatically convert employee name to Proper Case (first letter capital, rest
-- lowercase

CREATE TRIGGER check_salary_trigger
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
AS
    excess_salary_error EXCEPTION;
    invalid_department_error EXCEPTION;
    VCOUNTDEPT NUMBER;
BEGIN
    IF :NEW.SALARY > 200000 THEN 
        RAISE excess_salary_error;
    END IF;

    SELECT COUNT(*) INTO VCOUNTDEPT
    FROM DEPARTMENT WHERE DEPTID = :NEW.DEPTID;

    IF VCOUNTDEPT = 0 THEN
        RAISE invalid_department_error;
    END IF;

    :NEW.EMPNAME := INITCAP(:NEW.EMPNAME);
EXCEPTION
    WHEN excess_salary_error THEN
        RAISE_APPLICATION_ERROR(-20002,'Salary Limit exceed');

    WHEN invalid_department_error THEN
        RAISE_APPLICATION_ERROR(-20001,'Department not found');
END;
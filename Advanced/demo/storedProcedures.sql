-- Stored Procedure for insert query

    CREATE OR REPLACE PROCEDURE CourseInsert
    (VCOURSEID COURSE.COURSEID%TYPE,VCOURSENAME COURSE.COURSENAME%TYPE)

    AS
        BEGIN
            INSERT INTO COURSE VALUES (VCOURSEID,VCOURSENAME);
        END;

    -- Calling
        BEGIN
            CourseInsert(7,'MSCIT');
        END;


-- Stored Procedure for delete query

    CREATE OR REPLACE PROCEDURE CourseDelete
    (VCOURSEID COURSE.COURSEID%TYPE)
    AS
        BEGIN
            DELETE FROM COURSE
            WHERE COURSEID = VCOURSEID;
        END;

    -- Calling
        BEGIN
            CourseDelete(7);
        END;

-- Create Procedure to count total number of pass and failed student from STUDRESULT
    
    CREATE OR REPLACE PROCEDURE CountFailPass
    (VPASS OUT NUMBER,VFAIL OUT NUMBER)
    AS
        BEGIN
            SELECT COUNT(*) INTO VPASS
            FROM STUDRESULT
            WHERE GRADE != 'F';

            SELECT COUNT(*) INTO VFAIL
            FROM STUDRESULT
            WHERE GRADE = 'F';
        END;

    --Calling
        DECLARE
            VPASS NUMBER;
            VFAIL NUMBER;
        BEGIN
            CountFailPass(VPASS,VFAIL);

            DBMS_OUTPUT.PUT_LINE('Pass : '||VPASS);
            DBMS_OUTPUT.PUT_LINE('Fail : '||VFAIL);
        END;

-- Create Procedure name and rollno of all student coursename wise

    CREATE OR REPLACE PROCEDURE displayCouseWise
    (VCOURSENAME COURSE.COURSENAME%TYPE)
    AS
    CURSOR coursorToDisplayCourseNameWise IS 
        SELECT ROLLNO,NAME 
        FROM STUDRESULT
        WHERE COURSEID IN (
            SELECT COURSEID
            FROM COURSE
            WHERE COURSENAME = VCOURSENAME
            ); 
    BEGIN
        FOR STUDRECS IN coursorToDisplayCourseNameWise LOOP
            DBMS_OUTPUT.PUT_LINE(STUDRECS.ROLLNO||' '||STUDRECS.NAME);
        END LOOP;
    END;

    -- Calling 
        BEGIN
            displayCouseWise('BSCIT');
        END;

-- Create Procedure to take rollno and display that student's result

    CREATE OR REPLACE PROCEDURE displayResultOfPerticularStud
    (VROLLNO STUDRESULT.ROLLNO%TYPE,VSTUDREC OUT STUDRESULT%ROWTYPE)
    AS 
    BEGIN
        SELECT * INTO VSTUDREC
        FROM STUDRESULT
        WHERE ROLLNO = VROLLNO;
    END;

    -- Calling
        DECLARE 
            VSTUDREC STUDRESULT%ROWTYPE;

        BEGIN
            displayResultOfPerticularStud(32,VSTUDREC);

            DBMS_OUTPUT.PUT_LINE('RollNo : '||VSTUDREC.ROLLNO);
            DBMS_OUTPUT.PUT_LINE('Name : '||VSTUDREC.NAME);
            DBMS_OUTPUT.PUT_LINE('CourseID : '||VSTUDREC.COURSEID);
            DBMS_OUTPUT.PUT_LINE('Per : '||VSTUDREC.PER);
            DBMS_OUTPUT.PUT_LINE('Grade : '||VSTUDREC.GRADE);
        END;

-- Create Procedure that will give passing marks to all student in sub1 who get marks between perticular range

CREATE OR REPLACE PROCEDURE givePassingMarks
(VPASSING STUDRESULT.SUB1MARKS%TYPE,VSTART STUDRESULT.SUB1MARKS%TYPE,VEND STUDRESULT.SUB1MARKS%TYPE)
AS 
BEGIN
    UPDATE STUDRESULT
    SET SUB1MARKS = VPASSING
    WHERE SUB1MARKS >= VSTART AND SUB2MARKS <= VEND;
END;

-- Calling
    DECLARE
        PASSING NUMBER := 36;
        RANGESTART NUMBER := 27;
        RANGEEND NUMBER := 35;
    BEGIN
        givePassingMarks(PASSING,RANGESTART,RANGEEND);
    END; 
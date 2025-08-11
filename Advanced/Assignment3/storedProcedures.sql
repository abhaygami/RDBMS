-- 2) Create 3 different stored procedure to perform INSERT, UPDATE and DELETE operation on Patient Master table.
    -- Procedure for Insertion 
        CREATE OR REPLACE PROCEDURE insertPatientMaster
        (
            VPATIENTID PATIENTMASTER.PATIENTID%TYPE,
            VPATIENTNAME PATIENTMASTER.PATIENTNAME%TYPE,
            VCATEGORYID PATIENTMASTER.CATEGORYID%TYPE,
            VWARDID PATIENTMASTER.WARDID%TYPE,
            VADMITTEDDATE PATIENTMASTER.ADMITTEDDATE%TYPE,
            VDISCHARGEDDATE PATIENTMASTER.DISCHARGEDDATE%TYPE
        )
        AS
        BEGIN
            INSERT INTO PATIENTMASTER VALUES (VPATIENTID,VPATIENTNAME,VCATEGORYID,VWARDID,VADMITTEDDATE,VDISCHARGEDDATE);
        END;

    -- Calling
        BEGIN
            insertPatientMaster(23,'HATHI',2,1,'09-AUG-2025',NULL);
        END;

    -- Procedure for Update
        CREATE OR REPLACE PROCEDURE updatePatientMaster
        (
            VPATIENTID PATIENTMASTER.PATIENTID%TYPE,
            VDISCHARGEDDATE PATIENTMASTER.DISCHARGEDDATE%TYPE
        )
        AS
        BEGIN
            UPDATE PATIENTMASTER
            SET DISCHARGEDDATE = VDISCHARGEDDATE
            WHERE PATIENTID = VPATIENTID;
        END;

    -- Calling
        BEGIN
            updatePatientMaster(23,'11-AUG-2025');
        END;
    
    -- Procedure for Deletion
        CREATE OR REPLACE PROCEDURE deletePatientMaster
        (VPATIENTID PATIENTMASTER.PATIENTID%TYPE)
        AS 
        BEGIN 
            DELETE FROM PATIENTMASTER
            WHERE PATIENTID = VPATIENTID;
        END;

    -- Calling
        BEGIN
            deletePatientMaster(23);
        END;

-- 3) Create stored procedure to count total number patient in a particular Zone NAME.For example GetZoneCount('ATHWA')

    CREATE OR REPLACE PROCEDURE GetZoneCount
    (VZONENAME ZONE.ZONENAME%TYPE)
    AS
        VCOUNT NUMBER; 
    BEGIN
        SELECT COUNT(*) 
        INTO VCOUNT
        FROM PATIENTMASTER
        WHERE WARDID IN (
            SELECT WARDID
            FROM WARD
            WHERE ZONEID IN (
                SELECT ZONEID
                FROM ZONE
                WHERE ZONENAME = VZONENAME
            )
        );
        DBMS_OUTPUT.PUT_LINE('Total Count : ' || VCOUNT);
    END;

    -- Calling
        BEGIN
            GetZoneCount('ATHWA');
        END;

-- 4) Create stored procedure to count total number patient in a particular WARD NAME. For example GetWardCount('BHATAR')

    CREATE OR REPLACE PROCEDURE GetWardCount
    (VWARDNAME WARD.WARDNAME%TYPE)
    AS
        VCOUNT NUMBER; 
    BEGIN
        SELECT COUNT(*) 
        INTO VCOUNT
        FROM PATIENTMASTER
        WHERE WARDID IN (
            SELECT WARDID
            FROM WARD
            WHERE WARDNAME = VWARDNAME
        );
        DBMS_OUTPUT.PUT_LINE('Total Count : ' || VCOUNT);
    END;

    -- Calling
        BEGIN
            GetWardCount('BHATAR');
        END;
    
-- 5) Create stored procedure to get list of patient admitted on a specific date. For example getPatientList('1-JAN-2021')

    CREATE OR REPLACE PROCEDURE getPatientList
    (VADMITTEDDATE PATIENTMASTER.ADMITTEDDATE%TYPE)
    AS
        CURSOR list IS SELECT * FROM PATIENTMASTER WHERE ADMITTEDDATE = VADMITTEDDATE;
    BEGIN
        FOR REC IN list LOOP
            DBMS_OUTPUT.PUT_LINE(REC.PATIENTNAME||' '||REC.ADMITTEDDATE);
        END LOOP;
    END;

    -- Calling
        BEGIN 
            getPatientList('09-AUG-2025');
        END;
    
-- 6) Display the list of Patient admitted with a particular category. For example getPatientListbyCategory(’Critical on Ventilator’)

    CREATE OR REPLACE PROCEDURE getPatientListbyCategory
    (VCATEGORYNAME PATIENTCATEGORYMASTER.CATEGORYNAME%TYPE)
    AS
        CURSOR list IS SELECT * FROM PATIENTMASTER WHERE CATEGORYID IN (
            SELECT CATEGORYID
            FROM PATIENTCATEGORYMASTER
            WHERE CATEGORYNAME = VCATEGORYNAME
        );
    BEGIN
        FOR REC IN list LOOP
            DBMS_OUTPUT.PUT_LINE(REC.PATIENTNAME||' '||REC.CATEGORYID);
        END LOOP;
    END;

    -- Calling
        BEGIN
            getPatientListbyCategory('CRITICAL');
        END;

-- 7) Create stored procedure that will display list of patient for a particular admitted and discharge dates. SpDateRange(01-06-2024,12-06-2024);

    CREATE OR REPLACE PROCEDURE SpDateRange
    (
        VADMITTEDDATE PATIENTMASTER.ADMITTEDDATE%TYPE,
        VDISCHARGEDDATE PATIENTMASTER.DISCHARGEDDATE%TYPE
    )
    AS 
        CURSOR list IS SELECT * FROM PATIENTMASTER WHERE ADMITTEDDATE = VADMITTEDDATE AND DISCHARGEDDATE = VDISCHARGEDDATE;
    BEGIN
        FOR REC IN list LOOP
            DBMS_OUTPUT.PUT_LINE(REC.PATIENTNAME||' '||REC.ADMITTEDDATE||' '||REC.DISCHARGEDDATE);
        END LOOP;
    END;

    -- Calling
        BEGIN
            SpDateRange('10-JUN-2025', '20-JUN-2025');
        END;

-- 8) Create a stored procedure that will display count of total patient admitted of a particular category name. spCountCategoryName(‘Critical’);

    CREATE OR REPLACE PROCEDURE spCountCategoryName
    (VCATEGORYNAME PATIENTCATEGORYMASTER.CATEGORYNAME%TYPE)
    AS
        VCOUNT NUMBER; 
    BEGIN
        SELECT COUNT(*) 
        INTO VCOUNT
        FROM PATIENTMASTER
        WHERE CATEGORYID IN (
            SELECT CATEGORYID
            FROM PATIENTCATEGORYMASTER
            WHERE CATEGORYNAME = VCATEGORYNAME
        );
        DBMS_OUTPUT.PUT_LINE('Total Count : ' || VCOUNT);
    END;

    -- Calling

    BEGIN 
        spCountCategoryName('CRITICAL');
    END;

-- 9) Create a stored procedure that will display count of total patient who were admitted on a particular date and category name. spCountCategoryNameandDate(‘Critical’, 01-06-2024);

    CREATE OR REPLACE PROCEDURE spCountCategoryNameandDate
    (
        VCATEGORYNAME PATIENTCATEGORYMASTER.CATEGORYNAME%TYPE,
        VADMITTEDDATE PATIENTMASTER.ADMITTEDDATE%TYPE
    )
    AS
        VCOUNT NUMBER; 
    BEGIN
        SELECT COUNT(*) 
        INTO VCOUNT
        FROM PATIENTMASTER
        WHERE ADMITTEDDATE = VADMITTEDDATE AND CATEGORYID IN (
            SELECT CATEGORYID
            FROM PATIENTCATEGORYMASTER
            WHERE CATEGORYNAME = VCATEGORYNAME
        );
        DBMS_OUTPUT.PUT_LINE('Total Count : ' || VCOUNT);
    END;

    -- Calling

    BEGIN 
        spCountCategoryNameandDate('CRITICAL','01-AUG-2025');
    END;

-- 10) Create a stored procedure that will will display list of patient details who are not discharged yet since a specified Admitted date. SpNotDischargedbyAdmDate(01-06-2024);

    CREATE OR REPLACE PROCEDURE SpNotDischargedbyAdmDate
    (VADMITTEDDATE PATIENTMASTER.ADMITTEDDATE%TYPE)
    AS
        CURSOR list IS SELECT * FROM PATIENTMASTER WHERE ADMITTEDDATE = VADMITTEDDATE AND DISCHARGEDDATE IS NULL;
    BEGIN
        FOR REC IN list LOOP
            DBMS_OUTPUT.PUT_LINE(REC.PATIENTNAME||' '||REC.ADMITTEDDATE);
        END LOOP;
    END;

    -- Calling
        BEGIN 
            SpNotDischargedbyAdmDate('09-AUG-2025');
        END;

-- 11) Create a stored procedure that will take ZoneName as an input and display list of patient who are not discharged yet. SpNotDischargedbyZoneName(‘ATHWA’);

    CREATE OR REPLACE PROCEDURE SpNotDischargedbyZoneName
    (VZONENAME ZONE.ZONENAME%TYPE)
    AS
        CURSOR list IS SELECT * FROM PATIENTMASTER WHERE DISCHARGEDDATE IS NULL AND WARDID IN (
            SELECT WARDID
            FROM WARD
            WHERE ZONEID IN (
                SELECT ZONEID
                FROM ZONE
                WHERE ZONENAME = VZONENAME
            )
        );
    BEGIN
        FOR REC IN list LOOP
            DBMS_OUTPUT.PUT_LINE(REC.PATIENTNAME);
        END LOOP;
    END;

    -- Calling
        BEGIN
            SpNotDischargedbyZoneName('ATHWA');
        END;

-- 12) Create a stored procedure that will take ZoneName and Admitted Date as an input and display list of patient who are not discharged yet. SpNotDischargedbyZNandDate(‘ATHWA’, 01-06-2024);

    CREATE OR REPLACE PROCEDURE SpNotDischargedbyZNandDate
    (
        VZONENAME ZONE.ZONENAME%TYPE,
        VADMITTEDDATE PATIENTMASTER.ADMITTEDDATE%TYPE
    )
    AS
        CURSOR list IS SELECT * FROM PATIENTMASTER WHERE ADMITTEDDATE = VADMITTEDDATE AND DISCHARGEDDATE IS NULL AND WARDID IN (
            SELECT WARDID
            FROM WARD
            WHERE ZONEID IN (
                SELECT ZONEID
                FROM ZONE
                WHERE ZONENAME = VZONENAME
            )
        );
    BEGIN
        FOR REC IN list LOOP
            DBMS_OUTPUT.PUT_LINE(REC.PATIENTNAME);
        END LOOP;
    END;

    -- Calling
        BEGIN
            SpNotDischargedbyZNandDate('ATHWA','25-JUL-2025');
        END;

-- 13) Create a stored procedure that will take WardName as an input and display list of patient whe are not discharged yet. SpNotDischargedbyWardName(‘GHOD DOD’);

    CREATE OR REPLACE PROCEDURE SpNotDischargedbyWardName
    (VWARDNAME WARD.WARDNAME%TYPE)
    AS
        CURSOR list IS SELECT * FROM PATIENTMASTER WHERE DISCHARGEDDATE IS NULL AND WARDID IN (
            SELECT WARDID
            FROM WARD
            WHERE WARDNAME = VWARDNAME
        );
    BEGIN
        FOR REC IN list LOOP
            DBMS_OUTPUT.PUT_LINE(REC.PATIENTNAME);
        END LOOP;
    END;

    -- Calling
        BEGIN
            SpNotDischargedbyWardName('GHOD DOD');
        END;
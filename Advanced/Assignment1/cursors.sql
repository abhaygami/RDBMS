-- *Q02
    -- Write a PL/SQL program that will load data from StudentMaster Table into StudentScholarship Table.
    -- Following criteria should be considered for data loading

    -- All SC category students
    -- All ST category students
    -- Female SEBC students

    -- System date should be considered/used for Year field.

    DECLARE
        CURSOR transferToSco IS 
            SELECT * 
            FROM StudentMaster
            WHERE Category = 'SC' OR Category = 'ST' OR (Category = 'SEBC' AND Gender = 'FEMALE');

    BEGIN
        FOR REC IN transferToSco
        LOOP
            INSERT INTO StudentScholarship VALUES (REC.StudentID,EXTRACT(YEAR FROM SYSDATE),REC.Category);
        END LOOP;
    END;
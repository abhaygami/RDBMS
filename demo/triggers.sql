-- 1.   Create Trigger to calculate Percentage and Grade based on marks when data is inserted into the table 

    CREATE OR REPLACE TRIGGER calPerGrade
    BEFORE INSERT ON STUDRESULT
    FOR EACH ROW 
    BEGIN
        :NEW.PER := (:NEW.SUB1MARKS + :NEW.SUB2MARKS + :NEW.SUB3MARKS + :NEW.SUB4MARKS)/4;

        IF :NEW.PER > 80 THEN
            :NEW.GRADE := 'A';

        ELSIF :NEW.PER > 60 AND :NEW.PER <= 80 THEN 
            :NEW.GRADE := 'B';

        ELSIF :NEW.PER > 40 AND :NEW.PER <= 60 THEN 
            :NEW.GRADE := 'C';

        ELSIF :NEW.PER <= 40 THEN 
            :NEW.GRADE := 'F';

        END IF;
    END;

-- 2.   Create Trigger to insert data into DELETEDSTUD TABLE(same as STUDRESULT) which record is being deleted from STUDRESULT 

CREATE OR REPLACE TRIGGER deletedStu
BEFORE DELETE ON STUDRESULT
FOR EACH ROW
BEGIN
    INSERT INTO DELETEDSTUD VALUES (:OLD.ROLLNO,:OLD.NAME,:OLD.DIV,:OLD.COURSEID,:OLD.SUB1MARKS,:OLD.SUB2MARKS,:OLD.SUB3MARKS,:OLD.SUB4MARKS,:OLD.PER,:OLD.GRADE);

END;
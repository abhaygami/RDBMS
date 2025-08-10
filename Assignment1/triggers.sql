-- *Q01
    -- Write a PL/SQL program to Calculate AttendancePercentage and AttendanceStatus fields for StudentAttendance Table.
    -- Consider following Rules for calculating
    -- AttendanceStatus field.
    -- Excellent 🡺 90% or more
    -- Good 🡺 70 to 89%
    -- Poor and Can Be Detained🡺 less than 70%

    CREATE OR REPLACE TRIGGER calPerAndStatus
    BEFORE INSERT ON StudentAttendance
    FOR EACH ROW 
    BEGIN
        :NEW.AttendancePercentage := (:NEW.TotalLecturesAttended/:NEW.TotalLecturesConducted)*100;

        IF :NEW.AttendancePercentage >= 90 THEN
            :NEW.AttendanceStatus := 'Excellent';
        
        ELSIF :NEW.AttendancePercentage >=70 AND :NEW.AttendancePercentage <= 89 THEN
            :NEW.AttendanceStatus := 'Good';

        ELSE 
            :NEW.AttendanceStatus := 'Poor and can be Detained';

        END IF;

    END;

-- *Q03
    -- Write PL/SQL program to mark all customer as In_Active if the customer has not logged in for more than 30 days.

    CREATE OR REPLACE TRIGGER  checkActivity
    BEFORE INSERT OR UPDATE ON CustomerLoginActivity
    FOR EACH ROW 

    BEGIN
        IF ABS(:NEW.LastLoginDate - SYSDATE) > 30 THEN
            :NEW.CustomerStatus := 'INACTIVE';

        END IF;
    END;
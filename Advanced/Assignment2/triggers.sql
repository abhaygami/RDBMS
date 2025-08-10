-- *Q_A

    -- Create a database trigger that will calculate Discount & NetPayment automatically.

    -- Rules:
    -- BillAmount is less than 1000 Discount Percentage is 5%,
    -- BillAmount is more than 1000 and less than 10000 Discount is 10%,
    -- BillAmount is Greater than 10000 Discount is 20%,

    -- Note: users will enter BillNo, BillDate and BillAmount.

    CREATE OR REPLACE TRIGGER calDisNet
    BEFORE INSERT ON Bill 
    FOR EACH ROW

    BEGIN
        IF :NEW.BillAmount < 1000 THEN
            :NEW.Discount := :NEW.BillAmount * 0.05;

        ELSIF :NEW.BillAmount BETWEEN 1000 AND 10000 THEN
            :NEW.Discount := :NEW.BillAmount * 0.1;

        ELSE 
            :NEW.Discount := :NEW.BillAmount * 0.2;

        END IF;
        :NEW.NetPayment := :NEW.BillAmount - :NEW.Discount;
    END;

-- *Q_B
    -- Create a trigger for the RegistrationMaster table that will calculate VehicleTaxAmount and VehicalTotalCost.
    
        CREATE OR REPLACE TRIGGER calTaxCost
        BEFORE INSERT ON RegistrationMaster
        FOR EACH ROW
    DECLARE
        taxPer VehicleTaxCategoryMaster.VehicleCategoryTaxRate%TYPE;
    BEGIN
        SELECT VehicleCategoryTaxRate INTO taxPer
        FROM VehicleTaxCategoryMaster
        WHERE VehicleCategoryID = :NEW.VehicleCategoryID;

        :NEW.VehicleTaxAmount := (:NEW.VehicleBasicCost * taxPer)/100;
        :NEW.VehicleTotalCost := :NEW.VehicleBasicCost + :NEW.VehicleTaxAmount;
    END;

-- *Q_C (2)
    -- Write code for Oracle database trigger where any employee data is deleted automatically all rows related to employees in Employee - Project Information table must be deleted.

    CREATE OR REPLACE TRIGGER delEmp
    BEFORE DELETE ON EMPLOYEE
    FOR EACH ROW

    BEGIN
        DELETE FROM EMP_PROJECT
        WHERE EMPID = :OLD.EMPID;
    END;
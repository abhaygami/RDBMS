    CREATE OR REPLACE TRIGGER countNetPay
    BEFORE INSERT ON Book
    FOR EACH ROW
    BEGIN
        :NEW.Netprice := (:NEW.Book_price - :NEW.Discount_amt) * :NEW.Book_qty;
    END;
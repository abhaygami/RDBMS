-- 1. Write a procedure to show the most expensive book.

    CREATE OR REPLACE PROCEDURE displayMostExpensive
    AS
        VBOOKINFO Book%ROWTYPE;
    BEGIN
        SELECT * 
        INTO VBOOKINFO
        FROM Book
        WHERE Book_price = (
            SELECT MAX(Book_price)
            FROM Book
        );

        DBMS_OUTPUT.PUT_LINE('BOOKID = '||VBOOKINFO.Book_id);
        DBMS_OUTPUT.PUT_LINE('BOOK = '||VBOOKINFO.Book_name);
        DBMS_OUTPUT.PUT_LINE('BOOK PRICE = '||VBOOKINFO.Book_price);
    END;

    -- Calling
        BEGIN 
            displayMostExpensive();
        END;

-- 2. Write a procedure to count total books of particular subject.

    CREATE OR REPLACE PROCEDURE countBookPerSubject
    AS
        CURSOR C1 IS 
            SELECT S.Booksubject_name AS Booksubject_name,COUNT(*) AS TOTALBOOKS
            FROM Book B INNER JOIN BookSubject S 
            ON B.Booksub_id = S.Booksub_id
            GROUP BY S.Booksubject_name;
    BEGIN
        FOR REC IN C1 LOOP
            DBMS_OUTPUT.PUT_LINE(REC.Booksubject_name ||' '||REC.TOTALBOOKS);
        END LOOP;
    END;

    -- Calling
        BEGIN
            countBookPerSubject();
        END;

-- 3. Write a procedure to display list of books for a particular author name.

    CREATE OR REPLACE PROCEDURE displayBookPerAuthor
    (VAUTHORNAME Author.Author_name%TYPE)
    AS
        CURSOR C1 IS 
            SELECT Book_name
            FROM Book
            WHERE Author_id IN (
                SELECT Author_id
                FROM Author
                WHERE Author_name = VAUTHORNAME
            );
    BEGIN
        FOR REC IN C1 LOOP
            DBMS_OUTPUT.PUT_LINE(REC.Book_name);
        END LOOP;
    END;

    -- Calling
        BEGIN
            displayBookPerAuthor('JAMES SMITH');
        END;

-- 4. Write a procedure that will show total amount of book purchased in a particular duration. i.e. 1-Jan-2020 to 15-oct-2020.

    CREATE OR REPLACE PROCEDURE totalSellInRange
    (
        VSTARTRANGE Book.purchasedate%TYPE,
        VENDRANGE Book.purchasedate%TYPE
    )
    AS 
        VTOTAL NUMBER;
    BEGIN
        SELECT SUM(Netprice) 
        INTO VTOTAL
        FROM Book
        WHERE purchasedate BETWEEN VSTARTRANGE AND VENDRANGE;

        DBMS_OUTPUT.PUT_LINE('Total Amount = ' || VTOTAL);
    END;

    -- Calling
        BEGIN
            totalSellInRange('03-AUG-2025','12-AUG-2025');
        END;
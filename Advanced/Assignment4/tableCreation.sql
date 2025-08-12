-- Book ( Book_id, Book_name, Book_price, Book_qty, Discount_amt, Netprice, Booksub_id, Author_id, purchasedate )
    CREATE TABLE Book (
        Book_id INT PRIMARY KEY,
        Book_name VARCHAR2(20),
        Book_price INT NOT NULL,
        Book_qty INT NOT NULL CHECK (Book_qty > 0),
        Discount_amt INT,
        Netprice INT,
        Booksub_id INT,
        Author_id INT,
        purchasedate DATE,
        FOREIGN KEY (Booksub_id) REFERENCES BookSubject (Booksub_id),
        FOREIGN KEY (Author_id) REFERENCES Author (Author_id)
    );

-- BookSubject ( Booksub_id, Booksubject_name)
    CREATE TABLE BookSubject (
        Booksub_id INT PRIMARY KEY,
        Booksubject_name VARCHAR2(20)
    );

-- Author ( Author_id, Author_name)
    CREATE TABLE Author (
        Author_id INT PRIMARY KEY,
        Author_name VARCHAR2(20)
    );

    -- Insert data into BookSubject and Author tables
    INSERT ALL
    -- BookSubject data
    INTO BookSubject VALUES (1, 'COMPUTER SCIENCE')
    INTO BookSubject VALUES (2, 'PHYSICS')
    INTO BookSubject VALUES (3, 'MATHEMATICS')
    INTO BookSubject VALUES (4, 'CHEMISTRY')
    INTO BookSubject VALUES (5, 'BIOLOGY')
    INTO BookSubject VALUES (6, 'HISTORY')
    INTO BookSubject VALUES (7, 'ECONOMICS')
    INTO BookSubject VALUES (8, 'LITERATURE')

    -- Author data
    INTO Author VALUES (101, 'JAMES SMITH')
    INTO Author VALUES (102, 'LINDA JOHNSON')
    INTO Author VALUES (103, 'MICHAEL BROWN')
    INTO Author VALUES (104, 'PATRICIA DAVIS')
    INTO Author VALUES (105, 'ROBERT MILLER')
    INTO Author VALUES (106, 'BARBARA WILSON')
    INTO Author VALUES (107, 'DAVID MOORE')
    INTO Author VALUES (108, 'SUSAN TAYLOR')
    SELECT * FROM DUAL;

    -- Insert data into Book table

    INSERT ALL
    INTO Book VALUES (1,  'C++ BASICS',         450, 10,  50, NULL, 1, 101, '12-AUG-2025')
    INTO Book VALUES (2,  'JAVA PROGRAMMING',   550, 15,  75, NULL, 1, 102, '11-AUG-2025')
    INTO Book VALUES (3,  'DATA STRUCTURES',    600, 12,  80, NULL, 1, 103, '10-AUG-2025')
    INTO Book VALUES (4,  'PHYSICS PART 1',     500, 20,  60, NULL, 2, 104, '09-AUG-2025')
    INTO Book VALUES (5,  'PHYSICS PART 2',     520, 18,  65, NULL, 2, 105, '08-AUG-2025')
    INTO Book VALUES (6,  'MATH ALGEBRA',       400, 25,  40, NULL, 3, 106, '07-AUG-2025')
    INTO Book VALUES (7,  'MATH CALCULUS',      480, 15,  50, NULL, 3, 107, '06-AUG-2025')
    INTO Book VALUES (8,  'CHEMISTRY BASICS',   450, 12,  45, NULL, 4, 108, '05-AUG-2025')
    INTO Book VALUES (9,  'ORGANIC CHEMISTRY',  600, 14,  70, NULL, 4, 101, '04-AUG-2025')
    INTO Book VALUES (10, 'BIOLOGY PART 1',     500, 10,  55, NULL, 5, 102, '03-AUG-2025')
    INTO Book VALUES (11, 'BIOLOGY PART 2',     520, 16,  60, NULL, 5, 103, '02-AUG-2025')
    INTO Book VALUES (12, 'WORLD HISTORY',      450, 20,  50, NULL, 6, 104, '01-AUG-2025')
    INTO Book VALUES (13, 'INDIAN HISTORY',     470, 15,  55, NULL, 6, 105, '31-JUL-2025')
    INTO Book VALUES (14, 'MICRO ECONOMICS',    400, 18,  40, NULL, 7, 106, '30-JUL-2025')
    INTO Book VALUES (15, 'MACRO ECONOMICS',    420, 22,  45, NULL, 7, 107, '29-JUL-2025')
    INTO Book VALUES (16, 'ENGLISH LITERATURE', 380, 10,  30, NULL, 8, 108, '28-JUL-2025')
    INTO Book VALUES (17, 'SHAKESPEARE WORKS',  450, 12,  40, NULL, 8, 101, '27-JUL-2025')
    INTO Book VALUES (18, 'NETWORKING BASICS',  550, 14,  70, NULL, 1, 102, '26-JUL-2025')
    INTO Book VALUES (19, 'DATABASE SYSTEMS',   600, 16,  80, NULL, 1, 103, '25-JUL-2025')
    INTO Book VALUES (20, 'THERMODYNAMICS',     500, 20,  60, NULL, 2, 104, '24-JUL-2025')
    INTO Book VALUES (21, 'QUANTUM MECHANICS',  650, 10,  90, NULL, 2, 105, '23-JUL-2025')
    INTO Book VALUES (22, 'STATISTICS BASICS',  480, 12,  50, NULL, 3, 106, '22-JUL-2025')
    INTO Book VALUES (23, 'TRIGONOMETRY',       420, 18,  45, NULL, 3, 107, '21-JUL-2025')
    INTO Book VALUES (24, 'PHYSICAL CHEMISTRY', 580, 14,  75, NULL, 4, 108, '20-JUL-2025')
    INTO Book VALUES (25, 'BOTANY BASICS',      500, 15,  55, NULL, 5, 101, '19-JUL-2025')
    SELECT * FROM dual;

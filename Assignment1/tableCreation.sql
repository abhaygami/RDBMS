-- For Q01
    CREATE TABLE StudentAttendance (
        StudentID INT PRIMARY KEY,
        TotalLecturesConducted INT,
        TotalLecturesAttended INT,
        AttendancePercentage INT,
        AttendanceStatus VARCHAR(20)
    );

    INSERT ALL
        INTO StudentAttendance VALUES (1, 100, 95, NULL, NULL)
        INTO StudentAttendance VALUES (2, 90, 85, NULL, NULL)
        INTO StudentAttendance VALUES (3, 80, 75, NULL, NULL)
        INTO StudentAttendance VALUES (4, 60, 55, NULL, NULL)
        INTO StudentAttendance VALUES (5, 120, 110, NULL, NULL)
        INTO StudentAttendance VALUES (6, 100, 88, NULL, NULL)
        INTO StudentAttendance VALUES (7, 75, 60, NULL, NULL)
        INTO StudentAttendance VALUES (8, 90, 65, NULL, NULL)
        INTO StudentAttendance VALUES (9, 85, 84, NULL, NULL)
        INTO StudentAttendance VALUES (10, 100, 70, NULL, NULL)
        INTO StudentAttendance VALUES (11, 50, 45, NULL, NULL)
        INTO StudentAttendance VALUES (12, 95, 80, NULL, NULL)
        INTO StudentAttendance VALUES (13, 88, 87, NULL, NULL)
        INTO StudentAttendance VALUES (14, 92, 91, NULL, NULL)
        INTO StudentAttendance VALUES (15, 70, 50, NULL, NULL)
    SELECT * FROM DUAL;

-- For Q02
    CREATE TABLE StudentMaster (
        StudentID INT PRIMARY KEY,
        StudentName VARCHAR2(20),
        Category VARCHAR2(10),
        Gender VARCHAR2(10) CHECK(Gender IN('MALE','FEMALE','OTHER')),
        Semester INT CHECK(Semester BETWEEN 1 AND 10),
        Address VARCHAR2(50),
        Phone VARCHAR2(11),
        Mobile VARCHAR2(10),
        Email VARCHAR(20) UNIQUE
    );

    INSERT ALL
    INTO StudentMaster VALUES (1, 'RAHUL', 'GENERAL', 'MALE', 5, 'MUMBAI', '02223456789', '9876543210', 'RAHUL@MAIL.COM')
    INTO StudentMaster VALUES (2, 'PRIYA', 'SC', 'FEMALE', 3, 'AHMEDABAD', '07923456789', '9876501234', 'PRIYA@MAIL.COM')
    INTO StudentMaster VALUES (3, 'AMIT', 'ST', 'MALE', 7, 'DELHI', '01123456789', '9876512345', 'AMIT@MAIL.COM')
    INTO StudentMaster VALUES (4, 'SUNITA', 'SEBC', 'FEMALE', 2, 'HYDERABAD', '04023456789', '9876523456', 'SUNITA@MAIL.COM')
    INTO StudentMaster VALUES (5, 'VIKAS', 'OBC', 'MALE', 4, 'PUNE', '02023456789', '9876534567', 'VIKAS@MAIL.COM')
    INTO StudentMaster VALUES (6, 'NEHA', 'GENERAL', 'FEMALE', 6, 'LUCKNOW', '05222345678', '9876545678', 'NEHA@MAIL.COM')
    INTO StudentMaster VALUES (7, 'ARJUN', 'SC', 'MALE', 1, 'KOCHI', '04842345678', '9876556789', 'ARJUN@MAIL.COM')
    INTO StudentMaster VALUES (8, 'MEENA', 'ST', 'FEMALE', 8, 'JAIPUR', '01412345678', '9876567890', 'MEENA@MAIL.COM')
    INTO StudentMaster VALUES (9, 'ROHAN', 'SEBC', 'MALE', 9, 'KOLKATA', '03323456789', '9876578901', 'ROHAN@MAIL.COM')
    INTO StudentMaster VALUES (10, 'KAVITA', 'OBC', 'FEMALE', 10, 'CHENNAI', '04423456789', '9876589012', 'KAVITA@MAIL.COM')
    INTO StudentMaster VALUES (11, 'SURESH', 'GENERAL', 'MALE', 3, 'THIRUVANANTHAPURAM', '04712345678', '9876590123', 'SURESH@MAIL.COM')
    INTO StudentMaster VALUES (12, 'ANITA', 'SC', 'FEMALE', 5, 'BHOPAL', '07552345678', '9876509876', 'ANITA@MAIL.COM')
    INTO StudentMaster VALUES (13, 'MANOJ', 'ST', 'MALE', 7, 'PATNA', '06122345678', '9876510987', 'MANOJ@MAIL.COM')
    INTO StudentMaster VALUES (14, 'POOJA', 'SEBC', 'FEMALE', 2, 'SURAT', '02612345678', '9876521098', 'POOJA@MAIL.COM')
    INTO StudentMaster VALUES (15, 'RAKESH', 'OBC', 'MALE', 4, 'VADODARA', '02652345678', '9876532109', 'RAKESH@MAIL.COM')
    INTO StudentMaster VALUES (16, 'GEETA', 'GENERAL', 'FEMALE', 6, 'DEHRADUN', '01352345678', '9876543211', 'GEETA@MAIL.COM')
    INTO StudentMaster VALUES (17, 'SANJAY', 'SC', 'MALE', 1, 'GORAKHPUR', '05512345678', '9876554321', 'SANJAY@MAIL.COM')
    INTO StudentMaster VALUES (18, 'KIRAN', 'ST', 'FEMALE', 8, 'AMRITSAR', '01832345678', '9876565432', 'KIRAN@MAIL.COM')
    INTO StudentMaster VALUES (19, 'VISHAL', 'SEBC', 'MALE', 9, 'INDORE', '07312345678', '9876576543', 'VISHAL@MAIL.COM')
    INTO StudentMaster VALUES (20, 'SHREYA', 'OBC', 'FEMALE', 10, 'BENGALURU', '08023456789', '9876587654', 'SHREYA@MAIL.COM')
    
    SELECT * FROM DUAL;


    CREATE TABLE StudentScholarship (
        StudentID INT PRIMARY KEY,
        Year INT,
        Category VARCHAR(10),
        FOREIGN KEY(StudentID) REFERENCES StudentMaster(StudentID)
    );

-- For Q03
    CREATE TABLE CustomerLoginActivity (
        CustomerID INT PRIMARY KEY,
        LastLoginDate DATE,
        LastLoginTime TIMESTAMP,
        CustomerStatus VARCHAR2(10)
    );

    INSERT ALL
    INTO CustomerLoginActivity VALUES (1, '10-AUG-2025', '09:15:20', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (2, '05-JUL-2025', '10:45:00', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (3, '25-JUN-2025', '14:20:30', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (4, '15-MAY-2025', '08:10:50', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (5, '01-JUL-2025', '11:30:45', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (6, '20-APR-2025', '13:40:15', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (7, '18-AUG-2025', '17:05:25', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (8, '10-MAR-2025', '07:55:10', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (9, '02-JUL-2025', '16:25:35', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (10, '12-MAY-2025', '15:50:50', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (11, '22-AUG-2025', '18:15:45', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (12, '14-APR-2025', '12:05:55', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (13, '30-JUL-2025', '09:35:40', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (14, '05-MAR-2025', '06:45:15', 'ACTIVE')
    INTO CustomerLoginActivity VALUES (15, '27-AUG-2025', '20:20:20', 'ACTIVE')
    SELECT * FROM DUAL;

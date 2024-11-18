create database EduTrack; 
use EduTrack;

DROP TABLE IF EXISTS Fee;
DROP TABLE IF EXISTS UnitGrade;
DROP TABLE IF EXISTS Registration; 
DROP TABLE IF EXISTS Unit;
DROP TABLE IF EXISTS Student; 
DROP TABLE IF EXISTS Registration; 

 
-- Create table for storing student information
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    is_current ENUM('YES', 'NO') DEFAULT 'YES'
);

-- Create table for storing courses information
CREATE TABLE Unit (
    unit_code VARCHAR(15) PRIMARY KEY,
    unit_name VARCHAR(100),
    is_advanced ENUM('YES', 'NO') DEFAULT 'NO',
    enrollment INT DEFAULT 0,
    registration_date DATE
);

-- Create table for storing registrations (student-unit relationship)   
-- Update on 03/10/2024: added new column no_penlty_deadline. See ilearn announcement on 03/10/2024
-- Update on 07/10/2024: added new columns droped_out_date and status. 
CREATE TABLE Registration (
    student_id INT,
    unit_code VARCHAR(15),
    semester varchar(15),
    registration_date DATE,
    no_penalty_deadline DATE, 
    dropped_out_date DATE,
    status ENUM('active', 'dropped_with_penalty', 'dropped_without_penalty') DEFAULT 'active',  -- Newly added column
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);


-- Create table for storing student grades
-- Update on 07/10/2024: added new column status.
CREATE TABLE UnitGrade (
    student_id INT,
    unit_code VARCHAR(15),
    semester VARCHAR(15),
    marks DECIMAL(5, 2),
    status ENUM('active', 'dropped') DEFAULT 'active', 
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);

-- Create table for storing fee information
CREATE TABLE Fee (
    student_id INT,
    semester varchar(15),
    fee_amount DECIMAL(10, 2),
    status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    description VARCHAR(255),
    PRIMARY KEY (student_id, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


-- Insert data into Student table
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10001, 'Alice Smith', 'YES'),
(10002, 'Bob Johnson', 'YES'),
(10003, 'Charlie Brown', 'NO'),
(10004, 'David Wilson', 'YES'),
(10005, 'Emily Davis', 'NO'),
(10006, 'Frank Miller', 'YES'),
(10007, 'Grace Hall', 'YES'),
(10008, 'Hannah Lewis', 'YES'),
(10009, 'Ian Walker', 'NO'),
(10010, 'Julia Young', 'YES'),
(10011, 'Kevin Harris', 'YES'),
(10012, 'Lily Martin', 'YES'),
(10013, 'Mason White', 'NO'),
(10014, 'Nina Clark', 'YES'),
(10015, 'Oliver King', 'YES'),
(10016, 'Paul Scott', 'YES'),
(10017, 'Quinn Green', 'NO'),
(10018, 'Rachel Adams', 'YES'),
(10019, 'Samuel Turner', 'YES'),
(10020, 'Tina Baker', 'YES');

-- Insert data into Unit table
INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) VALUES
('IT101', 'Introduction to Programming', 'NO', 40, '2023-02-20'),
('IT102', 'Data Structures', 'NO', 35, '2023-02-20'),
('IT103', 'Database Systems', 'NO', 30, '2023-02-20'),
('IT401', 'Advanced Algorithms', 'YES', 20, '2023-02-20'),
('IT402', 'Machine Learning', 'YES', 25, '2023-02-20'),
('IT403', 'AI in Business', 'YES', 15, '2023-02-20'),
('IT404', 'Cybersecurity', 'YES', 18, '2023-02-20'),
('IT105', 'Operating Systems', 'NO', 30, '2023-02-20'),
('IT106', 'Web Development', 'NO', 28, '2023-02-20'),
('IT405', 'Cloud Computing', 'YES', 12, '2023-02-20');

-- Insert data into Registration table. 
-- Update on 07/10/2024: added data for new columns, droped_out_date and status. Also, updated no_penalty_deadline data
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10001, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10001, 'IT102', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10002, 'IT103', '2023S1', '2023-01-16', '2023-02-13', NULL, 'active'), 
(10002, 'IT105', '2023S1', '2023-01-16', '2023-02-13', '2023-02-10', 'dropped_without_penalty'), 
(10003, 'IT101', '2023S1', '2023-01-17', '2023-02-12', '2023-02-15', 'dropped_with_penalty'), 
(10003, 'IT401', '2023S1', '2023-01-17', '2023-02-14', NULL, 'active'), 
(10004, 'IT402', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10004, 'IT403', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10005, 'IT404', '2023S1', '2023-01-19', '2023-02-16', NULL, 'active'), 
(10005, 'IT102', '2023S1', '2023-01-19', '2023-02-12', '2023-02-20', 'dropped_with_penalty'), 
(10006, 'IT401', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10006, 'IT105', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10007, 'IT402', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10007, 'IT101', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10008, 'IT403', '2023S2', '2023-06-12', '2023-07-10', NULL, 'active'), 
(10008, 'IT102', '2023S2', '2023-06-12', '2023-07-10', '2023-07-15', 'dropped_with_penalty'), 
(10009, 'IT404', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10009, 'IT103', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10010, 'IT401', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10010, 'IT405', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10011, 'IT101', '2024S1', '2024-01-10', '2024-02-10', NULL, 'active'), 
(10011, 'IT402', '2024S1', '2024-01-10', '2024-02-07', NULL, 'active'), 
(10012, 'IT403', '2024S1', '2024-01-11', '2024-02-11', '2024-02-10', 'dropped_with_penalty'), 
(10012, 'IT102', '2024S1', '2024-01-11', '2024-02-11', NULL, 'active'), 
(10013, 'IT105', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10013, 'IT404', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10014, 'IT101', '2024S1', '2024-01-13', '2024-02-10', '2024-02-12', 'dropped_with_penalty'), 
(10014, 'IT405', '2024S1', '2024-01-13', '2024-02-10', NULL, 'active'), 
(10015, 'IT102', '2024S1', '2024-01-14', '2024-02-11', '2024-02-01', 'dropped_without_penalty'), 
(10015, 'IT403', '2024S1', '2024-01-14', '2024-02-11', NULL, 'active'), 
(10016, 'IT401', '2024S1', '2024-01-15', '2024-02-07', NULL, 'active'), 
(10016, 'IT103', '2024S1', '2024-01-15', '2024-02-12', '2024-02-10', 'dropped_without_penalty'), 
(10017, 'IT102', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10017, 'IT404', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10018, 'IT101', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10018, 'IT401', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10019, 'IT105', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10019, 'IT402', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10020, 'IT403', '2024S2', '2024-06-04', '2024-07-02', NULL, 'active'), 
(10020, 'IT101', '2024S2', '2024-06-04', '2024-06-30', NULL, 'active');


-- Insert data into UnitGrade table with semester, marks, and status (active or dropped)
-- Update on 07/10/2024: added data for new column status and updated marks for dropped units
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10001, 'IT101', '2023S1', 75.00, 'active'),
(10001, 'IT102', '2023S1', 65.00, 'active'),
(10002, 'IT103', '2023S1', 85.50, 'active'),
(10002, 'IT105', '2023S1', NULL, 'dropped'),
(10003, 'IT101', '2023S1', NULL, 'dropped'),
(10003, 'IT401', '2023S1', NULL, 'dropped'),
(10004, 'IT402', '2023S1', 55.00, 'active'),
(10004, 'IT403', '2023S1', 92.00, 'active'),
(10005, 'IT404', '2023S1', 50.00, 'active'), 
(10005, 'IT102', '2023S1', NULL, 'dropped'),
(10006, 'IT401', '2023S2', 47.00, 'active'),  
(10006, 'IT105', '2023S2', 60.00, 'active'),
(10007, 'IT402', '2023S2', 88.00, 'active'),
(10007, 'IT101', '2023S2', 30.00, 'active'), 
(10008, 'IT403', '2023S2', 90.00, 'active'),
(10008, 'IT102', '2023S2', NULL, 'dropped'), 
(10009, 'IT404', '2023S2', 40.00, 'active'),
(10009, 'IT103', '2023S2', 55.00, 'active'),
(10010, 'IT401', '2023S2', 85.00, 'active'),
(10010, 'IT405', '2023S2', 32.00, 'active'), 
(10011, 'IT101', '2024S1', 75.00, 'active'),
(10011, 'IT402', '2024S1', 65.00, 'active'),
(10012, 'IT403', '2024S1', NULL, 'dropped'), 
(10012, 'IT102', '2024S1', 70.00, 'active'),
(10013, 'IT105', '2024S1', 85.00, 'active'),
(10013, 'IT404', '2024S1', 48.00, 'active'),
(10014, 'IT101', '2024S1', NULL, 'dropped'), 
(10014, 'IT405', '2024S1', 88.00, 'active'),
(10015, 'IT102', '2024S1', NULL, 'dropped'), 
(10015, 'IT403', '2024S1', 90.00, 'active'),
(10016, 'IT401', '2024S1', 75.00, 'active'),
(10016, 'IT103', '2024S1', NULL, 'dropped'),  
(10017, 'IT102', '2024S2', 70.00, 'active'),
(10017, 'IT404', '2024S2', 68.00, 'active'),
(10018, 'IT101', '2024S2', 60.00, 'active'),
(10018, 'IT401', '2024S2', 80.00, 'active'),
(10019, 'IT105', '2024S2', 82.00, 'active'),
(10019, 'IT402', '2024S2', 90.00, 'active'),
(10020, 'IT403', '2024S2', 94.00, 'active'),
(10020, 'IT101', '2024S2', 78.00, 'active');


-- Insert data into Fee table
-- Update on 07/10/2024: updated data for fee_amount column 
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10002, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10002, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10003, '2023S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10003, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10004, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10004, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10005, '2023S1', 6500.00, 'UNPAID', 'Tuition Fee'),
(10005, '2023S2', 6500.00, 'PAID', 'Late Unit Enrollment Fee'),
(10006, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10006, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10007, '2023S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10007, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2024S1', 8500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10009, '2023S2', 6500.00, 'UNPAID', 'Tuition Fee'),
(10009, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10010, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10010, '2024S1', 8500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10012, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10012, '2024S2', 6500.00, 'PAID', 'Tuition Fee'),
(10014, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10014, '2024S2', 8500.00, 'PAID', 'Dropped Unit Penalty'),
(10015, '2024S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10015, '2024S2', 6500.00, 'UNPAID', 'Tution Fee'),
(10016, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10016, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10017, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10017, '2023S2', 6500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10018, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10018, '2023S2', 6500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10019, '2024S2', 8500.00, 'PAID', 'Tuition Fee'),
(10019, '2023S2', 7500.00, 'PAID', 'Tution Fee'),
(10020, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10020, '2023S2', 8500.00, 'PAID', 'Tuition Fee');

# Create some queries 
# STUDENT INFORMATION
-- How many students are currently active
SELECT COUNT(*) AS 'Active Student'
FROM Student WHERE is_current = 'YES'; 

-- Name of all not current student
SELECT s.student_name
FROM Student s WHERE s.is_current = 'NO'
GROUP BY (s.student_id);

-- UNIT INFORMATION
-- Which units are advanced and how many students enrolled in each 
SELECT u.unit_code,u.unit_name, u.enrollment
FROM Unit u;

-- What is the total number of active registration in each semestr
SELECT semester, COUNT(*) AS 'Active_Registration'
FROM Registration 
WHERE status = 'active'
GROUP BY semester;

-- Which student has highest unpaid fee and the total amount of that 
SELECT s.student_id,s.student_name, SUM(fee_amount) AS 'fee_amount'
FROM Fee f
JOIN Student s 
ON f.student_id = s.student_id
WHERE status = 'unpaid'
GROUP BY student_id
ORDER BY 'fee_amount' DESC 
LIMIT 1;

-- Which unit has highest average grade 
SELECT unit_code, AVG(marks) AS average_marks
FROM UnitGrade 
WHERE marks IS NOT NULL
GROUP BY unit_code
ORDER BY average_marks DESC
LIMIT 1; 

-- COMPLEX QUERIES 
-- Which students have dropped a unit and also have unpaid fee in the same semester 
SELECT r.student_id, r.unit_code, r.semester, f.fee_amount, f.status 
FROM Registration r
JOIN Fee f ON r.student_id = f.student_id AND r.semester = f.semester
WHERE r.status LIKE 'dropped%' AND f.status = 'unpaid';

-- Which units had students who both dropped out and achieved high grade (>90)in another unit during the same semester
SELECT DISTINCT r.unit_code, r.semester
FROM Registration r
JOIN UnitGrade ug ON r.student_id = ug.student_id AND r.semester = ug.semester
WHERE r.status LIKE 'dropped%' AND ug.marks > 90;


# TASK 2: Write a stored function that determines a student's total outstanding balance, including payment for late penalty and 
# dropped unit 
DELIMITER //
DROP FUNCTION IF EXISTS stu_outstanding_balance //
CREATE FUNCTION stu_outstanding_balance(studentID INT)
                RETURNS DECIMAL (10,2)
                DETERMINISTIC
                BEGIN
                DECLARE outstanding_balance DECIMAL (10,2) DEFAULT 0.00;
                
                -- CALCULATE THE FEE OF THIS STUDENT 
                SELECT IFNULL(SUM(fee_amount), 0.00) INTO outstanding_balance
                FROM Fee
                WHERE student_id = studentID AND status = 'UNPAID';
                RETURN outstanding_balance;
			END //
DELIMITER ; 

-- check function 
SELECT stu_outstanding_balance(10003) AS 'outstanding_balance';

# TASK 3: we need to identify whether they want to drop or register (maybe add drop_date in the in parameter) 
DELIMITER //
DROP PROCEDURE IF EXISTS Brule_action //
CREATE PROCEDURE Brule_action (IN studentID INT, IN unitcode VARCHAR(15), IN semester VARCHAR(15), IN action_type ENUM ('REGISTER', 'DROP'))
BEGIN 
    DECLARE outstanding_balance DECIMAL(10,2);
    DECLARE total_failed_units INT;
    DECLARE registration_date DATE; 
    DECLARE drop_date_penalty  DATE; -- to record student's last day to drop without penalty 
    DECLARE is_advanced ENUM('Yes', 'No');
    DECLARE penalty_fee DECIMAL(10,2);
    DECLARE error_message VARCHAR(500);
    DECLARE fee_status VARCHAR(100); 
    -- DECLARE due_date DATE; -- set due date of the unit 

    -- 1) Check if students have outstanding_balance (BR2)
    -- If outstanding_balance > 0, prevent students from enrolling in units 
    IF stu_outstanding_balance(studentID) > 0 THEN
        -- SELECT CONCAT(stu_outstanding_balance(studentID)) AS message;
        SET error_message = 'Student can not register due to  outstanding balance from previous semester';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;

    -- 2) Check if students failed more than 2 units or have outstanding balance and want to enroll in advanced unit (BR6)
    -- Calculate the number of failed units
    SELECT COUNT(*) INTO total_failed_units
    FROM UnitGrade 
    WHERE student_id = studentID AND marks < 50; 
    
    -- Check if that unit is advanced level 
    SELECT u.is_advanced INTO is_advanced
    FROM Unit u
    WHERE u.unit_code = unitcode;
    
    -- Check if students have more than 2 failed units or have outstanding balance and want to enroll in advanced unit
    IF total_failed_units > 2 AND is_advanced = 'YES' THEN
        SET error_message = 'Student is not eligible for advanced units due to more than 2 failed units';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF; 

    -- HANDLE ACTION 
    IF action_type = 'REGISTER' THEN 
        -- If all checks pass, register the student for the unit (should output that student succesfully enroll in that unit) 
        INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, status)
        VALUES (studentID, unitcode, semester, CURDATE(), DATE_ADD(current_date, INTERVAL 30 DAY), 'active');
        
        -- Insert into fee table 
        IF is_advanced = 'YES' THEN 
           INSERT INTO Fee(student_id, semester, fee_amount, status, description) VALUES
              (studentID, semester, 4000.00, 'UNPAID', 'Tuition Fee');
		ELSE
           INSERT INTO Fee(student_id, semester, fee_amount, status, description) VALUES
			   (studentID, semester, 3000.00, 'UNPAID', 'Tuition Fee');
		END IF; 
        
		-- Update the enrollment count in the Unit table
       UPDATE Unit
       SET enrollment = enrollment + 1
       WHERE unit_code = unitcode;
       
       -- print out 
       SELECT CONCAT('Student ', studentID, ' has succesfully enrol in ', unitcode, ' unit') AS message; 
       
	ELSEIF action_type = 'DROP' THEN 

	   -- 3) Automatically apply a penalty for dropped units if dropped after the deadline (BR4)
       -- $600 for advanced units, $400 for regular units
       -- Set the due date 
       SELECT r.registration_date INTO registration_date
       FROM registration r
       WHERE r.student_id = studentID AND r.unit_code = unitcode AND r.semester = semester;
       
       IF registration_date IS NULL THEN 
          SET error_message = 'Student have not registered in this unit';
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
	   END IF; 
       
       -- assume students have 30 days from register day to drop unit without any penalty 
	   SET drop_date_penalty = date_add(registration_date, INTERVAL 30 DAY);
       
       IF CURDATE() > drop_date_penalty THEN 
          IF is_advanced = 'YES' THEN 
			 SET penalty_fee = 600.00;
		  ELSE 
             SET penalty_fee = 400.00; 
	      END IF; 
        
	      UPDATE Registration
	      SET status = 'Dropped_with_penalty', dropped_out_date = CURDATE()
	      WHERE student_id = StudentID AND unit_code = unitcode AND semester = semester; 
        
        END IF; 
        
        -- update  fee record (how about if they pay tutition fee already but now they want to drop unit) 
        SELECT f.status INTO fee_status
        FROM Fee f
        WHERE f.student_id = studentID AND f.semester = semester;
        
        IF fee_status = 'PAID' THEN
           -- DROP THAT PAID tuition fee
           DELETE FROM Fee WHERE student_id = studentID AND semester = semester; 
           -- INSERT NEW penalty fee
           INSERT INTO Fee(student_id, semester, fee_amount, status, description) VALUES
                (studentID, semester, penalty_fee, 'UNPAID', 'Dropped Unit Penalty');
		ELSE 
        
           UPDATE Fee f
		   SET f.fee_amount = f.fee_amount + penalty_fee, f.status = 'UNPAID'
           WHERE f.student_id = studentID AND semester = f.semester; 
           
	       UPDATE Registration
	       SET status = 'Dropped_without_penalty', dropped_out_date = CURDATE()
	       WHERE student_id = StudentID AND unit_code = unitcode AND semester = semester; 
          
	   END IF; 
       -- Update the unit table
       UPDATE Unit
       SET enrollment = enrollment - 1
       WHERE unit_code = unitcode;
       
       -- print out 
       SELECT CONCAT('Student ', studentID, ' has sucessfully drop ', unitcode, ' unit');
   END IF;		 
END //
DELIMITER ;

-- TASK 5
-- TEST PLAN DATA 
INSERT INTO Student (student_id, student_name, is_current) VALUES
     (10021, 'Paul Ha', 'Yes'), -- no outstanding fees, no failed units 
     (10022, 'Calvin Tan', 'No'), -- no outstanding fees, 2 failed units 
     (10023, 'Rita Phan', 'Yes'), -- outstanding fees, no failed units 
     (10024, 'Bob', 'Yes'), -- no outstanding fees, 1 faild unit
     (10025, 'Jas', 'No'), -- 2 failed units, outstanding fees
     (10026, 'Carl', 'Yes'),
     (10027, 'Vincent', 'Yes'), 
     (10028, 'Yaha', 'Yes'); 

INSERT INTO Fee(student_id, semester, fee_amount, status, description) VALUES
     (10021, '2024S1', 1000.00, 'PAID', 'TuitionFee'), 
     (10022, '2023S1', 8500.00, 'PAID', 'TuitionFee'), 
     (10023, '2024S1', 8500.00, 'UNPAID', 'TuitionFee'), 
     (10024, '2023S1', 70.000, 'PAID', 'TuitionFee'), 
     (10025, '2024S1', 2800.00, 'UNPAID', 'TuitionFee'),
     (10027, '2024S2', '700.000', 'PAID', 'TuitionFee'),
     (10028, '2024S1', '600.00', 'PAID', 'TuitionFee'); 

INSERT INTO UnitGrade (student_id, unit_code, semester, marks) VALUES
     (10021, 'IT101', '2024S1', 78.00),
     (10021, 'IT102', '2024S2', 73.00),
     (10022, 'IT102', '2023S2', 40.00), -- Calvin failed 1 unit 
     (10022, 'IT103', '2023S2', 41.00), -- Calvin failed 2 units 
     (10022, 'IT101', '2023S1', 40.00),
     (10023, 'IT101', '2023S2', 90.00), -- Rita Pass
     (10024, 'IT103', '2023S1', 45.00), -- Bob failed 1 unit 
     (10025, 'IT102', '2023S2', 45.00), -- Jas failed 1 unit 
     (10025, 'IT101', '2023S1', 40.00); -- Jas failed 2 units
     

     
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline) VALUES
    -- Paul Ha
    (10021, 'IT101', '2024S1', '2024-01-10', '2024-02-15'),  -- Registered for IT101
    (10021, 'IT102', '2024S2', '2024-01-15', '2024-02-15'),  -- Registered for IT102
    -- Calvin Tan
    (10022, 'IT102', '2023S2', '2023-01-12', '2023-02-15'),  -- Registered for IT102 (Failed)
    (10022, 'IT103', '2023S2', '2023-01-14', '2023-02-15'),  -- Registered for IT103 (Failed)
    (10022, 'IT101', '2023S2', '2023-01-14', '2023-02-15'),
    -- Rita Phan
    (10023, 'IT101', '2023S2', '2023-01-16', '2023-02-15'),  -- Registered for IT101
    -- Bob
    (10024, 'IT103', '2023S1', '2023-01-18', '2023-02-15'),  -- Registered for IT103 (Failed)
    -- Jas
    (10025, 'IT102', '2023S2', '2023-01-20', '2023-02-15'),  -- Registered for IT102 (Failed)
    (10025, 'IT101', '2023S1', '2023-01-22', '2023-02-15'),  -- Registered for IT101 (Failed)
    -- Carl 
	(10026, 'IT103', '2024S2', '2024-01-10', '2024-11-01'),  -- Registered for IT103
	-- Vincent
    (10027, 'IT403', '2024S2', '2024-08-09', '2024-09-09'), 
    -- Yaha
    (10028, 'IT101', '2024S1', '2024-08-09', '2024-09-09');
    
    
-- code for testing test plan 
-- For register in unit 
-- Check for Paul 
CALL BRule_action(10021, 'IT403', '2024S2', 'REGISTER');
SELECT * FROM Registration WHERE student_id = 10021 AND semester = '2024S2' AND unit_code = 'IT403';
-- Check for Calvin 
CALL BRule_action(10022, 'IT403', '2024S1', 'REGISTER'); -- advanced unit
CALL BRule_action(10022, 'IT101', '2024S1', 'REGISTER'); -- regular unit
-- Check for Rita 
CALL BRule_action(10023, 'IT103', '2024S1', 'REGISTER');
-- Check for Bob
CALL BRule_action(10024, 'IT101', '2024S1', 'REGISTER');
-- Check for Jas
CALL BRule_action(10025, 'IT105', '2024S1', 'REGISTER');

-- For drop out unit
-- Check for Carl (student drop before penalty deadline)
SELECT * 
FROM Registration 
WHERE student_id = 10026;

CALL BRule_action(10026, 'IT103', '2024S2', 'DROP');

SELECT * 
FROM Fee
WHERE student_id = 10026;

SELECT * FROM Registration WHERE student_id = 10026;

-- Check for Vincent (student drop advanced unit after penalty deadline with $600 applied) 
CALL BRule_action(10027, 'IT403', '2024S2', 'DROP');
-- check fee
SELECT * 
FROM Fee
WHERE student_id = 10027;
-- check registration 
SELECT * 
FROM Registration
WHERE student_id = 10027;

-- Check for Yaha (student drop regular unit after penalty deadline with $400 applied) 
CALL BRule_action(10028, 'IT101', '2024S1', 'DROP');
-- check fee
SELECT * FROM Fee WHERE student_id = 10028;

-- check registration
SELECT * FROM Registration WHERE student_id = 10028;






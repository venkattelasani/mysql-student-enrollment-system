# creating database name called as  StudentRecordsDB
CREATE DATABASE StudentRecordsDB;

USE StudentRecordsDB;

# 1 creating table called Students as below:

-- Create the Students table with the following columns:
-- student_id: unique identifier, auto-incremented
-- name: name of the student, cannot be null
-- email: optional email field for the student
-- phone_number: optional contact number for the student
-- enrollment_date: date when the student enrolled, defaults to the current date

CREATE TABLE Students (
    student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(15),
    enrollment_date DATE DEFAULT (CURRENT_DATE)
);

# 2 Creating table called Teachers as below :

-- Create the Teachers table with the following columns:
-- teacher_id: unique identifier, auto-incremented
-- name: name of the teacher, cannot be null
-- email: optional email field for the teacher
-- hire_date: date the teacher was hired, defaults to the current date

CREATE TABLE Teachers (
    teacher_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    hire_date DATE DEFAULT (CURRENT_DATE)
);

# 3 Creating  table called Courses :

-- Create the Courses table with the following columns:
-- course_id: unique identifier for each course, auto-incremented
-- course_name: name of the course, cannot be null
-- teacher_id: references the teacher who teaches the course, foreign key from Teachers table

CREATE TABLE Courses (
    course_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

# 4 Creating  table called Enrollment :

-- Create the Enrollments table to track student enrollment in courses:
-- enrollment_id: unique identifier, auto-incremented
-- student_id: foreign key referencing the Students table
-- course_id: foreign key referencing the Courses table
-- enrollment_date: date when the student enrolled in the course, defaults to current date

CREATE TABLE Enrollments (
    enrollment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

# 5  creating table called Grades as below :

-- Create the Grades table to store the grades students receive in courses:
-- grade_id: unique identifier, auto-incremented
-- student_id: foreign key referencing the Students table
-- course_id: foreign key referencing the Courses table
-- grade: letter grade assigned to the student in the course

CREATE TABLE Grades (
    grade_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

# Inserting Data:

-- 1 Insert student records into the Students table
INSERT INTO Students (name, email, phone_number) VALUES
(' Liam Gentry', 'lima@example.com', '1234567890'),
(' Lyric Glass', 'lyric@example.com', '0987654321');
-- SELECT * FROM Students;

-- 2 Insert teacher records into the Teachers table
INSERT INTO Teachers (name, email) VALUES
(' Aiden Nichols', 'alice@example.com'),
(' Beau Booth', 'beau@example.com');
-- SELECT * FROM Teachers;

--  3 Insert course records into the Courses table, associating each course with a teacher
INSERT INTO Courses (course_name, teacher_id) VALUES
('Mathematics', 1),
('Physics', 2);	
-- SELECT * FROM Courses;		

-- 4 Insert enrollment records for students into courses
INSERT INTO Enrollments (student_id, course_id) VALUES
(1, 1), -- Student 1 enrolls in Course 1
(2, 2); -- Student 2 enrolls in Course 2
-- SELECT * FROM Enrollments;


-- 5 Insert grade records for students in their respective courses
INSERT INTO Grades (student_id, course_id, grade) VALUES
(1, 1, 'A'), -- Student 1 gets grade 'A' in Course 1
(2, 2, 'B'); -- Student 2 gets grade 'B' in Course 2
-- SELECT * FROM Grades;

# Analysis Data 

# Query-1: Add a New Student:
-- Insert a new student record into the Students table with name, email, and phone number
INSERT INTO Students (name, email, phone_number) VALUES
-- Values for the new student: 'Julio Stokes', 'julio@example.com', '0987654321'
('Julio Stokes', 'julio@example.com', '0987654321');
 -- SELECT * FROM Students;
 
 # Query-2: Enroll a Student in a Course
 -- Insert a new enrollment record into the Enrollments table
INSERT INTO Enrollments (student_id, course_id) VALUES
-- Enroll student 1 in course 2
(1, 2);

# Query-3: Assign a Grade to a Student
-- Insert a new grade record into the Grades table
INSERT INTO Grades (student_id, course_id, grade) VALUES
-- Assign grade 'A' to student 1 in course 2
(1, 2, 'A');

# Query-4: List All Students Enrolled in a Course
-- Select student names and course name for students enrolled in course 1
SELECT s.name, c.course_name
-- From the Enrollments table, join with the Students table to get student information
FROM Enrollments e
JOIN Students s
ON e.student_id = s.student_id
-- Join with the Courses table to get the course name
JOIN Courses c
ON e.course_id = c.course_id
-- Filter to only show students enrolled in course 1
WHERE c.course_id = 1;



# Query-5: Update a Student’s Contact Information
-- Update the phone number of the student with student_id 1
UPDATE Students
-- Set the new phone number to '9876543210'
SET phone_number = '9876543210'
-- Apply the update to the student with student_id 1
WHERE student_id = 1;

# Query-6: Remove a Student from a Course
-- Delete the enrollment record for student 1 in course 2
DELETE FROM Enrollments
-- Specify the student_id and course_id to identify the record to delete
WHERE student_id = 1 AND course_id = 2;

# Query-7: View All Courses Taught by a Specific Teacher
-- Select the names of courses taught by the teacher with teacher_id 2
SELECT course_name
-- From the Courses table
FROM Courses
-- Filter to show only the courses where the teacher_id is 2
WHERE teacher_id = 2;

# Query-8: Count the Number of Students in a Course
-- Count the total number of students enrolled in course 1
SELECT COUNT(*) AS total_students
-- From the Enrollments table
FROM Enrollments
-- Filter to count only students enrolled in course 1
WHERE course_id = 1;

# Query-9: List Students Who Have Not Yet Been Assigned a Grade
-- Select the names of students who do not have a grade for course 2
SELECT s.name
-- From the Students table, using an alias 's'
FROM Students s
-- Perform a LEFT JOIN with the Grades table based on student_id and course_id = 2
LEFT JOIN Grades g ON s.student_id = g.student_id AND g.course_id = 2
-- Filter to include only those students where the grade is NULL
WHERE g.grade IS NULL;


# Query-10: Find the Highest Grade Assigned in a Course
-- Retrieve the highest grade for students enrolled in course 2
SELECT MAX(grade) AS highest_grade
-- From the Grades table
FROM Grades
-- Filter to include only grades for course_id 2
WHERE course_id = 2;

# Query-11: Find the Total Number of Courses Each Student is Enrolled In
-- Retrieve student names along with the count of courses they are enrolled in
SELECT s.name, COUNT(e.course_id) AS total_courses
-- From the Enrollments table, using an alias 'e'
FROM Enrollments e
-- Join with the Students table based on student_id to link enrollments with student names
JOIN Students s ON e.student_id = s.student_id
-- Group the results by student name to get total courses for each student
GROUP BY s.name;

#  12 Find students enrolled in more than one course
SELECT name 
FROM Students 
WHERE student_id IN (
    SELECT student_id 
    FROM Enrollments 
    GROUP BY student_id 
    HAVING COUNT(course_id) > 1
);

#  13 List teachers who teach at least one course with students having grade ‘A’
SELECT name 
FROM Teachers 
WHERE teacher_id IN (
    SELECT c.teacher_id 
    FROM Courses c 
    JOIN Grades g ON c.course_id = g.course_id 
    WHERE g.grade = 'A'
);

# 14 Find students who are not enrolled in any course
SELECT name 
FROM Students 
WHERE student_id NOT IN (
    SELECT student_id FROM Enrollments
);


# 15 Display students whose enrollment date is earlier than the earliest teacher hire date
SELECT name
FROM Students
WHERE enrollment_date < (
    SELECT MIN(hire_date) FROM Teachers
);

# 16 Retrieve teachers who have not yet assigned any grades
SELECT name
FROM Teachers
WHERE teacher_id NOT IN (
    SELECT DISTINCT c.teacher_id
    FROM Courses c
    JOIN Grades g ON c.course_id = g.course_id
);

# 17 List all students along with their total number of grades assigned (even if zero)
SELECT s.name,
(SELECT COUNT(*) FROM Grades g WHERE g.student_id = s.student_id) AS total_grades
FROM Students s;

# 18 Find the average number of students per teacher
SELECT ROUND(AVG(student_count), 2) AS avg_students_per_teacher
FROM (
    SELECT 
        t.teacher_id, 
        COUNT(e.student_id) AS student_count
    FROM Teachers t
    JOIN Courses c ON t.teacher_id = c.teacher_id
    LEFT JOIN Enrollments e ON c.course_id = e.course_id
    GROUP BY t.teacher_id
) AS teacher_load;

 
 #  19 Rank Students Within Each Course (Using Window Function)
 SELECT 
    c.course_name,
    s.name AS student_name,
    g.grade,
    RANK() OVER (
        PARTITION BY c.course_id 
        ORDER BY 
            CASE g.grade
                WHEN 'A' THEN 4
                WHEN 'B' THEN 3
                WHEN 'C' THEN 2
                WHEN 'D' THEN 1
                ELSE 0
            END DESC
    ) AS rank_in_course
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
JOIN Courses c ON g.course_id = c.course_id
ORDER BY c.course_name, rank_in_course;

# 20  List Students Enrolled in More Than One Course Using a CTE
WITH StudentCourseCount AS (
    SELECT 
        student_id, 
        COUNT(course_id) AS total_courses
    FROM Enrollments
    GROUP BY student_id
)
SELECT s.name, sc.total_courses
FROM StudentCourseCount sc
JOIN Students s ON s.student_id = sc.student_id
WHERE sc.total_courses > 1;





































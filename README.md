# 🎓 Student Records Management System (MySQL Project)

> 🚀 *A complete SQL-based database solution to manage student, course, enrollment, and academic performance data with real-world design, powerful queries, and professional documentation.*

---

## 🌟 Highlights

* 📊 **Fully Relational MySQL Database**
* 💡 **Covers Basic to Advanced SQL Concepts**
* 🔍 **Includes Subqueries, Joins, CTEs & Window Functions**
* 🧠 **Realistic Use Case for Data Analysts / Database Developers**
* 🧾 **Portfolio-Ready Project for GitHub & Resumes**

---

## 🧭 Overview

The **Student Records Management System** efficiently manages educational data such as:

* Student personal details
* Course offerings and assignments
* Enrollment tracking
* Grade management
* Performance reporting

This project demonstrates **data modeling**, **query optimization**, and **report generation** using SQL — ideal for anyone aspiring for a **Data Analyst** or **Data Engineer** role.

---

## 🗂️ Objectives

* 📘 Design a normalized relational database.
* 🧩 Establish strong relationships using primary and foreign keys.
* ⚙️ Implement CRUD operations and advanced analytical SQL queries.
* 📈 Generate insights through aggregation, ranking, and CTEs.

---

## 🧱 Database Design

### 🔹 Entities and Relationships

| Table           | Description                           |
| --------------- | ------------------------------------- |
| **Students**    | Student personal and academic details |
| **Teachers**    | Faculty details                       |
| **Courses**     | Course details with assigned teacher  |
| **Enrollments** | Mapping between students and courses  |
| **Grades**      | Academic performance per course       |

**Relationships:**

* One **student** → many **enrollments**
* One **teacher** → many **courses**
* One **course** → many **grades**

---

## 🗄️ Schema Definition

```sql
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    contact VARCHAR(50),
    enrollment_date DATE
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    description TEXT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
```

---

## ⚙️ Key Functionalities

### 🧾 Core Operations

* Add, edit, and delete students, teachers, and courses.
* Manage enrollments and grades seamlessly.

### 🔍 Query Operations

* Retrieve complete student academic profiles.
* Monitor teacher course loads.
* Evaluate course-wise grade distributions.

### 🧮 Analytical Insights

* Subqueries & correlated subqueries.
* CTEs for modular query design.
* Window functions for ranking and analytics.

---

## 🧠 Featured Queries

### 🔸 Average Number of Students per Teacher

```sql
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
```

### 🔸 Rank Students by Performance per Course

```sql
SELECT 
    s.name,
    c.course_name,
    g.grade,
    RANK() OVER (PARTITION BY c.course_id ORDER BY g.grade DESC) AS rank_in_course
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
JOIN Courses c ON g.course_id = c.course_id;
```

### 🔸 Identify Students Enrolled in Multiple Courses (CTE)

```sql
WITH StudentCourseCount AS (
    SELECT student_id, COUNT(course_id) AS total_courses
    FROM Enrollments
    GROUP BY student_id
)
SELECT s.name, total_courses
FROM StudentCourseCount sc
JOIN Students s ON sc.student_id = s.student_id
WHERE total_courses > 1;
```

---

## 🧩 Topics Covered

| Level               | Concepts Covered                                   |
| ------------------- | -------------------------------------------------- |
| 🟢 **Basic**        | CREATE, INSERT, SELECT, UPDATE, DELETE             |
| 🟡 **Intermediate** | Joins, Aggregations, GROUP BY, HAVING              |
| 🔵 **Advanced**     | Subqueries, Window Functions, CTEs, Derived Tables |

---

## 🧰 Tech Stack

* **Database:** MySQL
* **IDE:** MySQL Workbench / VS Code
* **Version Control:** Git & GitHub

---

## 🚀 How to Run

1. Clone this repo:

   ```bash
   git clone https://github.com/<your-username>/student-records-management-system.git
   ```
2. Open the `.sql` file in **MySQL Workbench**.
3. Execute the schema and sample data scripts.
4. Run analytical queries one by one.

---

## 🧑‍💻 Author

**Venkatarao Telasani**
🎯 *Aspiring Data Analyst | SQL & Python Enthusiast*
🌐 [LinkedIn](https://www.linkedin.com/in/venkatarao-telasani/)
💻 [GitHub](https://github.com/venkattelasani)
✍️ [Medium](https://medium.com/@venkatarao3075)

---

## 📜 License

This project is licensed under the **MIT License**.
Feel free to fork, learn, and customize!

---

> 💬 *If you found this project useful, don’t forget to ⭐ the repository — it helps others discover it too!*

SELECT * FROM school_db.marks;
Insert into students values('108', 'Aisha', 'Dehradun');
Insert into students values('109','Rahul','Delhi'),('110', 'Priya', 'Mumbai');

INSERT INTO students (student_id, name, city) VALUES
(111, 'Aman', 'Pune'),
(112, 'Kavya', 'Bangalore'),
(113, 'Sahil', 'Chennai'),
(114, 'Pooja', 'Kolkata'),
(115, 'Arjun', 'Hyderabad');


INSERT INTO marks (student_id, subject, marks) VALUES(111, 'Maths', 65),
(111, 'Science', 72),

(112, 'Maths', 95),
(112, 'Science', 90),

(113, 'Maths', 88),
(113, 'Science', 91),

(114, 'Maths', 55),
(114, 'Science', 60),

(115, 'Maths', 99),
(115, 'Science', 96);
INSERT INTO marks (student_id, subject, marks) VALUES(116, 'English', 88);

-- Five Questions Mixing INNER + LEFT JOIN
-- 1.	Display all students and their marks, but also show only those subjects that match using INNER JOIN inside a LEFT JOIN scenario 
Select S.name, M.marks from Students S left join Marks M on S.student_id = M.student_id AND M.subject IS NOT NULL;
-- 2.	List students who have marks in Math (INNER JOIN) and show all students (LEFT JOIN).
Select S.name, M.marks from Students S left join Marks M on  S.student_id = M.student_id where M.subject = 'Math';
-- 3.	Retrieve all students (LEFT JOIN) and also show only matching subjects (INNER JOIN).
Select S.name, M.subject from Students S left join Marks M on  S.student_id = M.student_id;
-- 4.	Find students with marks (INNER JOIN) and also list students without marks (LEFT JOIN).
Select S.name, M.subject, M.marks from Students S left join Marks M on  S.student_id = M.student_id;
-- 5.	Show all students from Mumbai (LEFT JOIN) and only matching marks (INNER JOIN).
Select S.name, M.marks from Students S left join Marks  M on  S.student_id = M.student_id where 
S.city='Mumbai' and M.marks is not NULL;


-- Five Questions Mixing INNER + RIGHT JOIN
-- 1.	Display all marks entries (RIGHT JOIN) and also show only matching students (INNER JOIN).
Select S.name,  M.marks  from Students S Right Join Marks M on S.student_id = M.student_id;

-- 2.	Retrieve subjects with matching students (INNER JOIN) and also show all marks (RIGHT JOIN).
Select S.student_id, S.name, M.subject,
case when S.student_id IS NULL then 'No Student'
else 'Matched Students' end as match_status
 from Students S Right Join Marks M on S.student_id = M.student_id;

-- 3.	Find marks without students (RIGHT JOIN) and also show matching ones (INNER JOIN).
Select S.name, M.marks from Students S right join Marks M on S.student_id = M.student_id;


-- 4.	Show all marks for Math (RIGHT JOIN) and matching students (INNER JOIN).
Select S.name, M.subject, M.marks from Students S right join Marks M on S.student_id = M.student_id where M.subject = 'Maths';

-- 5.	Display all marks entries (RIGHT JOIN) and only matching student names (INNER JOIN).
Select S.name, M.marks from Students S right join Marks M on S.student_id = M.student_id;


-- Mixing ALL THREE (INNER + LEFT + RIGHT JOIN)

-- 1.	Display all students (LEFT JOIN), all marks (RIGHT JOIN), and matching ones (INNER JOIN).
Select S.student_id, S.name,  M.subject, M.marks from Students S Left Join Marks M on S.student_id = M.student_id
Union
Select S.student_id, S.name, M.subject, M.marks from Students S Right Join Marks M on S.student_id = M.student_id;

-- 2.	Retrieve a full list of students and marks using LEFT, RIGHT, and INNER JOIN combinations.
Select S.name, M.marks  from Students S Left Join Marks M on S.student_id = M.student_id
Union
Select S.name, M.marks  from Students S Right Join Marks M on S.student_id = M.student_id;

-- 3.	Show students with marks (INNER JOIN), students without marks (LEFT JOIN), and marks without students (RIGHT JOIN).
SELECT S.name, M.marks,
CASE WHEN M.marks IS NULL THEN 'Student without marks' ELSE 'Student with marks'
END AS status
FROM Students S
LEFT JOIN Marks M ON S.student_id = M.student_id

UNION

SELECT S.name, M.marks, 'Mark without student' AS status
FROM Students S
RIGHT JOIN Marks M ON S.student_id = M.student_id
WHERE S.student_id IS NULL;


-- 4.	Write a query to produce a full outer join effect using LEFT + RIGHT + INNER JOIN.
Select S.student_id, S.name, M.subject, M.marks  from Students S Left Join Marks M on S.student_id = M.student_id
Union
Select S.student_id, S.name, M.subject, M.marks from Students S Right Join Marks M on S.student_id = M.student_id;

-- 5.	Display all unique student_id values from both tables using a combination of all three joins.
SELECT student_id FROM Students
UNION
SELECT student_id FROM Marks;


-- SELF JOIN
-- 1 Find students who belong to the same city as other students.
Select s1.name as student1,
s2.name as student2, s1.city From students s1 join students s2 ON s1.city = s2.city and s1.student_id <> s2.student_id ;


-- 2 Find students who have the same name but different student IDs.
 Select s1.name as student1, s2.name as student2 from Students s1 join
 Students s2 on s1.name = s2.name and s1.student_id <> s2.student_id;


-- 3 Compare marks of the same student in different subjects.
Select  m1.student_id,
    m1.subject AS subject_1,
    m1.marks AS marks_1,
    m2.subject AS subject_2,
    m2.marks AS marks_2 FROM marks m1
JOIN marks m2
    ON m1.student_id = m2.student_id
   AND m1.subject <> m2.subject;
   
   -- CROSS JOIN
   
   -- 1 Generate all possible combinations of students and subjects.
   Select s.name, m.subject From students s cross join marks m;
   
   -- 2 Assign every student to every subject (theoretical scenario).
   Select s.student_id, s.name, m.subject from students s Cross join (Select Distinct subject from marks) as m;
   
   
   -- Subquery
   Select * from students;
   -- 1 Find students who scored more than the average marks of their own subject.
   Select s.student_id, s.name from students s join marks m on s.student_id = m.student_id
   where m.marks > (Select avg(m1.marks) from marks m1 where m1.subject = m.subject);
   
-- 2 Find students whose marks are the highest in their respective subject.
 Select s.student_id, s.name, m.subject from students s join marks m on s.student_id = m.student_id
   where m.marks = (Select max(m1.marks) from marks m1 where m1.subject = m.subject);
   
   
-- 3 Insert into students all distinct student_ids from the marks table who are not already present in the students table.
INSERT INTO students (student_id) SELECT DISTINCT m.student_id FROM marks m
WHERE NOT EXISTS (
    SELECT 1
    FROM students s
    WHERE s.student_id = m.student_id
);


-- 4 Insert students into the students table who have scored more than 80 in any subject.
INSERT INTO students(student_id)
SELECT DISTINCT m.student_id From marks m where m.marks > 80 AND Not EXISTS(Select 1 from students s where s.student_id = m.student_id);

-- 5 Update the city of students to 'Topper City' for students whose average marks are greater than 85.
Update students SET city = "Topper City" 
where student_id IN(Select student_id from marks group by student_id having avg(marks) > 85);

-- 6. Students Scoring Above Their Own Average
Select s.student_id, s.name, m.marks  from students s join marks m on s.student_id = m.student_id where m.marks > (Select avg(m1.marks) from Marks m1  where m1.student_id
 = m.student_id);


-- 7. Subjects with Above Overall Average Marks
Select subject from marks  group by subject HAVING avg(marks) > (Select avg(marks) from marks);

-- 8. Students Who Never Scored Below 60
Select  s.student_id, s.name from students s where not exists(select 1 from marks m where m.student_id = s.student_id and m.marks < 60);

-- 9. Students with Same Marks in Multiple Subjects
Select s.name, m.subject, m.marks from students s join marks m on s.student_id = m.student_id where (m.student_id, m.marks) 
IN (Select student_id, marks from marks group by student_id, marks having count(Distinct subject) > 1);


-- 10. Students Who Scored in All Subjects
Select s.student_id, s.name from students s join marks m on s.student_id = m.student_id GROUP BY s.student_id, s.name HAVING count(distinct m.subject) = (Select 
count(Distinct subject) From marks);

-- CTE
-- 1. Students Above Subject Average (CTE)
-- 👉 Using a CTE, calculate the average marks per subject, then find students who scored above their subject’s average. 
With subject_avg as (Select student_id, subject, avg(marks) as avg_marks from marks group by subject)
Select s.student_id, s.name, m.subject, m.marks from students s join marks m ON s.student_id = m.student_id
JOIN subject_avg sa  ON m.subject = sa.subject where m.marks > sa.avg_marks;


-- 1. Average Marks per Student

-- Question:
-- Create a CTE to calculate the average marks for each student, then display students whose average is greater than 75.

-- Answer:

WITH StudentAvg AS (
    SELECT student_id, AVG(marks) AS avg_marks
    FROM marks
    GROUP BY student_id
)
SELECT s.student_id, s.name, sa.avg_marks
FROM students s
JOIN StudentAvg sa ON s.student_id = sa.student_id
WHERE sa.avg_marks > 75;

-- 2. Subject-wise Average Marks

-- Question:
-- Use a CTE to calculate average marks per subject, then list all subjects along with their average marks.


WITH SubjectAvg AS (
    SELECT subject, AVG(marks) AS avg_marks
    FROM marks
    GROUP BY subject
)
SELECT *
FROM SubjectAvg;

-- 🔸 Medium Level-- 
-- 3. Top Scorer per Subject

-- Question:
-- Create a CTE to find the highest marks in each subject, then display the student name and subject who achieved those marks.



WITH MaxMarks AS (
    SELECT subject, MAX(marks) AS top_marks
    FROM marks
    GROUP BY subject
)
SELECT s.name, m.subject, m.marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN MaxMarks mm ON m.subject = mm.subject AND m.marks = mm.top_marks;

-- 4. Students with Above-Overall Average

-- Question:
-- Use a CTE to calculate the overall average marks, then find students whose average marks are above the overall average.

WITH OverallAvg AS (
    SELECT AVG(marks) AS avg_marks
    FROM marks
),
StudentAvg AS (
    SELECT student_id, AVG(marks) AS avg_marks
    FROM marks
    GROUP BY student_id
)
SELECT s.student_id, s.name, sa.avg_marks
FROM StudentAvg sa
JOIN students s ON sa.student_id = s.student_id
JOIN OverallAvg oa ON sa.avg_marks > oa.avg_marks;


-- EASY LEVEL

-- Average marks per student
-- 👉 Create a CTE to calculate average marks of each student, then JOIN with students to show student name and average marks.
With CTE as (Select s.student_id, s.name, avg(m.marks) as avg_marks from  students s join marks m  on m.student_id = s.student_id group by s.student_id, s.name)
Select * from CTE;

With avg_marks_cte as(Select student_id, avg(marks) as avg_marks from marks group by student_id)
Select s.student_id, s.name, a.avg_marks from students s join avg_marks_cte a on s.student_id = a.student_id;


-- Total marks per student
-- 👉 Use a CTE to calculate total marks, then JOIN to display student name and total marks.
With total_marks_cte as (Select student_id, sum(marks) as total_marks from marks group by student_id)
Select s.student_id, s.name, t.total_marks from students s join total_marks_cte t on s.student_id = t.student_id;

-- Subject-wise average marks
-- 👉 Create a CTE for subject-wise average marks and display subject and average.
With subject_avg_marks as(Select subject, avg(marks) as avg_marks from marks group by subject)
Select subject, avg_marks from subject_avg_marks;



-- 🟡 MEDIUM LEVEL

-- Students scoring above their average
-- 👉 Create a CTE to calculate average marks per student, then JOIN it with marks to find subjects where the student scored above their own average.
With avg_marks_per_student as (Select student_id, round(avg(marks),2) as avg_marks from marks group by student_id)
Select m.student_id, m.subject, m.marks, a.avg_marks from marks m join avg_marks_per_student a on m.student_id = a.student_id where m.marks > a.avg_marks;


-- Students who failed in any subject (marks < 60)
-- 👉 Create a CTE to find students who scored below 60, then JOIN with students to display names.
With score_less_cte as(Select student_id, marks from marks where marks < 60)
Select s.student_id, s.name, sc.marks from students s join score_less_cte sc on s.student_id = sc.student_id;

-- 🔴 HARD LEVEL

-- Rank students by average marks
-- 👉 Create a CTE to calculate average marks per student and assign ranks using RANK().
With student_rank as(Select student_id, avg(marks) as avg_marks, rank() over(order by avg(marks) desc) as rn  from marks group by student_id)
Select student_id, avg_marks, rn from student_rank;

-- Subjects where class average is above 75
-- 👉 Use a CTE to calculate subject-wise average, then filter subjects with avg > 75.
With subject_avg as(Select subject, avg(marks) as  avg_marks from marks group by subject)
Select * from subject_avg where avg_marks > 75;

-- Students who scored higher than subject average
-- 👉 Create a CTE to calculate subject average, then JOIN with marks to find students scoring above subject average.
With high_score as(Select subject, avg(marks) as avg_marks from marks group by subject)
Select m.student_id, m.subject, m.marks, h.avg_marks from marks m join high_score h on m.subject = h.subject where m.marks > h.avg_marks;

-- 🟡 Question 1: Top Scorer per Subject

-- 👉 Create a CTE to rank students within each subject based on marks and display only the top scorer(s) per subject.

With top_scorer_student as(Select student_id, subject, marks, rank() over(partition by subject order by marks desc) as student_rank from marks)
Select student_id, subject, marks from top_scorer_student where student_rank = 1;



-- 🔴 Question 2: Students Above Overall Class Average

-- 👉 Create a CTE to calculate the overall class average marks, then find students whose average marks are above the class average.

With class_avg_marks as (Select avg(marks) as overall_avg from marks),
student_avg_marks as (Select student_id, avg(marks) as student_avg from marks group by student_id)
Select s.student_id, s.student_avg from student_avg_marks s cross join class_avg_marks c where s.student_avg > c.overall_avg; 
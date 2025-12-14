SELECT * FROM school_db.marks;
Insert into students values('108', 'Aisha', 'Dehradun');
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

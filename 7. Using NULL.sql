/*
                 teacher
id    dept  name        phone mobile
101   1     Shrivell    2753  07986 555 1234
102   1     Throd       2754  07122 555 1920
103   1     Splint      2293	
104         Spiregrain  3287	
105   2     Cutflower   3212  07996 555 6574
106         Deadyawn    3345  
...

                 dept
id    name
1     Computing
2     Design
3     Engineering
...

*/

-- List the teachers who have NULL for their department

SELECT name 
FROM teacher
WHERE dept IS NULL

-- List all teacher names along with their department names

SELECT teacher.name, dept.name
FROM teacher 
LEFT JOIN dept ON teacher.dept = dept.id

-- Show teacher name, and mobile number or '07986 444 2266' if NULL
/* COALESCE(X,Y,Z) WILL REPLACE X WITH Y IF X = NULL */

SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher

-- Print the teacher name and department name using the string 'None' where there is no department

SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher 
LEFT JOIN dept ON teacher.dept = dept.id

-- Show each department and the number of staff

SELECT dept.name, COUNT(teacher.name)
FROM dept
LEFT JOIN teacher ON dept.id = teacher.dept
GROUP BY dept.name

-- Show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise

SELECT teacher.name, CASE WHEN teacher.dept IN (1, 2) THEN 'Sci' ELSE 'Art' END
FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id

-- Show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise

SELECT teacher.name, CASE WHEN teacher.dept IN (1, 2) THEN 'Sci' WHEN teacher.dept = 3 THEN 'Art' ELSE 'None' END
FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id

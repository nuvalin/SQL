SELECT * FROM teachers
SELECT first_name,last_name FROM teachers
SELECT last_name, first_name 
SELECT last_name, first_name, salary FROM teachers
SELECT school FROM teachers;
SELECT DISTINCT school FROM teachers;
SELECT DISTINCT school, salary FROM  teachers;
SELECT first_name, last_name,salary
FROM teachers
ORDER BY salary DESC;
SELECT last_name, school, hire_date 
FROM teachers ORDER BY school ASC, hire_date DESC;

SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers middle School';

SELECT first_name, last_name, school
FROM teachers
WHERE first_name = 'Janet';

SELECT school
FROM teachers
WHERE school != 'F.D. Roosevelt HS';

SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01';

SELECT first_name, last_name, salary
FROM teachers
WHERE salary >= 43500;

SELECT school, first_name, last_name
FROM teachers
ORDER BY school, last_name;

SELECT first_name, last_name, school, salary
FROM teachers
WHERE first_name LIKE 'S%'
      AND salary > 40000;



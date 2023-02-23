CREATE TABLE departments (
 dept_id bigserial,
 dept varchar(100),
 city varchar(100),
  CONSTRAINT dept_key PRIMARY KEY (dept_id),
  CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
 emp_id bigserial,
 first_name varchar(100),
 last_name varchar(100),
 salary integer,
  dept_id integer REFERENCES departments (dept_id),
  CONSTRAINT emp_key PRIMARY KEY (emp_id),
  CONSTRAINT emp_dept_unique UNIQUE (emp_id, dept_id)
);

INSERT INTO departments (dept, city)
VALUES
 ('Tax', 'Atlanta'),
 ('IT', 'Boston');
 
INSERT INTO employees (first_name, last_name, salary, dept_id)
VALUES
 ('Nancy', 'Jones', 62500, 1),
 ('Lee', 'Smith', 59300, 1),
 ('Soo', 'Nguyen', 83000, 2),
 ('Janet', 'King', 95000, 2);
 
SELECT *FROM departments;

SELECT *
 FROM employees JOIN departments
 ON employees.dept_id = departments.dept_id;
 
 
 CREATE TABLE schools_left (
  id integer CONSTRAINT left_id_key PRIMARY KEY,
 left_school varchar(30)
);

CREATE TABLE schools_right (
  id integer CONSTRAINT right_id_key PRIMARY KEY,
 right_school varchar(30)
);

 INSERT INTO schools_left (id, left_school) VALUES
 (1, 'Oak Street School'),
 (2, 'Roosevelt High School'),
 (5, 'Washington Middle School'),
 (6, 'Jefferson High School');
 
SELECT * FROM schools_left;
SELECT * FROM schools_right;

INSERT INTO schools_right (id, right_school) VALUES
 (1, 'Oak Street School'),
 (2, 'Roosevelt High School'),
 (3, 'Morrison Elementary'),
 (4, 'Chase Magnet Academy'),
 (6, 'Jefferson High School');
 
SELECT *
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id;


SELECT * 
FROM schools_left FULL OUTER JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT * 
FROM schools_left CROSS JOIN schools_right;

SELECT *
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id
WHERE schools_right.id IS NULL;

SELECT *
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id
WHERE schools_left.id IS NULL;

SELECT id 
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT schools_left.id, 
 schools_left.left_school, 
 schools_right.right_school
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id;

CREATE TABLE schools_enrollment (
 id integer,
 enrollment integer
);
CREATE TABLE schools_grades (
 id integer,
 grades varchar(10)
);
INSERT INTO schools_enrollment (id, enrollment) 
VALUES
 (1, 360),
 (2, 1001),
 (5, 450),
 (6, 927);
INSERT INTO schools_grades (id, grades) 
VALUES
 (1, 'K-3'),
 (2, '9-12'),
 (5, '6-8'),
 (6, '9-12');


SELECT lt.id, lt.left_school, en.enrollment, gr.grades
 FROM schools_left AS lt LEFT JOIN schools_enrollment AS en
 ON lt.id = en.id
 LEFT JOIN schools_grades AS gr
 ON lt.id = gr.id;

CREATE TABLE us_counties_2000 (
 geo_name varchar(90),
 state_us_abbreviation varchar(2),
 state_fips varchar(2),
	
	 county_fips varchar(3),
 p0010001 integer,
 p0010002 integer,
 p0010003 integer,
 p0010004 integer,
 p0010005 integer,
 p0010006 integer,
 p0010007 integer,
 p0010008 integer,
 p0010009 integer,
 p0010010 integer,
 p0020002 integer,
 p0020003 integer
);
COPY us_counties_2000
FROM 'C:\Users\HP\Desktop\PostgreSQL\practical-sql-main\Chapter_06\us_counties_2000.csv'
WITH (FORMAT CSV, HEADER);

COPY us_counties_2000
FROM 'C:\YourDirectory\us_counties_2000.csv'
WITH (FORMAT CSV, HEADER);

 SELECT c2010.geo_name,
 c2010.state_us_abbreviation AS state,
 c2010.p0010001 AS pop_2010,
 c2000.p0010001 AS pop_2000,
 c2010.p0010001 - c2000.p0010001 AS raw_change,
  round( (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001) 
 / c2000.p0010001 * 100, 1 ) AS pct_change
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000
 ON c2010.state_fips = c2000.state_fips
 AND c2010.county_fips = c2000.county_fips
  AND c2010.p0010001 <> c2000.p0010001
ORDER BY pct_change DESC;

SELECT * FROM us_counties_2000;


SELECT pls14.stabr,
       sum(pls14.gpterms) AS gpterms_2014,
       sum(pls09.gpterms) AS gpterms_2009,
       round( (CAST(sum(pls14.gpterms) AS decimal(10,1)) - sum(pls09.gpterms)) /
                    sum(pls09.gpterms) * 100, 2 ) AS pct_change
FROM pls_fy2014_pupld14a pls14 JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.gpterms >= 0 AND pls09.gpterms >= 0
GROUP BY pls14.stabr
ORDER BY pct_change DESC;


CREATE TABLE obereg_codes (
    obereg varchar(2) CONSTRAINT obereg_key PRIMARY KEY,
    region varchar(50)
);

INSERT INTO obereg_codes
VALUES ('01', 'New England (CT ME MA NH RI VT)'),
       ('02', 'Mid East (DE DC MD NJ NY PA)'),
       ('03', 'Great Lakes (IL IN MI OH WI)'),
       ('04', 'Plains (IA KS MN MO NE ND SD)'),
       ('05', 'Southeast (AL AR FL GA KY LA MS NC SC TN VA WV)'),
       ('06', 'Soutwest (AZ NM OK TX)'),
       ('07', 'Rocky Mountains (CO ID MT UT WY)'),
       ('08', 'Far West (AK CA HI NV OR WA)'),
       ('09', 'Outlying Areas (AS GU MP PR VI)');

SELECT pls14.libname, pls14.city, pls14.stabr, pls14.statstru, pls14.c_admin, pls14.branlib,
       pls09.libname, pls09.city, pls09.stabr, pls09.statstru, pls09.c_admin, pls09.branlib
FROM pls_fy2014_pupld14a pls14 FULL OUTER JOIN pls_fy2009_pupld09a pls09
ON pls14.fscskey = pls09.fscskey
WHERE pls14.fscskey IS NULL OR pls09.fscskey IS NULL;
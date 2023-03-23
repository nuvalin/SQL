CREATE TABLE employees(
emp_id bigserial CONSTRAINT emp_id_key PRIMARY KEY,
first_name varchar(50) NOT NULL,
last_name varchar(50) NOT NULL,
gender char(1) NOT NULL,
address varchar(50) UNIQUE NOT NULL,
email varchar(50) UNIQUE NOT NULL,
depart_id bigint REFERENCES departments(depart_id)ON DELETE CASCADE, 
role_id bigint REFERENCES roles (role_id)ON DELETE CASCADE, 
salary_id bigint REFERENCES salaries (salary_id)ON DELETE CASCADE,   
overtime_id bigint REFERENCES overtime_hours (overtime_id)ON DELETE CASCADE  
);	



INSERT INTO employees ( first_name,last_name,gender,address,email,depart_id,role_id,salary_id,overtime_id)

VALUES
 ('Nancy','Jones','f','33 Virgil Street','nancy@gmail.com',1,NULL,1,1 ),
 ('Lee', 'Smith', 'm','43 Duck Creek Road','lee@gmail.com',2,2,2,2 ),
 ('Soo', 'Nguyen', 'm','5 Austin Avenue','soo@gmail.com',3,3,3,NULL ),
 ('Janet', 'King','f', '87 pland Avenue','janet@gmail.com',4,4,NULL,4);
 


CREATE TABLE departments(
depart_id bigserial CONSTRAINT department_id_key PRIMARY KEY, 
depart_name varchar(20), 
depart_city varchar(20)
);


INSERT INTO departments( depart_name,depart_city
)						


VALUES
('Healthcare','Pietermaritzburg'),
('Food_service','East_london'),
('Hospitality', 'Durban'),
('Finance', 'Alberton');



CREATE TABLE roles(
role_id bigserial CONSTRAINT role_id_key PRIMARY KEY,
role varchar(30)
);


INSERT INTO roles ( role)

VALUES
('Anaesthetist'),
('planning_menus'),
('Housekeeper'),
('Risk_Analyst');



CREATE TABLE salaries(
salary_id bigserial CONSTRAINT salary_id_key PRIMARY KEY,
salary_pa varchar
);


INSERT INTO salaries(salary_pa)

VALUES
('R634,396'),
('R173,338'),
('R5,3315'),
('R600,000');




CREATE TABLE overtime_hours(
overtime_id bigserial CONSTRAINT overtime_id_key PRIMARY KEY,
overtime_hours varchar(20)
);


INSERT INTO overtime_hours(overtime_hours)

VALUES
('5hr'),
('6hr'),
('3hr'),
('2hr');

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM roles;
SELECT * FROM salaries;
SELECT * FROM overtime_hours; 

SELECT depart_name AS department_name, role AS job_title, salary_pa as salary, overtime_hours
FROM employees emp
LEFT JOIN departments ON departments.depart_id = emp.depart_id
LEFT JOIN roles ON roles.role_id = emp.role_id
LEFT JOIN salaries ON salaries.salary_id = emp.salary_id
LEFT JOIN overtime_hours ON overtime_hours.overtime_id = emp.overtime_id;


DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS overtime_hours;
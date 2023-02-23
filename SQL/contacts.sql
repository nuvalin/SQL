CREATE TABLE my_contacts(
contact_id BIGSERIAL CONSTRAINT contact_id_key PRIMARY KEY,
last_name VARCHAR(30) NOT NULL,
first_name VARCHAR(30) NOT NULL,
gender VARCHAR(30) NOT NULL,
phone VARCHAR(10) UNIQUE NOT NULL,
email VARCHAR(30) UNIQUE NOT NULL,
zip_code_id BIGINT REFERENCES zip_codes(zip_code_id),
status VARCHAR(30) NOT NULL,	
profession VARCHAR(30) NOT NULL,
seeking1 VARCHAR(30) NOT NULL,
seeking2 VARCHAR(30) NOT NULL,
seeking3 VARCHAR(30) NOT NULL,
interest1 VARCHAR(30) NOT NULL,
interest2 VARCHAR(30) NOT NULL,
interest3 VARCHAR(30) NOT NULL	
)
 SELECT * FROM my_contacts;
 DELETE * FROM my_contacts;
 
  INSERT INTO my_contacts
(
 last_name,
 first_name,
 gender, 
 phone, 
 email,
 zip_code_id,
 status,	
 profession, 
 seeking1, 
 seeking2,
 seeking3, 
 interest1,
 interest2, 
 interest3
)	

VALUES
('Tom','Smith','female','0780615009','tom@gmail.com',1,'single','doctor','single male','same profession','over 50','hiking','reading','biking'),
('Gugu','Ndaba','female','0780615012','gugu@gmail.com',2,'divorced','teacher','single male','employed','under 25','hiking','cooking','running'),
('Jo','Nala','male','0780615078','jo@gmail.com',1,'single','software developer','single female','same profession','over 50','hiking','diving','biking'),
('Mary','Smith','female','0610615009','mary@gmail.com',2,'divorced','student','single male','student','under 50','studying','reading','cycling'),
('Kyle','Koo','male','0710615009','kyle@gmail.com',1,'divorced','doctor','single female','same profession','over 50','art','reading','cycling'),
('Sizwe','Nchabe','male','0840615099','sizwe@gmail.com',3,'single','softwnare developer','single female','same profession','under 25','hiking','reading','biking'),
('Liz','Sun','female','0830777009','liz@gmail.com',3,'single','teacher','single male','retired','over 50','walkimg','reading','cooking');

SELECT * FROM my_contacts;

DELETE * FROM my_contacts;



     CREATE TABLE zip_codes
	(
     zip_code_id BIGSERIAL CONSTRAINT zip_code_key PRIMARY KEY,
	 zip_code CHAR(11) NOT NULL,
	 city VARCHAR(30) NOT NULL,
     state_name VARCHAR(30)NOT NULL,
     state_abbr CHAR(11) NOT NULL
    )
    
INSERT INTO zip_codes
(
zip_code,
city,
state_name,
state_abbr
)
	
VALUES
('36013-36191','Mongomery','Alabama','AL'),
('99703-99781','Fairbanks','Alaska','AK'),
('85641-85705','Tucson','Arizona','AR');
	
 SELECT * FROM zip_codes;
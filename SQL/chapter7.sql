CREATE TABLE natural_key_example (
  license_id varchar(10) CONSTRAINT license_key PRIMARY KEY,
 first_name varchar(50),
 last_name varchar(50)
);

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Sam', 'Tracy');

CREATE TABLE natural_key_composite_example (
 student_id varchar(10),
 school_day date,
 present boolean,
 CONSTRAINT student_key PRIMARY KEY (student_id, school_day) 
	
	INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '1/22/2017', 'Y');
	
INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '1/23/2017', 'Y');
	
INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '1/23/2017', 'N');
	
CREATE TABLE surrogate_key_example (
  order_number bigserial,
 product_name varchar(50),
 order_date date,
  CONSTRAINT order_key PRIMARY KEY (order_number) 
);
	
	 INSERT INTO surrogate_key_example (product_name, order_date)
VALUES ('Beachball Polish', '2015-03-17'),
 ('Wrinkle De-Atomizer', '2017-05-22'),
 ('Flux Capacitor', '1985-10-26');
	
	SELECT * FROM surrogate_key_example;
	
CREATE TABLE licenses (
 license_id varchar(10),
 first_name varchar(50),
 last_name varchar(50),
  CONSTRAINT licenses_key PRIMARY KEY (license_id)
);

CREATE TABLE registrations (
 registration_id varchar(10),
 registration_date date,
  license_id varchar(10) REFERENCES licenses (license_id),
 CONSTRAINT registration_key PRIMARY KEY (registration_id, license_id)
);	

DROP TABLE registrations;
INSERT INTO licenses (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');
	
INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A203391', '2017/3/17', 'T229901');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A75772', '2017/3/17', 'T000001');	
	
SELECT * FROM registration;	

	CREATE TABLE check_constraint_example (
 user_id bigserial,
 user_role varchar(50),
 salary integer,
 CONSTRAINT user_id_key PRIMARY KEY (user_id),
  CONSTRAINT check_role_in_list CHECK (user_role IN('Admin', 'Staff')),
  CONSTRAINT check_salary_not_zero CHECK (salary > 0)
);

	
INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A203391', '2017/3/17', 'T229901');

CREATE TABLE unique_constraint_example (
 contact_id bigserial CONSTRAINT contact_id_key PRIMARY KEY,
first_name varchar(50),
 last_name varchar(50),
 email varchar(200),
  CONSTRAINT email_unique UNIQUE (email) 
);	

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Samantha', 'Lee', 'slee@example.org');	
	
INSERT INTO unique_constraint_example (first_name, last_name, email)
 VALUES ('Sasha', 'Lee', 'slee@example.org');	

CREATE TABLE not_null_example (
 student_id bigserial,
 first_name varchar(50) NOT NULL,
 last_name varchar(50) NOT NULL,
 CONSTRAINT student_id_key PRIMARY KEY (student_id)
);	


ALTER TABLE table_name ALTER COLUMN first_name DROP NOT NULL;
	
CREATE TABLE new_york_addresses (
 longitude numeric(9,6), 
 latitude numeric(9,6), 
street_number varchar(10), 
 street varchar(32), 
 unit varchar(7), 
 postcode varchar(5), 
 id integer CONSTRAINT new_york_key PRIMARY KEY
);

	COPY new_york_addresses
FROM 'C:\Users\HP\Desktop\PostgreSQL\practical-sql-main\Chapter_07\city_of_new_york.csv'
WITH (FORMAT CSV, HEADER);

	EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';


CREATE TABLE albums (
 album_id bigserial,
 album_catalog_code varchar(100),
 album_title text NOT NULL ,
 album_artist text NOT NULL,
 album_release_date date,
 album_genre varchar(40),
 album_description text
 CONSTRAINT album_id_key PRIMARY KEY (album_id),
 CONSTRAINT release_date_check CHECK (album_release_date > '1/1/1925')
);

	CREATE TABLE songs (
 song_id bigserial,
 song_title text,
 song_artist text,
 album_id bigint REFERENCES albums (album_id),
CONSTRAINT song_id_key PRIMARY KEY (song_id)
);
	
	
CREATE TABLE my_contacts(
contact_id BIGSERIAL CONSTRAINT contact_id_key PRIMARY KEY,
last_name VARCHAR(30) NOT NULL,
first_name VARCHAR(30) NOT NULL,
phone varchar(13),
email varchar(30),
gender char(1),
birthday date,
prof_id integer REFERENCES professions(prof_id) ON DELETE CASCADE,
zip_code char(4) REFERENCES zip_codes(zip_code) ON DELETE CASCADE,
status_id integer REFERENCES statuses(status_id) ON DELETE CASCADE
);

INSERT INTO my_contacts (last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id)
VALUES
('Melton','Morgan','0780615009','melton@gmail.com','M','1995-01-09',2,'4378',4),
('Chambers','Gregory','0780615012','gregory@gmail.com','M','1959-03-17',5,'5321',1),
('Durham','Jason','0780615078','jason@gmail.com','M','1987-01-06',8,'9865',3),
('Pruitt','Marshall','0610615009','puitt@gmail.com','M','1986-08-24',3,'3487',6),
('Sweeney','Courtney','0710615009','court@gmail.com','F','1963-02-11',5,'6005',2),
('Moody','Sufyan','0840615099','moo@gmail.com','F','1977-03-12',3,'5367',5),
('Mayer','Hanna','0830777009','hanna@gmail.com','F','1969-04-10',1,'7894',1),
('Tom','Smith','0780615009','tom@gmail.com','M','1969-02-12',10,'4389',1),
('Gugu','Ndaba','0780615012','gugu@gmail.com','F','1983-02-23',3,'9007',5),
('Jo','Nala','0780615078','jo@gmail.com','M','1999-11-30',9,'5000',3),
('Mary','Smith','0610615009','mary@gmail.com','F','1993-06-20',1,'9008',6),
('Kyle','Koo','0710615009','kyle@gmail.com','M','1986-04-24',3,'4358',2),
('Sizwe','Nchabe','0840615099','sizwe@gmail.com','M','1983-12-11',4,'6509',4),
('Liz','Sun','0830777009','liz@gmail.com','F','1939-01-24',1,'4378',3),
('Wilber','Stacey','0845766008','stacey@hotmail.co.za','F','1991-07-24',7,'5009',1),
('Boyles','Ted','0743000543','ted@outlook.com','M','1968-03-27',6,'9007',2),
('Harrel','Maria','086598721','maria@outlook.co.za','F','2001-04-02',2,'7007',4);

SELECT * FROM my_contacts;
 
CREATE TABLE interests(
interest_id bigserial CONSTRAINT interest_id_key PRIMARY KEY,
interest varchar(50)UNIQUE NOT NULL
); 
 

INSERT INTO interests(interest)
VALUES 
('clubing'),
('exercise'),
('cooking'),
('politics'),
('photography'),
('sports'),
('learning'),
('traveling'),
('dancing'),
('doing stuff'), 
('pets'),
('art'),
('music'),
('outdoors');
  
SELECT * FROM interests;

 CREATE TABLE contact_interest(
contact_id bigint REFERENCES my_contacts(contact_id),
interest_id bigint REFERENCES interests(interest_id)
);
 
INSERT INTO contact_interest
(contact_id, interest_id)
VALUES
(1,14),
(1,8),
(1,5),
(2,7),
(2,10),
(2,1),
(3,9),
(3,4),
(3,5),
(4,6),
(4,3),
(4,1),
(5,1),
(5,7),
(5,8),
(6,2),
(6,4),
(6,11),
(7,2),
(7,9),
(7,12),
(8,5),
(8,8),
(8,3),
(9,2),
(9,1),
(9,13),
(10,12),
(10,14),
(10,1),
(11,6),
(11,13),
(11,4),
(12,6),
(12,9),
(12,10),
(13,14),
(13,5),
(13,1),
(14,2),
(14,5),
(14,3),
(15,7),
(15,3),
(15,7),
(16,12),
(16,1),
(16,2),
(17,2),
(17,9),
(17,11);

 
CREATE TABLE zip_codes(
zip_code char(4) PRIMARY KEY CHECK (LENGTH(zip_code)=4),
city varchar(30)NOT NULL,
province varchar(30)NOT NULL
);

INSERT INTO zip_codes(
zip_code,
city,
province
)
VALUES
('4378','Johannesburg','Gauteng'),
('4389', 'Soweto','Gauteng'), 
('5009','Durban','KwaZulu-Natal'),
('7007','Pietermaritzburg','KwaZulu-Natal'),
('5321', 'Stellenbosch','Western cape:'),
('4358','Cape Town','Western cape:'),
('9865','Rustenburg','North West'),
('9007' ,'Vryburg', 'North West'),
('6005','Bloemfontein','Free State'),
('3487' ,'Welkom','Free State'),
('9008','Pietersburg','Limpopo'),
('5134', 'Polokwane','Limpopo'),
('5000','Mbombela','Mpumalanga'),
('8732', 'Lydenburg','Mpumalanga'),
('7894','Kimberley','Northern cape'),
('5367' ,'Upington','Northern cape'),
('6983','Port Elizabeth','Eastern cape'),
('6509' ,'East London','Eastern cape');
 
 SELECT * FROM zip_codes;
 
CREATE TABLE professions (
prof_id bigserial CONSTRAINT professions_id_key PRIMARY KEY,
profession varchar(30) NOT NULL,
constraint profession UNIQUE (profession)
);

INSERT INTO professions (profession)
VALUES
('dentist'),
('actor'),
('cashier'),
('barber'),
('lawyer'),
('plumber'),
('accountant'),
('nurse'),
('scientist'),
('flight attendant');
 
SELECT * FROM professions;

CREATE TABLE statuses(
status_id bigserial CONSTRAINT status_id_key_2 PRIMARY KEY,
status varchar(30)UNIQUE NOT NULL
);
 
INSERT INTO statuses(status)
VALUES
('open_relationship'),
('single'),
('married'),
('engaged'),
('divorced'),
('complicated_relationship');

SELECT * FROM statuses;

CREATE TABLE seekings(
seeking_id bigserial CONSTRAINT seeking_id_key PRIMARY KEY,
seeking varchar(50) UNIQUE NOT NULL
);

INSERT INTO seekings(
seeking) 

VALUES
('single woman'),
('single man'),
('under 30'),
('over 50'),
('under 40');
 
 SELECT * FROM seekings;
 
CREATE TABLE contact_seeking(
contact_id bigint REFERENCES my_contacts(contact_id)ON DELETE CASCADE,
seeking_id bigint REFERENCES seekings(seeking_id)ON DELETE CASCADE
);

INSERT INTO contact_seeking(
contact_id, seeking_id)
VALUES
(1,1),
(1,4),
(2,5),
(2,1),
(3,1),
(3,1),
(4,5),
(4,3),
(5,1),
(5,4),
(6,5),
(6,2),
(7,2),
(7,4),
(8,2),
(8,5),
(9,2),
(9,1),
(10,2),
(10,5),
(11,1),
(11,1),
(12,2),
(12,3),
(13,5),
(13,5),
(14,2),
(14,5),
(15,3),
(15,3),
(16,2),
(16,1),
(17,4),
(17,5);

SELECT prof.profession, zc.zip_code, zc.city, zc.province, st.status, inte.interest,se.seeking
FROM my_contacts mc
LEFT JOIN professions prof
ON mc.prof_id = prof.prof_id
JOIN zip_codes zc
ON zc.zip_code = mc.zip_code
JOIN statuses st
ON st.status_id = mc.status_id
JOIN contact_seeking cs
ON cs.contact_id = mc.contact_id
JOIN seekings se
ON se.seeking_id = cs.seeking_id
JOIN contact_interest ci
ON ci.contact_id = mc.contact_id
JOIN interests inte
ON ci.interest_id = inte.interest_id;


DROP TABLE IF EXISTS my_contacts;
DROP TABLE zip_codes;
DROP TABLE professions;
DROP TABLE statuses;
DROP TABLE seekings;
DROP TABLE interests;
DROP TABLE contact_seeking;
DROP TABLE contact_interest;
 

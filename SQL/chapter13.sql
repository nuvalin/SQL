SELECT upper('nuvalin');
Select  char_length(' Pat ');
SELECT position(', ' in 'Tan, 
Bella'); 
SELECT trim('s' from 'socks');
SELECT char_length(trim(' Pat '));
SELECT rtrim('socks','s');
SELECT ltrim('socks','s');
SELECT left('703-555-1212',3);
SELECT  replace('bat', 'b', 'c'); 
SELECT substring('The game starts at 7 p.m. on May 2, 2019.' from '\d{4}');

CREATE TABLE crime_reports(
crime_id bigserial PRIMARY KEY,
date_1 timestamp with time zone,
date_2 timestamp with time zone,
street varchar(250),
city varchar(100),
crime_type varchar(100),
description text,
case_number varchar(50),
original_text text NOT NULL
);

COPY crime_reports (original_text)
FROM 'C:\Users\HP\Documents\Bootcamp\1_SQL\PostgreSQL\practical-sql-main\Chapter_13\crime_reports.csv'
WITH (FORMAT CSV, HEADER OFF, QUOTE '"');

SELECT * FROM crime_reports;
SELECT original_text FROM crime_reports;

SELECT crime_id,
 regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}')
FROM crime_reports;

SELECT crime_id,
 regexp_matches(original_text, '\d{1,2}\/\d{1,2}\/\d{2}', 'g')
FROM crime_reports;

SELECT crime_id,
 regexp_match(original_text, '-\d{1,2}\/\d{1,2}\/\d{2}')
FROM crime_reports;

SELECT crime_id,
 regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})')
FROM crime_reports

SELECT 
 regexp_match(original_text, '(?:C0|SO)[0-9]+') AS case_number,
 regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}') AS date_1,
 regexp_match(original_text, '\n(?:\w+ \w+|\w+)\n(.*):') AS crime_type,
 regexp_match(original_text, '(?:Sq.|Plz.|Dr.|Ter.|Rd.)\n(\w+ \w+|\w+)\n')
 AS city
FROM crime_reports;

SELECT 
 crime_id,
  (regexp_match(original_text, '(?:C0|SO)[0-9]+'))[1]
 AS case_number
FROM crime_reports;

UPDATE crime_reports
 SET date_1 =
(
  (regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1] 
  || ' ' ||
  (regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1] 
  ||' US/Eastern'
 )::timestamptz;
SELECT crime_id,
 date_1,
 original_text
FROM crime_reports;


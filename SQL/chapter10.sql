CREATE TABLE acs_2011_2015_stats (
  geoid varchar(14) CONSTRAINT geoid_key PRIMARY KEY,
 county varchar(50) NOT NULL,
 st varchar(20)NOT NULL,
  pct_travel_60_min numeric(5,3) NOT NULL,
 pct_bachelors_higher numeric(5,3) NOT NULL,
 pct_masters_higher numeric(5,3) NOT NULL,
 median_hh_income integer,
  CHECK (pct_masters_higher <= pct_bachelors_higher)
);

COPY acs_2011_2015_stats
FROM 'C:\Users\HP\Desktop\PostgreSQL\practical-sql-main\Chapter_10\acs_2011_2015_stats.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT corr(median_hh_income, pct_bachelors_higher) 
 AS bachelors_income_r
FROM acs_2011_2015_stats

SELECT
  round(
 corr(median_hh_income, pct_bachelors_higher)::numeric, 2
 ) AS bachelors_income_r,

 round(
 corr(pct_travel_60_min, median_hh_income)::numeric, 2
 ) AS income_travel_r,
 round(
 corr(pct_travel_60_min, pct_bachelors_higher)::numeric, 2
 ) AS bachelors_travel_r
FROM acs_2011_2015_stats;

SELECT
 round(
 regr_slope(median_hh_income, pct_bachelors_higher)::numeric, 2
 ) AS slope,
 round(
 regr_intercept(median_hh_income, pct_bachelors_higher)::numeric, 2
 ) AS y_intercept
FROM acs_2011_2015_stats;

SELECT round(
 regr_r2(median_hh_income, pct_bachelors_higher)::numeric, 3
 ) AS r_squared 
FROM acs_2011_2015_stats;

CREATE TABLE widget_companies (
 id bigserial,
 company varchar(30) NOT NULL,
 widget_output integer NOT NULL
);

INSERT INTO widget_companies (company, widget_output)
VALUES
 ('Morse Widgets', 125000),
 ('Springfield Widget Masters', 143000),
 ('Best Widgets', 196000),
 ('Acme Inc.', 133000),
 ('District Widget Inc.', 201000),
 ('Clarke Amalgamated', 620000),
 ('Stavesacre Industries', 244000),
 ('Bowers Widget Emporium', 201000);

SELECT 
 company,
 widget_output,
  rank() OVER (ORDER BY widget_output DESC),
 dense_rank() OVER (ORDER BY widget_output DESC)
FROM widget_companies;

CREATE TABLE store_sales (
 store varchar(30),
 category varchar(30) NOT NULL,
 unit_sales bigint NOT NULL,
 CONSTRAINT store_category_key PRIMARY KEY (store, category)
	
INSERT INTO store_sales (store, category, unit_sales)
VALUES
 ('Broders', 'Cereal', 1104),
 ('Wallace', 'Ice Cream', 1863),
 ('Broders', 'Ice Cream', 2517),
 ('Cramers', 'Ice Cream', 2112),
 ('Broders', 'Beer', 641),
 ('Cramers', 'Cereal', 1003),
 ('Cramers', 'Beer', 640),
 ('Wallace', 'Cereal', 980),
 ('Wallace', 'Beer', 988);

	SELECT 
 category,
 store,
 unit_sales,
  rank() OVER (PARTITION BY category ORDER BY unit_sales DESC)
FROM store_sales;

	CREATE TABLE fbi_crime_data_2015 (
 st varchar(20),
 city varchar(50),
 population integer,
 violent_crime integer,
 property_crime integer,
 burglary integer,
larceny_theft integer,
 motor_vehicle_theft integer,
 CONSTRAINT st_city_key PRIMARY KEY (st, city)
);
	
COPY fbi_crime_data_2015
FROM 'C:\Users\HP\Desktop\PostgreSQL\practical-sql-main\Chapter_10\fbi_crime_data_2015.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');


SELECT CITY, ST,
	POPULATION,
	PROPERTY_CRIME,
	ROUND((PROPERTY_CRIME::numeric / POPULATION) * 1000,
		1) AS PC_PER_1000
FROM FBI_CRIME_DATA_2015
WHERE POPULATION >= 500000
ORDER BY (PROPERTY_CRIME::numeric / POPULATION) DESC;


SELECT
round(
corr(median_hh_income, pct_bachelors_higher)::numeric, 2
 ) AS bachelors_income_r,
round(
corr(median_hh_income, pct_masters_higher)::numeric, 2
 ) AS masters_income_r
FROM acs_2011_2015_stats;

SELECT CITY, ST,
	POPULATION,
	MOTOR_VEHICLE_THEFT,
	ROUND((MOTOR_VEHICLE_THEFT::numeric / POPULATION) * 100000,
		1) AS VEHICLE_THEFT_PER_100000
FROM FBI_CRIME_DATA_2015
WHERE POPULATION >= 500000
ORDER BY VEHICLE_THEFT_PER_100000 DESC;
	

SELECT CITY, ST,
	POPULATION,
	VIOLENT_CRIME,
	ROUND((VIOLENT_CRIME::numeric / POPULATION) * 100000,
		1) AS VIOLENT_CRIME_PER_100000
FROM FBI_CRIME_DATA_2015
WHERE POPULATION >= 500000
ORDER BY VIOLENT_CRIME_PER_100000 DESC;

SELECT LIBNAME,
STABR,
VISITS,
POPU_LSA,
ROUND((VISITS::numeric / POPU_LSA) * 1000,
1) AS VISITS_PER_1000,
RANK() OVER (
ORDER BY (VISITS::numeric / POPU_LSA) * 1000 DESC)
FROM pls_fy2014_pupld14a
WHERE POPU_LSA >= 250000;


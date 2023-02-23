CREATE TABLE current_time_example (
 time_id bigserial,
  current_timestamp_col timestamp with time zone,
 clock_timestamp_col timestamp with time zone
);

INSERT INTO current_time_example (current_timestamp_col, clock_timestamp_col)
  (SELECT current_timestamp,
 clock_timestamp()
 FROM generate_series(1,1000));

SELECT * FROM current_time_example;

SHOW timezone;

CREATE TABLE nyc_yellow_taxi_trips_2016_06_01 (
 trip_id bigserial PRIMARY KEY,
 vendor_id varchar(1) NOT NULL,
 tpep_pickup_datetime timestamp with time zone NOT NULL,
 tpep_dropoff_datetime timestamp with time zone NOT NULL,
 passenger_count integer NOT NULL,
 trip_distance numeric(8,2) NOT NULL,
 pickup_longitude numeric(18,15) NOT NULL,
 pickup_latitude numeric(18,15) NOT NULL,
 rate_code_id varchar(2) NOT NULL,
 store_and_fwd_flag varchar(1) NOT NULL,
 dropoff_longitude numeric(18,15) NOT NULL,
 dropoff_latitude numeric(18,15) NOT NULL,
 payment_type varchar(1) NOT NULL,
 fare_amount numeric(9,2) NOT NULL,
 extra numeric(9,2) NOT NULL,
 mta_tax numeric(5,2) NOT NULL,
 tip_amount numeric(9,2) NOT NULL,
 tolls_amount numeric(9,2) NOT NULL,
 improvement_surcharge numeric(9,2) NOT NULL,
 total_amount numeric(9,2) NOT NULL
);

 COPY nyc_yellow_taxi_trips_2016_06_01 (
 vendor_id,
 tpep_pickup_datetime,
 tpep_dropoff_datetime,
 passenger_count,
 trip_distance,
 pickup_longitude,
 pickup_latitude,
 rate_code_id,
 store_and_fwd_flag,
 dropoff_longitude,
 dropoff_latitude,
 payment_type,
 fare_amount,
 extra,
 mta_tax,
 tip_amount,
 tolls_amount,
 improvement_surcharge,
 total_amount 
 )

FROM'C:\Users\HP\Desktop\PostgreSQL\practical-sql-main\Chapter_11\yellow_tripdata_2016_06_01.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

CREATE INDEX tpep_pickup_idx 
ON nyc_yellow_taxi_trips_2016_06_01 (tpep_pickup_datetime);

SELECT count(*) FROM nyc_yellow_taxi_trips_2016_06_01;

SET timezone TO 'US/Eastern';

SELECT
  date_part('hour', tpep_pickup_datetime) AS trip_hour,
  count(*)
FROM nyc_yellow_taxi_trips_2016_06_01
GROUP BY trip_hour
ORDER BY trip_hour


COPY 
 (SELECT
 date_part('hour', tpep_pickup_datetime) AS trip_hour,
 count(*)
 FROM nyc_yellow_taxi_trips_2016_06_01

SELECT
  date_part('hour', tpep_pickup_datetime) AS trip_hour,
  percentile_cont(.5)
  WITHIN GROUP (ORDER BY
 tpep_dropoff_datetime - tpep_pickup_datetime) AS median_trip
FROM nyc_yellow_taxi_trips_2016_06_01
GROUP BY trip_hour
ORDER BY trip_hour;
  
  
 SET timezone TO 'US/Central';
CREATE TABLE train_rides (
 trip_id bigserial PRIMARY KEY,
 segment varchar(50) NOT NULL,
 departure timestamp with time zone NOT NULL,
 arrival timestamp with time zone NOT NULL
); 
  
  SELECT
    trip_id,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    tpep_dropoff_datetime - tpep_pickup_datetime AS length_of_ride
FROM nyc_yellow_taxi_trips_2016_06_01
ORDER BY length_of_ride DESC;
  
  SELECT '2100-01-01 00:00:00-05' AT TIME ZONE 'US/Eastern' AS new_york,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Europe/London' AS london,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Africa/Johannesburg' AS johannesburg,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Europe/Moscow' AS moscow,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Australia/Melbourne' AS melbourne;

  
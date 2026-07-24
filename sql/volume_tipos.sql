-- Carrega a tabela principal
CREATE OR REPLACE TABLE raw_taxi AS SELECT * FROM read_parquet('data/yellow_tripdata_2024-01.parquet');

-- Carrega a tabela de referência (para traduzir códigos de localização) 
CREATE OR REPLACE TABLE raw_taxi_zone AS SELECT * FROM read_csv_auto('data/taxi_zone_lookup.csv');

-- Volume total de linhas
SELECT COUNT(*) AS total_linhas FROM raw_taxi;

-- Tipos inferidos pelo DuckDB para cada coluna 
DESCRIBE raw_taxi; 

-- Volume (linhas não nulas) por coluna 
SELECT COUNT(*) AS total_linhas, 
COUNT(VendorID) AS vendorid_preenchidos, 
COUNT(tpep_pickup_datetime) AS pickup_preenchidos, COUNT(tpep_dropoff_datetime) AS dropoff_preenchidos, COUNT(passenger_count) AS passenger_count_preenchidos, COUNT(trip_distance) AS trip_distance_preenchidos, COUNT(RatecodeID) AS ratecodeid_preenchidos, 
COUNT(store_and_fwd_flag) AS store_and_fwd_flag_preenchidos, COUNT(PULocationID) AS pulocationid_preenchidos, 
COUNT(DOLocationID) AS dolocationid_preenchidos,
COUNT(payment_type) AS payment_type_preenchidos, 
COUNT(fare_amount) AS fare_amount_preenchidos, 
COUNT(extra) AS extra_preenchidos, COUNT(mta_tax) AS mta_tax_preenchidos, COUNT(tip_amount) AS tip_amount_preenchidos, 
COUNT(tolls_amount) AS tolls_amount_preenchidos, COUNT(improvement_surcharge) AS improvement_surcharge_preenchidos, COUNT(total_amount) AS total_amount_preenchidos, COUNT(congestion_surcharge) AS congestion_surcharge_preenchidos, COUNT(Airport_fee) AS airport_fee_preenchidos FROM raw_taxi; 

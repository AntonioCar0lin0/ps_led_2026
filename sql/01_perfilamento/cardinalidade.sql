-- Cardinalidade de todas as colunas de raw_taxi 
SELECT COUNT(*) AS total_linhas,
COUNT(DISTINCT VendorID) AS card_vendorid, 
COUNT(DISTINCT tpep_pickup_datetime) AS card_pickup_datetime, COUNT(DISTINCT tpep_dropoff_datetime) AS card_dropoff_datetime, COUNT(DISTINCT passenger_count) AS card_passenger_count, COUNT(DISTINCT trip_distance) AS card_trip_distance, 
COUNT(DISTINCT RatecodeID) AS card_ratecodeid, 
COUNT(DISTINCT store_and_fwd_flag) AS card_store_and_fwd_flag, COUNT(DISTINCT PULocationID) AS card_pulocationid, 
COUNT(DISTINCT DOLocationID) AS card_dolocationid,
COUNT(DISTINCT payment_type) AS card_payment_type, COUNT(DISTINCT fare_amount) AS card_fare_amount, 
COUNT(DISTINCT extra) AS card_extra, 
COUNT(DISTINCT mta_tax) AS card_mta_tax, 
COUNT(DISTINCT tip_amount) AS card_tip_amount,
COUNT(DISTINCT tolls_amount) AS card_tolls_amount, 
COUNT(DISTINCT improvement_surcharge) AS card_improvement_surcharge, COUNT(DISTINCT total_amount) AS card_total_amount, 
COUNT(DISTINCT congestion_surcharge) AS card_congestion_surcharge, COUNT(DISTINCT Airport_fee) AS card_airport_fee FROM raw_taxi; 

-- Cardinalidade da tabela de referência de zonas 
SELECT COUNT(*) AS total_zonas, 
COUNT(DISTINCT LocationID) AS card_locationid, 
COUNT(DISTINCT Borough) AS card_borough, 
COUNT(DISTINCT Zone) AS card_zone, 
COUNT(DISTINCT service_zone) AS card_service_zone FROM raw_taxi_zone; 

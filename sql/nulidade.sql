-- Carrega a tabela principal
CREATE OR REPLACE TABLE raw_taxi AS SELECT * FROM read_parquet('data/yellow_tripdata_2024-01.parquet');

-- Carrega a tabela de referência (para traduzir códigos de localização) 
CREATE OR REPLACE TABLE raw_taxi_zone AS SELECT * FROM read_csv_auto('data/taxi_zone_lookup.csv');

-- Quais colunas têm valores nulos, e em que proporção?
SELECT 
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE passenger_count IS NULL) AS nulos_passenger_count,
    COUNT(*) FILTER (WHERE RatecodeID IS NULL) AS nulos_ratecodeid,
    COUNT(*) FILTER (WHERE store_and_fwd_flag IS NULL) AS nulos_store_fwd_flag,
    COUNT(*) FILTER (WHERE congestion_surcharge IS NULL) AS nulos_congestion,
    COUNT(*) FILTER (WHERE Airport_fee IS NULL) AS nulos_airport_fee
FROM raw_taxi;

-- Cruzamento com VendorID
SELECT 
    VendorID,
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE passenger_count IS NULL) AS nulos
FROM raw_taxi
GROUP BY VendorID
ORDER BY VendorID;


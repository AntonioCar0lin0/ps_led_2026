-- Carrega a tabela principal
CREATE OR REPLACE TABLE raw_taxi AS SELECT * FROM read_parquet('data/01_raw/yellow_tripdata_2024-01.parquet');

-- Carrega a tabela de referência (para traduzir códigos de localização) 
CREATE OR REPLACE TABLE raw_taxi_zone AS SELECT * FROM read_csv_auto('data/01_raw/taxi_zone_lookup.csv');

-- Cria a tabela para ser usada na limpeza
CREATE TABLE IF NOT EXISTS clean_taxi AS SELECT * FROM raw_taxi;
-- Cria as tabelas de brutas com os dados carregados

-- Mostra a tabela principal
.print '========== TABELA PRINCIPAL =========='
CREATE OR REPLACE TABLE raw_taxi AS SELECT * FROM read_parquet('data/yellow_tripdata_2024-01.parquet');

SELECT * FROM raw_taxi LIMIT 5;

-- Mostra a tabela de referência (para traduzir códigos de localização) 
.print '========== TABELA DE REFERENCIA =========='
CREATE OR REPLACE TABLE raw_taxi_zone AS SELECT * FROM read_csv_auto('data/taxi_zone_lookup.csv');

SELECT * FROM raw_taxi_zone LIMIT 5;
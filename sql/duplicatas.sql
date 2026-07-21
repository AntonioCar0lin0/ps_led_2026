-- Carrega a tabela principal
CREATE OR REPLACE TABLE raw_taxi AS SELECT * FROM read_parquet('data/yellow_tripdata_2024-01.parquet');

-- Carrega a tabela de referência (para traduzir códigos de localização) 
CREATE OR REPLACE TABLE raw_taxi_zone AS SELECT * FROM read_csv_auto('data/taxi_zone_lookup.csv');

-- Mostra a tabela de duplicatas
.print 'Tabela Duplicatas'
WITH number_duplicatas AS (
    SELECT *, row_number() OVER (PARTITION BY vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
        PULocationID, DOLocationID, trip_distance ORDER BY tpep_pickup_datetime) as list_duplicatas
    FROM raw_taxi
)
SELECT * FROM number_duplicatas WHERE list_duplicatas > 1;

-- Checa exemplo de uma duplicata específica
.print 'Duplicata Específica'
SELECT * FROM raw_taxi 
WHERE tpep_pickup_datetime = '2024-01-23 16:29:30'
    AND tpep_dropoff_datetime = '2024-01-23 16:43:07';

-- Mostra a tabela com apenas os totais positivos
.print 'Tabela com Total Positivo'
CREATE OR REPLACE TABLE raw_taxi_positive AS SELECT * FROM raw_taxi WHERE total_amount > 0;

SELECT * FROM raw_taxi_positive LIMIT 5;

-- Mostra a tabela de duplicatas com apenas os totais positivos
.print 'Tabela Duplicatas com Totais Positivos'
WITH number_duplicatas AS (
    SELECT *, row_number() OVER (PARTITION BY vendorID, tpep_pickup_datetime, tpep_dropoff_datetime,
        PULocationID, DOLocationID, trip_distance ORDER BY tpep_pickup_datetime) as list_duplicatas
    FROM raw_taxi_positive
)
SELECT * FROM number_duplicatas WHERE list_duplicatas > 1;
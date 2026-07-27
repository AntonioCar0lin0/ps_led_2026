-- Consultas de perfilamento

.print '========== COLUNA VendorID =========='
-- Código dentro do padrão? 
SELECT DISTINCT  VendorID FROM raw_taxi ORDER BY VendorID;

-- Quantas ocorrências de cada valor existem?
SELECT VendorID, COUNT(*) AS quantidade FROM raw_taxi GROUP BY VendorID ORDER BY VendorID;

-- Existem valores fora do domínio expirado?
SELECT * FROM raw_taxi WHERE VendorID NOT IN (1, 2, 6, 7);

.print '========== COLUNAS tpep_pickup_datetime e tpep_dropoff_datetime =========='
-- Existência de valores nulos
SELECT COUNT(*) AS nulos FROM raw_taxi WHERE tpep_pickup_datetime IS NULL; 

SELECT COUNT(*) FROM raw_taxi WHERE tpep_dropoff_datetime IS NULL; 

-- Existência de ano diferente de 2024
SELECT * FROM raw_taxi WHERE YEAR(tpep_pickup_datetime) != 2024;

SELECT * FROM raw_taxi WHERE YEAR(tpep_dropoff_datetime) != 2024; 

-- Datas diferentes de Janeiro
SELECT * FROM raw_taxi WHERE MONTH(tpep_pickup_datetime) <> 1 AND YEAR(tpep_pickup_datetime) = 2024;

SELECT tpep_dropoff_datetime FROM raw_taxi WHERE MONTH(tpep_dropoff_datetime) <> 1  AND YEAR(tpep_dropoff_datetime) = 2024 LIMIT 20;

-- Término da corrida
SELECT * FROM raw_taxi WHERE tpep_dropoff_datetime < tpep_pickup_datetime; 

-- Corridas iniciadas em Fevereiro
SELECT * FROM raw_taxi WHERE YEAR(tpep_pickup_datetime) = 2024 AND MONTH(tpep_pickup_datetime) = 2;

.print '========== COLUNA passenger_count =========='
-- Existência de valores negativos
SELECT COUNT(*) FROM raw_taxi WHERE passenger_count < 0;

-- Valores iguais a 0
SELECT passenger_count  FROM raw_taxi WHERE passenger_count = 0;

.print '========== COLUNA trip_distance  =========='
-- Valores nulos 
SELECT SUM(CASE WHEN trip_distance IS NULL THEN 1 ELSE 0 END) AS trip_distance FROM raw_taxi;

-- Valores negativos
SELECT * FROM raw_taxi WHERE trip_distance < 0;

-- Valor máximo
SELECT MIN(trip_distance), MAX(trip_distance) FROM raw_taxi;

-- Tempo percorrido pelo preço
SELECT trip_distance, fare_amount, total_amount, tpep_pickup_datetime, tpep_dropoff_datetime FROM raw_taxi ORDER BY trip_distance DESC LIMIT 10;

.print '========== COLUNA RatecodeID =========='
-- Valores distintos
SELECT DISTINCT RateCodeID FROM raw_taxi ORDER BY RateCodeID; 

-- Valores nulos
SELECT SUM(CASE WHEN RatecodeID IS NULL THEN 1 ELSE 0 END) AS RatecodeID FROM raw_taxi;

-- Verificação de valores fora do domínio esperado
SELECT * FROM raw_taxi WHERE RatecodeID NOT IN (1, 2, 3, 4, 5, 6, 99);

.print '========== COLUNA store_and_fwd_flag =========='
-- Valores distintos
SELECT DISTINCT store_and_fwd_flag FROM raw_taxi;

-- Valores nulos
SELECT SUM(CASE WHEN store_and_fwd_flag IS NULL THEN 1 ELSE 0 END) AS store_and_fwd_flag FROM raw_taxi;

-- Valores fora do escopo
SELECT *  FROM raw_taxi WHERE store_and_fwd_flag IS NOT NULL AND store_and_fwd_flag NOT IN ('Y','N');

.print '========== COLUNA PULocationID e DOLocationID =========='
-- Valores distintos
SELECT DISTINCT PULocationID FROM raw_taxi;

SELECT DISTINCT DOLocationID FROM raw_taxi;

-- Verifica se tem valores nulos
SELECT SUM(CASE WHEN PULocationID  IS NULL THEN 1 ELSE 0 END) AS PULocationID  FROM raw_taxi;

SELECT SUM(CASE WHEN PULocationID  IS NULL THEN 1 ELSE 0 END) AS PULocationID  FROM raw_taxi;

-- Valores fora do domínio esperado 
SELECT DISTINCT t.PULocationID FROM raw_taxi t LEFT JOIN raw_taxi_zone z ON t.PULocationID = z.LocationID WHERE z.LocationID IS NULL; 

SELECT DISTINCT t.DOLocationID FROM raw_taxi t LEFT JOIN raw_taxi_zone z ON t.DOLocationID  = z.LocationID WHERE z.LocationID IS NULL; 

.print '========== COLUNA payment_type =========='
-- Valores distintos
SELECT DISTINCT payment_type FROM raw_taxi ORDER BY payment_type;

-- Valores nulos                                                                                                    
SELECT SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) AS payment_type FROM raw_taxi;

-- Valores fora do escopo
SELECT *  FROM raw_taxi WHERE payment_type  IS NOT NULL AND payment_type  NOT IN (0, 1, 2, 3, 4, 5, 6);

-- Quantidade de registros
SELECT payment_type, COUNT(*) AS quantidade FROM raw_taxi GROUP BY payment_type ORDER BY payment_type; 

.print '========== VALORES MONETÁRIOS =========='
-- Valores nulos
SELECT
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    Airport_fee
FROM raw_taxi
WHERE fare_amount IS NULL
   OR extra  IS NULL
   OR mta_tax  IS NULL
   OR tip_amount  IS NULL
   OR tolls_amount  IS NULL
   OR improvement_surcharge  IS NULL
   OR total_amount  IS NULL
   OR congestion_surcharge  IS NULL
   OR Airport_fee  IS NULL;

-- Valores mínimos e máximo
SELECT
    MIN(fare_amount) AS fare_min,
    MAX(fare_amount) AS fare_max,
       
    MIN(extra) AS extra_min,
    MAX(extra) AS extra_max,
       
    MIN(mta_tax) AS mta_min,
    MAX(mta_tax) AS mta_max,
       
    MIN(tip_amount) AS tip_min,
    MAX(tip_amount) AS tip_max,
       
    MIN(tolls_amount) AS tolls_min,
    MAX(tolls_amount) AS tolls_max,
       
    MIN(improvement_surcharge) AS improvement_min,
    MAX(improvement_surcharge) AS improvement_max,
       
    MIN(congestion_surcharge) AS congestion_min,
    MAX(congestion_surcharge) AS congestion_max,
       
    MIN(Airport_fee) AS airport_min,
    MAX(Airport_fee) AS airport_max,
       
    MIN(total_amount) AS total_min,
    MAX(total_amount) AS total_max
FROM raw_taxi;

-- Valores negativos
SELECT
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    Airport_fee
FROM raw_taxi
WHERE fare_amount < 0
   OR extra < 0
   OR mta_tax < 0
   OR tip_amount < 0
   OR tolls_amount < 0
   OR improvement_surcharge < 0
   OR total_amount < 0
   OR congestion_surcharge < 0
   OR Airport_fee < 0;


-- Checa se há corridas com distancia 0 ou duração inferior a 30 segundos
SELECT COUNT(*) FROM clean_taxi WHERE trip_distance = 0 OR EPOCH(tpep_dropoff_datetime - tpep_pickup_datetime) < 30;
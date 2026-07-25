-- antonio
-- Análise de outliers de trip_distance. Documentação completa fora do repositório.

-- Estatísticas gerais de trip_distance
SELECT
    COUNT(*) AS total,
    MIN(trip_distance) AS min,
    MAX(trip_distance) AS max,
    ROUND(AVG(trip_distance), 2) AS media,
    QUANTILE_CONT(trip_distance, 0.5) AS mediana,
    QUANTILE_CONT(trip_distance, 0.99) AS p99,
    QUANTILE_CONT(trip_distance, 0.999) AS p999
FROM raw_taxi;

-- Estatísticas da amostra dos 1000 maiores valores de trip_distance
WITH top_1000 AS (
    SELECT trip_distance FROM raw_taxi ORDER BY trip_distance DESC LIMIT 1000
)
SELECT MIN(trip_distance) AS min_amostra, MAX(trip_distance) AS max_amostra,
    QUANTILE_CONT(trip_distance, 0.5) AS mediana_amostra,
    QUANTILE_CONT(trip_distance, 0.90) AS p90_amostra,
    QUANTILE_CONT(trip_distance, 0.94) AS p94_amostra,
    QUANTILE_CONT(trip_distance, 0.95) AS p95_amostra
FROM top_1000;

-- Plausibilidade na faixa 40-60 milhas (tempo, tarifa, velocidade implícita)
SELECT trip_distance,
    DATEDIFF('minute', tpep_pickup_datetime, tpep_dropoff_datetime) AS minutos,
    ROUND(trip_distance / NULLIF(DATEDIFF('minute', tpep_pickup_datetime, tpep_dropoff_datetime), 0) * 60, 1) AS mph_estimado,
    fare_amount, total_amount
FROM raw_taxi
WHERE trip_distance BETWEEN 40 AND 60
ORDER BY trip_distance
LIMIT 20;

-- Amostra dos maiores valores de trip_distance (tempo e tarifa associados)
SELECT trip_distance,
    DATEDIFF('minute', tpep_pickup_datetime, tpep_dropoff_datetime) AS minutos,
    fare_amount, total_amount
FROM raw_taxi
ORDER BY trip_distance DESC
LIMIT 30;

-- Quantidade de registros por faixa de trip_distance
SELECT
    SUM(CASE WHEN trip_distance BETWEEN 20 AND 47.36 THEN 1 ELSE 0 END) AS entre_20_e_47,
    SUM(CASE WHEN trip_distance BETWEEN 47.36 AND 100 THEN 1 ELSE 0 END) AS entre_47_e_100,
    SUM(CASE WHEN trip_distance > 100 THEN 1 ELSE 0 END) AS acima_100
FROM raw_taxi;

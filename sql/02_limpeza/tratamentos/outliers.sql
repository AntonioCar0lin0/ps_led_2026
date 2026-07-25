-- antonio
SELECT COUNT(*) AS total_antes_outliers FROM clean_taxi;

-- Remove valores negativos de trip_distance
DELETE FROM clean_taxi WHERE trip_distance < 0;

-- Limiar: percentil 94 dos 1000 maiores valores de trip_distance (calculado sobre raw_taxi)
DELETE FROM clean_taxi
WHERE trip_distance > (
    WITH top_1000 AS (
        SELECT trip_distance
        FROM raw_taxi
        ORDER BY trip_distance DESC
        LIMIT 1000
    )
    SELECT quantile_cont(trip_distance, 0.94) FROM top_1000
);

SELECT COUNT(*) AS total_depois_outliers FROM clean_taxi;
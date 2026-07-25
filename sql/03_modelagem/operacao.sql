-- Cria a tabela dim_data
CREATE TABLE dim_data(
    id_data INT PRIMARY KEY,
    PU_datetime DATETIME,
    DO_datetime DATETIME
);

-- Popula a tabela dim_data
INSERT INTO dim_data (id_data, PU_datetime, DO_datetime)
SELECT ROW_NUMBER() OVER() AS id_data, tpep_pickup_datetime,tpep_dropoff_datetime
FROM clean_taxi;

-- Cria a tabela dim_operacao
CREATE TABLE dim_operacao(
    id_operacao INT PRIMARY KEY,
    trip_distance DOUBLE,
    passenger_count INT,
    duracao TIME
);

-- Popula a tabela dim_operacao
INSERT INTO dim_operacao (trip_distance, passenger_count, duracao)
SELECT ROW_NUMBER() OVER() AS id_operacao, trip_distance, passenger_count, duracao('minute', tpep_pickup_datetime, tpep_dropoff_datetime)
FROM clean_taxi;
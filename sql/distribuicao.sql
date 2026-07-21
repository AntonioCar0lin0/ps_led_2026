-- Carrega a tabela principal
CREATE OR REPLACE TABLE raw_taxi AS SELECT * FROM read_parquet('data/yellow_tripdata_2024-01.parquet');

-- Carrega a tabela de referência (para traduzir códigos de localização) 
CREATE OR REPLACE TABLE raw_taxi_zone AS SELECT * FROM read_csv_auto('data/taxi_zone_lookup.csv');

-- Mostra estatísticas de cada coluna numérica da tabela principal (min, max, media, mediana, quartis)
.print 'Estatísticas das colunas numéricas da tabela principal'

-- trip_distance
select 'trip_distance' as coluna, min(trip_distance) as min, max(trip_distance) as max,round(avg(trip_distance), 2) as media,
    quantile_cont(trip_distance, 0.25) as q1, quantile_cont(trip_distance, 0.5) as mediana, quantile_cont(trip_distance, 0.75) as q3
from raw_taxi

union all

-- passenger_count
select 'passenger_count' as coluna, min(passenger_count) as min, max(passenger_count) as max, round(avg(passenger_count), 2) as media,
    quantile_cont(passenger_count, 0.25) as q1, quantile_cont(passenger_count, 0.5) as mediana, quantile_cont(passenger_count, 0.75) as q3
from raw_taxi

union all

-- fare_amount
select 'fare_amount' as coluna, min(fare_amount) as min, max(fare_amount) as max, round(avg(fare_amount), 2) as media,
    quantile_cont(fare_amount, 0.25) as q1, quantile_cont(fare_amount, 0.5) as mediana, quantile_cont(fare_amount, 0.75) as q3
from raw_taxi

union all

-- extra
select 'extra' as coluna, min(extra) as min, max(extra) as max, round(avg(extra), 2) as media,
    quantile_cont(extra, 0.25) as q1, quantile_cont(extra, 0.5) as mediana, quantile_cont(extra, 0.75) as q3
from raw_taxi

union all

-- mta_tax
select 'mta_tax' as coluna, min(mta_tax) as min, max(mta_tax) as max, round(avg(mta_tax), 2) as media,
    quantile_cont(mta_tax, 0.25) as q1, quantile_cont(mta_tax, 0.5) as mediana, quantile_cont(mta_tax, 0.75) as q3
from raw_taxi

union all

-- tip_amount
select 'tip_amount' as coluna, min(tip_amount) as min, max(tip_amount) as max, round(avg(tip_amount), 2) as media,
    quantile_cont(tip_amount, 0.25) as q1, quantile_cont(tip_amount, 0.5) as mediana, quantile_cont(tip_amount, 0.75) as q3
from raw_taxi

union all

-- tolls_amount
select 'tolls_amount' as coluna, min(tolls_amount) as min, max(tolls_amount) as max, round(avg(tolls_amount), 2) as media,
    quantile_cont(tolls_amount, 0.25) as q1, quantile_cont(tolls_amount, 0.5) as mediana, quantile_cont(tolls_amount, 0.75) as q3
from raw_taxi

union all

-- improvement_surcharge
select 'improvement_surcharge' as coluna, min(improvement_surcharge) as min, max(improvement_surcharge) as max, round(avg(improvement_surcharge), 2) as media,
    quantile_cont(improvement_surcharge, 0.25) as q1, quantile_cont(improvement_surcharge, 0.5) as mediana, quantile_cont(improvement_surcharge, 0.75) as q3
from raw_taxi

union all

-- total_amount
select 'total_amount' as coluna, min(total_amount) as min, max(total_amount) as max, round(avg(total_amount), 2) as media,
    quantile_cont(total_amount, 0.25) as q1, quantile_cont(total_amount, 0.5) as mediana, quantile_cont(total_amount, 0.75) as q3
from raw_taxi

union all

-- congestion_surcharge
select 'congestion_surcharge' as coluna, min(congestion_surcharge) as min, max(congestion_surcharge) as max, round(avg(congestion_surcharge), 2) as media,
    quantile_cont(congestion_surcharge, 0.25) as q1, quantile_cont(congestion_surcharge, 0.5) as mediana, quantile_cont(congestion_surcharge, 0.75) as q3
from raw_taxi

union all

-- airport_fee
select 'airport_fee' as coluna, min(airport_fee) as min, max(airport_fee) as max, round(avg(airport_fee), 2) as media,
    quantile_cont(airport_fee, 0.25) as q1, quantile_cont(airport_fee, 0.5) as mediana, quantile_cont(airport_fee, 0.75) as q3
from raw_taxi;
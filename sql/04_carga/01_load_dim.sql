TRUNCATE TABLE fato_corrida;

TRUNCATE TABLE dim_data;
-- Popula a tabela dim_data
INSERT INTO dim_data (id_data, PU_datetime, DO_datetime)
SELECT ROW_NUMBER() OVER() AS id_data, tpep_pickup_datetime,tpep_dropoff_datetime
FROM clean_taxi;

TRUNCATE TABLE dim_operacao;
-- Popula a tabela dim_operacao
INSERT INTO dim_operacao (id_operacao, trip_distance, passenger_count, duracao)
SELECT ROW_NUMBER() OVER() AS id_operacao, trip_distance, passenger_count, tpep_dropoff_datetime - tpep_pickup_datetime AS duracao
FROM clean_taxi;

TRUNCATE TABLE dim_pagamento;
TRUNCATE TABLE dim_pagamento_detalhes;
-- Popula a tabela de detalhes dos pagamentos
INSERT INTO dim_pagamento_detalhes (detalhes_pagamento, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, congestion_surcharge, airport_fee)
SELECT ROW_NUMBER() OVER () AS detalhes_pagamento,
    fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, congestion_surcharge, airport_fee
FROM clean_taxi;

-- Popula a tabela de pagamentos
INSERT INTO dim_pagamento (id_pagamento,descricao_pagamento, total_amount, store_fwd_flag, devolucao, detalhes_pagamento)
SELECT ROW_NUMBER() OVER () AS id_pagamento,
    CASE payment_type
        WHEN 0 THEN 'Flex Fare Trip'
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'Cash'
        WHEN 3 THEN 'No Charge'
        WHEN 4 THEN 'Dispute'
        WHEN 5 THEN 'Unknown'
        WHEN 6 THEN 'Voided Trip'
        ELSE 'Unknown'
    END AS descricao_pagamento,
    total_amount, store_and_fwd_flag AS store_fwd_flag,
    CASE
        WHEN total_amount < 0 THEN 'Y'
        ELSE 'N'
    END AS devolucao,
    ROW_NUMBER() OVER () AS detalhes_pagamento
FROM clean_taxi;
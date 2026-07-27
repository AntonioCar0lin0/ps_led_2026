TRUNCATE TABLE fato_corrida;

-- Data
TRUNCATE TABLE dim_data;
-- Popula a tabela dim_data levando em conta que há corridas diferentes com a mesma data de pickup e dropoff, usando o mesmo id_data para essas corridas.
WITH datas_distintas AS (
    SELECT DISTINCT tpep_pickup_datetime, tpep_dropoff_datetime
    FROM clean_taxi
)
INSERT INTO dim_data (id_data, PU_datetime, DO_datetime)
SELECT ROW_NUMBER() OVER() AS id_data, tpep_pickup_datetime,tpep_dropoff_datetime
FROM datas_distintas;

-- Operacao
TRUNCATE TABLE dim_operacao;
-- Popula a tabela dim_operacao levando em conta que há corridas diferentes com a mesma trip_distance, passenger_count e duracao, usando o mesmo id_operacao para essas corridas.
WITH operacoes_distintas AS (
    SELECT DISTINCT trip_distance, passenger_count, (tpep_dropoff_datetime - tpep_pickup_datetime) AS duracao
    FROM clean_taxi
)
INSERT INTO dim_operacao (id_operacao, trip_distance, passenger_count, duracao)
SELECT ROW_NUMBER() OVER() AS id_operacao, trip_distance, passenger_count, duracao
FROM operacoes_distintas;

-- Pagamento
TRUNCATE TABLE dim_pagamento;
TRUNCATE TABLE dim_pagamento_detalhes;
-- Popula a tabela de detalhes dos pagamentos levando em conta que há corriads dierentes com os mesmos detalhes de pagamento, usando o mesmo detalhes_pagamento para essas corridas.
WITH detalhes_pagamentos_distintos AS (
    SELECT DISTINCT fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, congestion_surcharge, airport_fee
    FROM clean_taxi
)
INSERT INTO dim_pagamento_detalhes (id_detalhes_pagamento, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, congestion_surcharge, airport_fee)
SELECT ROW_NUMBER() OVER () AS id_detalhes_pagamento,
    fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, congestion_surcharge, airport_fee
FROM detalhes_pagamentos_distintos;

-- Popula a tabela de pagamentos levando em conta que há corridas diferentes com o mesmo tipo de pagamento, total_amount, store_and_fwd_flag e devolucao, usando o mesmo id_pagamento para essas corridas.
WITH pagamentos_unicos AS (
    SELECT DISTINCT 
        c.payment_type,
        c.total_amount,
        c.store_and_fwd_flag,
        d.id_detalhes_pagamento
    FROM clean_taxi c JOIN dim_pagamento_detalhes d 
    ON c.fare_amount = d.fare_amount AND c.extra = d.extra AND c.mta_tax = d.mta_tax AND c.tip_amount = d.tip_amount
       AND c.tolls_amount = d.tolls_amount AND c.improvement_surcharge = d.improvement_surcharge
       AND c.congestion_surcharge = d.congestion_surcharge AND c.airport_fee = d.airport_fee
)
INSERT INTO dim_pagamento (id_pagamento, descricao_pagamento, total_amount, store_fwd_flag, devolucao, id_detalhes_pagamento)
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
    id_detalhes_pagamento
FROM pagamentos_unicos;

-- Vendor
TRUNCATE TABLE dim_vendor;
-- Popula a tabela dim_vendor
INSERT INTO dim_vendor (id_vendor, vendor_nome)
SELECT DISTINCT
    VendorID as id_vendor,
    CASE VendorID
        WHEN 1 THEN 'Creative Mobile Technologies, LLC'
        WHEN 2 THEN 'VeriFone Inc.'
        WHEN 6 THEN 'Myle Technologies Inc'
    END AS vendor_nome
FROM clean_taxi
WHERE VendorID IS NOT NULL;

-- Tarifa
TRUNCATE TABLE dim_tarifa;
-- Popula a tabela dim_tarifa
INSERT INTO dim_tarifa (id_ratecode, tarifacode_descricao)
SELECT DISTINCT
    RatecodeID as id_ratecode,
    CASE RatecodeID
        WHEN 1 THEN 'Tarifa padrão'
        WHEN 2 THEN 'JFK'
        WHEN 3 THEN 'Newark'
        WHEN 4 THEN 'Nassau ou Westchester'
        WHEN 5 THEN 'Tarifa negociada'
        WHEN 6 THEN 'Corrida em grupo'
        WHEN 99 THEN 'Nulo/desconhecido'
    END AS tarifacode_descricao
FROM clean_taxi
WHERE RatecodeID IS NOT NULL;
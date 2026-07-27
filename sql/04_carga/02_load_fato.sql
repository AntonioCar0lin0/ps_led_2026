TRUNCATE TABLE fato_corrida;

INSERT INTO fato_corrida (id_corrida, id_data, id_vendor, id_ratecode, id_localizacao, id_operacao, id_pagamento)
SELECT ROW_NUMBER() OVER () AS id_corrida,
    d.id_data,
    v.id_vendor,
    t.id_ratecode,
    l.id_localizacao,
    o.id_operacao,
    p.id_pagamento
FROM clean_taxi c
    join dim_data d on c.tpep_pickup_datetime = d.PU_datetime and c.tpep_dropoff_datetime = d.DO_datetime
    join dim_vendor v on c.VendorID = v.id_vendor
    join dim_tarifa t on c.RatecodeID = t.id_ratecode
    join dim_localizacao l on c.PULocationID = l.PU_location and c.DOLocationID = l.DO_location
    join dim_operacao o on c.trip_distance = o.trip_distance and c.passenger_count = o.passenger_count and (c.tpep_dropoff_datetime - c.tpep_pickup_datetime) = o.duracao
    -- é necessário join com detalhes_pagamento para garantir que o id_pagamento correto seja passado para a fato, levando em conta que há amostras de pagamento com o mesmo payment_type, total_amount, store_fwd_flag e devolucao, mas com detalhes diferentes
    join dim_pagamento_detalhes dp on c.fare_amount = dp.fare_amount and c.extra = dp.extra and c.mta_tax = dp.mta_tax
        and c.tip_amount = dp.tip_amount and c.tolls_amount = dp.tolls_amount and c.improvement_surcharge = dp.improvement_surcharge
        and c.congestion_surcharge = dp.congestion_surcharge and c.airport_fee = dp.airport_fee
    join dim_pagamento p on c.total_amount = p.total_amount and c.store_and_fwd_flag = p.store_fwd_flag
        and ((c.total_amount < 0 and p.devolucao = 'Y') or (c.total_amount >= 0 and p.devolucao = 'N'))
        -- é necessário transformar o payment_type de c em numero para conseguir comparar com a tabela pagamentos
        and c.payment_type = CASE p.descricao_pagamento
            WHEN 'Flex Fare Trip' THEN 0
            WHEN 'Credit Card' THEN 1
            WHEN 'Cash' THEN 2
            WHEN 'No Charge' THEN 3
            WHEN 'Dispute' THEN 4
            WHEN 'Unknown' THEN 5
            WHEN 'Voided Trip' THEN 6
        END
        and dp.id_detalhes_pagamento = p.id_detalhes_pagamento;
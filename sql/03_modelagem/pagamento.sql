-- Cria tabela de detalhes do pagamento
CREATE TABLE dim_pagamento_detalhes (
    detalhes_pagamento INTEGER PRIMARY KEY,
    fare_amount DECIMAL(10, 2) NOT NULL,
    extra DECIMAL(10, 2) NOT NULL,
    mta_tax DECIMAL(10, 2) NOT NULL,
    tip_amount DECIMAL(10, 2) NOT NULL,
    tolls_amount DECIMAL(10, 2) NOT NULL,
    improvement_surcharge DECIMAL(10, 2) NOT NULL,
    congestion_surcharge DECIMAL(10, 2) NOT NULL,
    airport_fee DECIMAL(10, 2) NOT NULL
);

-- Cria tabela de pagamento
CREATE TABLE dim_pagamento (
    id_pagamento INTEGER PRIMARY KEY,
    descricao_pagamento VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    store_fwd_flag CHAR(1) NOT NULL,
    devolucao CHAR(1) NOT NULL,
    detalhes_pagamento INT NOT NULL,

    FOREIGN KEY (detalhes_pagamento) REFERENCES dim_pagamento_detalhes(detalhes_pagamento)
);

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
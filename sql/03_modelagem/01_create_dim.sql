-- Cria tabela de detalhes do pagamento
CREATE TABLE IF NOT EXISTS dim_pagamento_detalhes (
    id_detalhes_pagamento INTEGER PRIMARY KEY,
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
CREATE TABLE IF NOT EXISTS dim_pagamento (
    id_pagamento INTEGER PRIMARY KEY,
    descricao_pagamento VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    store_fwd_flag CHAR(1) NOT NULL,
    devolucao CHAR(1) NOT NULL,
    id_detalhes_pagamento INT NOT NULL,

    FOREIGN KEY (id_detalhes_pagamento) REFERENCES dim_pagamento_detalhes(id_detalhes_pagamento)
);

-- Cria a tabela dim_operacao
CREATE TABLE IF NOT EXISTS dim_operacao(
    id_operacao INT PRIMARY KEY,
    trip_distance DOUBLE,
    passenger_count INT,
    duracao INTERVAL
);

-- Cria a tabela dim_data
CREATE TABLE IF NOT EXISTS dim_data(
    id_data INT PRIMARY KEY,
    PU_datetime DATETIME,
    DO_datetime DATETIME
);

-- Cria a tabela dim_vendor
CREATE TABLE IF NOT EXISTS dim_vendor (
    id_vendor   INTEGER PRIMARY KEY,
    vendor_nome VARCHAR(50) NOT NULL
);

-- Cria a tabela dim_tarifa
CREATE TABLE IF NOT EXISTS dim_tarifa (
    id_ratecode           INTEGER PRIMARY KEY,
    tarifacode_descricao  VARCHAR(50) NOT NULL
);

-- Cria a tabela dim_zona
CREATE TABLE IF NOT EXISTS dim_zona (
    id_zona       INTEGER PRIMARY KEY,
    borough       VARCHAR(50) NOT NULL,
    zone          VARCHAR(100) NOT NULL,
    service_zone  VARCHAR(50) NOT NULL
);

-- Cria a tabela dim_localizacao
CREATE TABLE IF NOT EXISTS dim_localizacao (
    id_localizacao INTEGER PRIMARY KEY,
    PU_loc         INT NOT NULL,
    DO_loc         INT NOT NULL,

    FOREIGN KEY (PU_loc) REFERENCES dim_zona(id_zona),
    FOREIGN KEY (DO_loc) REFERENCES dim_zona(id_zona)
);
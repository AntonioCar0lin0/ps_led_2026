COPY clean_taxi TO 'data/02_clean/yellow_tripdata_2024-01_clean.parquet' (FORMAT PARQUET);

CREATE TABLE fato_corrida (
    id_corrida SERIAL PRIMARY KEY,
    id_vendor INT,
    id_ratecode INT,
    id_localizacao INT,
    id_data INT,
    id_pagamento INT,
    id_operacao INT    
)
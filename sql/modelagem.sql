CREATE TABLE fato_corrida (
    id_corrida SERIAL PRIMARY KEY,
    id_vendor INT,
    id_ratecode INT,
    id_localizacao INT,
    id_data INT,
    id_pagamento INT,
    id_operacao INT,

    FOREIGN KEY (id_pagamento) REFERENCES dim_pagamento(id_pagamento)
)
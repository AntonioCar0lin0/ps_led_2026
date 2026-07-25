CREATE TABLE fato_corrida (
    id_corrida INTEGER PRIMARY KEY,
    id_vendor INT,
    id_ratecode INT,
    id_localizacao INT,
    id_data INT,
    id_pagamento INT,
    id_operacao INT,

    FOREIGN KEY (id_data) REFERENCES dim_data(id_data),
    FOREIGN KEY (id_vendor) REFERENCES dim_vendor(id_vendor),
    FOREIGN KEY (id_ratecode) REFERENCES dim_tarifa(id_ratecode),
    FOREIGN KEY (id_localizacao) REFERENCES dim_localizacao(id_localizacao ),
    FOREIGN KEY (id_pagamento) REFERENCES dim_pagamento(id_pagamento),
    FOREIGN KEY (id_operacao) REFERENCES dim_operacao(id_operacao)
)

INSERT INTO fato_corrida (id_corrida, id_pagamento)
SELECT ROW_NUMBER() OVER () AS id_corrida, ROW_NUMBER() OVER () AS id_pagamento
FROM clean_taxi;
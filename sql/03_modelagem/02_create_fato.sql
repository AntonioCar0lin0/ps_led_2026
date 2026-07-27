CREATE TABLE IF NOT EXISTS fato_corrida (
    id_corrida INTEGER PRIMARY KEY,
    id_vendor INT NOT NULL,
    id_ratecode INT NOT NULL,
    id_localizacao INT NOT NULL,
    id_data INT NOT NULL,
    id_pagamento INT NOT NULL,
    id_operacao INT NOT NULL,

    FOREIGN KEY (id_data) REFERENCES dim_data(id_data),
    FOREIGN KEY (id_vendor) REFERENCES dim_vendor(id_vendor),
    FOREIGN KEY (id_ratecode) REFERENCES dim_tarifa(id_ratecode),
    FOREIGN KEY (id_localizacao) REFERENCES dim_localizacao(id_localizacao ),
    FOREIGN KEY (id_pagamento) REFERENCES dim_pagamento(id_pagamento),
    FOREIGN KEY (id_operacao) REFERENCES dim_operacao(id_operacao)
);
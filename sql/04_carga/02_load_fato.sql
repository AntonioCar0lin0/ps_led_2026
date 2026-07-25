TRUNCATE TABLE fato_corrida;

INSERT INTO fato_corrida (id_corrida, id_pagamento)
SELECT ROW_NUMBER() OVER () AS id_corrida, ROW_NUMBER() OVER () AS id_pagamento
FROM clean_taxi;
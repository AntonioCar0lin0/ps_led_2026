-- Qual o valor médio pago por cada tipo de pagamento (cartão, dinheiro, etc)?
select p.descricao_pagamento, round(avg(p.total_amount), 2) as valor_medio
from dim_pagamento p join fato_corrida c on p.id_pagamento = c.id_pagamento
group by p.descricao_pagamento order by valor_medio desc;
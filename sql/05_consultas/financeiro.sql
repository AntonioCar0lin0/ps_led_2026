-- Qual o valor médio pago por cada tipo de pagamento (cartão, dinheiro, etc)?
select p.descricao_pagamento, round(avg(p.total_amount), 2) as valor_medio
from dim_pagamento p join fato_corrida c on p.id_pagamento = c.id_pagamento
group by p.descricao_pagamento order by valor_medio desc;

-- Qual a média de valor de gorjetas para corridas com gorjeta?
SELECT ROUND(AVG(pd.tip_amount), 2) AS media_gorjeta FROM fato_corrida f
JOIN dim_pagamento p ON f.id_pagamento = p.id_pagamento
JOIN dim_pagamento_detalhes pd ON p.id_detalhes_pagamento = pd.id_detalhes_pagamento 
WHERE pd.tip_amount > 0;

-- Qual o volume e prejuízo total de devoluções realizadas?
SELECT COUNT(*) AS volume_devolucoes, ROUND(SUM(p.total_amount), 2) AS prejuizo_total
FROM fato_corrida f JOIN dim_pagamento p
ON f.id_pagamento = p.id_pagamento
WHERE p.devolucao = 'S';

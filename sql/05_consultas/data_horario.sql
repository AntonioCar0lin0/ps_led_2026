-- Qual foram os 5 dias com maior volume de corridas e quais foram os 5 dias que geraram maior faturamento?
with dias_corridas as (
    select DAY(d.PU_datetime) as dia, p.total_amount
    from fato_corrida c join dim_data d on c.id_data = d.id_data join dim_pagamento p on c.id_pagamento = p.id_pagamento --devolucao nao será filtrada, visto que entra na conta do faturamento
),
dia_corrida_total as(
    select dia as dia_total, count(*) as total_corridas, row_number() over(order by total_corridas desc) as posicao
    from dias_corridas
    group by dia_total order by total_corridas desc limit 5
),
dia_faturamento as(
    select dia as dia_faturamento, round(sum(total_amount), 2) as faturamento, row_number() over(order by faturamento desc) as posicao
    from dias_corridas
    group by dia_faturamento order by faturamento desc limit 5
)
select c.dia_total, c.total_corridas, f.dia_faturamento, f.faturamento 
from dia_corrida_total c join dia_faturamento f on c.posicao = f.posicao; 
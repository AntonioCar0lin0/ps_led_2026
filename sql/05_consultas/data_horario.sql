-- Qual foram os 5 dias com maior volume de corridas e quais foram os 5 dias que geraram maior faturamento?
with dias_corridas as (
    select DAY(d.PU_datetime) as dia, p.total_amount, p.devolucao
    from fato_corrida c join dim_data d on c.id_data = d.id_data join dim_pagamento p on c.id_pagamento = p.id_pagamento
),
dia_corrida_total as(
    select dia as dia_total, count(*) as total_corridas, row_number() over(order by total_corridas desc) as posicao
    from dias_corridas where devolucao = 'N' --checa devolucao para nao contabilizar corridas repetidas no total
    group by dia_total order by total_corridas desc limit 5
),
dia_faturamento as(
    select dia as dia_faturamento, round(sum(total_amount), 2) as faturamento, row_number() over(order by faturamento desc) as posicao
    from dias_corridas --devolucao nao precsa ser checada aqui pois o faturamento total inclui os valores devolvidos
    group by dia_faturamento order by faturamento desc limit 5
)
select c.dia_total, c.total_corridas, f.dia_faturamento, f.faturamento 
from dia_corrida_total c join dia_faturamento f on c.posicao = f.posicao; 


-- Qual o faturamento total e médio de acordo com cada faixa de horário (0h-6h, 6h-12h, 12h-18h, 18h-24h)?
SELECT CASE
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 0 AND 5 THEN '00h-06h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 6 AND 11 THEN '06h-12h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 12 AND 17 THEN '12h-18h'
    ELSE '18h-24h'
    END AS faixa_horario,
    ROUND(AVG(p.total_amount),2) AS faturamento_medio,
    ROUND(SUM(p.total_amount),2) AS faturamento_total
FROM fato_corrida f
JOIN dim_data d
    ON f.id_data = d.id_data
JOIN dim_pagamento p
    ON f.id_pagamento = p.id_pagamento
GROUP BY 1
ORDER BY 1;

-- Quantas corridas são realizadas em cada faixa de horário no total (0h-3h, 3h-6h, 6h-9h, …, 21h-24h)?
SELECT CASE
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 0 AND 2 THEN '00h-03h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 3 AND 5 THEN '03h-06h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 6 AND 8 THEN '06h-09h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 9 AND 11 THEN '09h-12h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 12 AND 14 THEN '12h-15h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 15 AND 17 THEN '15h-18h'
    WHEN EXTRACT(HOUR FROM d.PU_datetime) BETWEEN 18 AND 20 THEN '18h-21h'
    ELSE '21h-24h'
    END AS faixa_horario,
    COUNT(*) AS total_corridas
FROM fato_corrida f
JOIN dim_data d
    ON f.id_data = d.id_data
GROUP BY 1
ORDER BY 1;
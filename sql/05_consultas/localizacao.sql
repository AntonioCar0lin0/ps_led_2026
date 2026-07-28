-- Quais são as 5 rotas com a maior velocidade média?
with velocidades_corridas as (
    select c.id_localizacao, c.id_pagamento, o.trip_distance, (EPOCH(o.duracao)/3600.0) as duracao_horas --EPOCH converte a duracao em segundos e /3600 em horas
    from fato_corrida c join dim_operacao o on c.id_operacao = o.id_operacao
    where EPOCH(o.duracao) > 0 --evita divisao por 0
),
dados_zonas as (
    select l.id_localizacao, zpu.borough as pu_borough, zpu.zone as pu_zone, zdo.borough as do_borough, zdo.zone as do_zone
    from dim_localizacao l join dim_zona zpu on l.PU_loc = zpu.id_zona
    join dim_zona zdo on l.DO_loc = zdo.id_zona
    where pu_borough != 'Unknown' and do_borough != 'Unknown'
)
select dz.pu_borough, dz.pu_zone, dz.do_borough, dz.do_zone, count(*) as total_corridas, round(SUM(vc.trip_distance)/SUM(vc.duracao_horas), 2) as velocidade_media
from velocidades_corridas vc join dados_zonas dz on vc.id_localizacao = dz.id_localizacao join dim_pagamento p on p.id_pagamento = vc.id_pagamento
where p.devolucao = 'N'
group by dz.pu_borough, dz.pu_zone, dz.do_borough, dz.do_zone 
having total_corridas > 10 order by velocidade_media desc limit 5;

-- Quais são as 5 rotas que geram o maior faturamento total?
SELECT l.PU_loc, l.DO_loc, SUM(p.total_amount) AS faturamento_total FROM fato_corrida f
JOIN dim_localizacao l ON f.id_localizacao = l.id_localizacao
JOIN dim_pagamento p ON f.id_pagamento = p.id_pagamento
GROUP BY l.PU_loc, l.DO_loc ORDER BY faturamento_total DESC LIMIT 5;

-- Quais são as zonas de embarque e desembarque mais comuns?
-- 5 zonas de embarque
SELECT z.zone AS zona_embarque, COUNT(*) AS quantidade
FROM fato_corrida f JOIN dim_localizacao l ON f.id_localizacao = l.id_localizacao
JOIN dim_zona z ON l.PU_loc = z.id_zona
GROUP BY z.zone ORDER BY quantidade DESC LIMIT 5;

-- 5 zonas de desembarque
SELECT z.zone AS zona_desembarque, COUNT(*) AS quantidade
FROM fato_corrida f JOIN dim_localizacao l ON f.id_localizacao = l.id_localizacao
JOIN dim_zona z ON l.DO_loc = z.id_zona
GROUP BY z.zone ORDER BY quantidade DESC LIMIT 5;
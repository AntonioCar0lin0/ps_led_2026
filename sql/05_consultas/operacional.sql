-- Qual o tempo médio de viagem por faixas de distância (0-1 km, 1-3 km, 3-5 km, 5-10 km, 10+ km)?
with faixas_corridas as(
    select c.id_corrida, o.trip_distance, EPOCH(o.duracao) as duracao_segundos,
        case 
            when o.trip_distance > 0 and o.trip_distance < 1 then '0-1'
            when o.trip_distance >= 1 and o.trip_distance < 3 then '1-3'
            when o.trip_distance >= 3 and o.trip_distance < 5 then '3-5'
            when o.trip_distance >= 5 and o.trip_distance < 10 then '5-10'
            when o.trip_distance >= 10 then '10+'
        end as faixa_distancia
    from fato_corrida c join dim_operacao o on c.id_operacao = o.id_operacao
)
select faixa_distancia, count(*) as total_corridas, to_seconds(round(avg(duracao_segundos), 0)) as media_tempo
from faixas_corridas group by faixa_distancia
order by case faixa_distancia when '10+' then 99 else 1 end, faixa_distancia; --ordenar em ordem crescente de distancia
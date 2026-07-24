-- Mostra cada taxa, a soma total das taxas e o total_amount
.print 'Tabela das taxas, soma e total_amount'
select fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, congestion_surcharge, airport_fee,
    round((fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee), 2) as calculated_total,
    total_amount
from raw_taxi;

-- Mostra cada taxa, a soma total das taxas e o total_amount, filtrando todas as amostras onde a soma das taxas é diferente do total_amount
.print 'Tabela das taxas, soma, total_amount e a diferença entre soma e total_amount nas amostras onde há divergência'
select fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, congestion_surcharge, airport_fee,
    round((fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee), 2) as calculated_total,
    total_amount, round(total_amount - calculated_total, 2) as diference
from raw_taxi where abs(diference) > 0;

-- Mostra os valores mais comuns de diferença
.print 'Tabela da frequência dos valores divergentes'
select diference, count(*) as frequencia from (
    select round((fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee), 2) as calculated_total,
        total_amount, round(total_amount - calculated_total, 2) as diference
    from raw_taxi where abs(diference) > 0
) group by diference order by frequencia desc;

-- Mostra as amostras onde há divergência e também há airport fee ou congestion_surcharge
.print 'Tabela das amostras divergentes com airport fee ou congestion_surcharge'
select airport_fee, congestion_surcharge, round((fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee), 2) as calculated_total,
    total_amount, round(total_amount - calculated_total, 2) as diference
from raw_taxi where (airport_fee = 1.75 or congestion_surcharge = 2.5) and abs(diference) > 0;

-- Mostra as amostras onde NÃO há divergência e também há airport fee ou congestion_surcharge
.print 'Tabela das amostras sem divergência com airport fee ou congestion_surcharge'
select airport_fee, congestion_surcharge, round((fare_amount + extra + mta_tax + tip_amount +tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee), 2) as calculated_total,
    total_amount, round(total_amount - calculated_total, 2) as diference
from raw_taxi where (airport_fee = 1.75 or congestion_surcharge = 2.5) and abs(diference) = 0;
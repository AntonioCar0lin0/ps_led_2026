-- Altera airport_fee para 0 quando a diferença entre a soma das colunas e o total_amount for 1.75
update clean_taxi set airport_fee = 0
where airport_fee = 1.75 and 
    round(total_amount - round(fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee, 2), 2) = -1.75;

-- Altera congestion_surcharge para 0 quando a diferença entre a soma das colunas e o total_amount for 2.5
update clean_taxi set congestion_surcharge = 0
where congestion_surcharge = 2.5 and 
    round(total_amount - round(fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee, 2), 2) = -2.5;

-- Altera airport_fee e congestion_surcharge para 0 quando a diferença entre a soma das colunas e o total_amount for 4.25
update clean_taxi set congestion_surcharge = 0, airport_fee = 0
where airport_fee = 1.75 and congestion_surcharge = 2.5 and 
    round(total_amount - round(fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee, 2), 2) = -4.25;

-- Deleta as amostras restantes que tem diferença entre a soma das colunas e o total_amount
delete from clean_taxi
where round(total_amount - round(fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee, 2), 2) != 0;
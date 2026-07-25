-- deleta da tabela as amostras que contem campos nulos (campos identificados no perfilamento)
delete from clean_taxi 
where passenger_count is null or RatecodeID is null or congestion_surcharge is null or airport_fee is null or store_and_fwd_flag is null;
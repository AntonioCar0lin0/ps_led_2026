-- Aplicar as regras de limpeza e gerar a tabela tratada

-- Cria a tabela tratada removendo anos diferente de 2024 e meses diferentes de Janeiro
CREATE OR REPLACE TABLE limpeza_taxi AS SELECT * FROM raw_taxi WHERE YEAR(tpep_pickup_datetime) = 2024 AND MONTH(tpep_pickup_datetime) = 1;

-- Verificar se ainda existe outro ano
SELECT DISTINCT YEAR(tpep_pickup_datetime) FROM limpeza_taxi;

-- Verificar se ainda existe inicio da corrida em fevereiro
SELECT DISTINCT MONTH(tpep_pickup_datetime) FROM limpeza_taxi;
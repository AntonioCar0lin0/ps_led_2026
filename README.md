# Consultas e uso do DuckDB 🎲

## COMO ABRIR O BANCO
No terminal: `.\duckdb.exe taxi.duckdb`

### EXECUÇÃO DO SQL
**nome_do_arquivo.sql:** `.read caminho_do_arquivo/nome_do_arquivo.sql`

## COMO USAR O DUCKDB
1. Adiciona os arquivos das tabelas (pasta data/01_raw)
2. Abre o banco

### 00-Load
1. No terminal, com o banco do duckdb aberto, executar o arquivo `sql/00_ingestao/load_data.sql` para carregar os arquivos com dados brutos.

### Perfilamento (Opcional)
1. Após o load, executar os arquivos na pasta `sql/01_perfilamento`. As consultas podem inicialmente ser feitas diretamente no terminal após abrir o banco para ter uma visualização mais rápida.

### Clean
1. Após a etapa de load e com os dados carregados, executar individualmente cada arquivo dentro da pasta `sql/02_limpeza/tratamentos`.
2. Quando os arquivos de limpeza tiverem sido executados, rodar o arquivo `sql/02_limpeza/clean.sql` para carregar os dados limpos para `data/02_clean`.

### Modelagem
1. Após a etapa de limpeza dos dados, rodar os arquivos da pasta `sql/03_modelagem` em ordem, primeiro a criação das tabelas de dimensão em `sql/03_modelagem/01_create_dim.sql`, depois a tabela fato em `sql/03_modelagem/02_create_fato.sql`.

### Carga
1. Após a criação das tabelas de dimensão e fato, para populá-las, executar os arquivos da pasta `sql/04_carga` em ordem, populando primeiro as tabelas de dimensão em `sql/04_carga/01_load_dim.sql`, depois a tabela fato em `sql/04_carga/02_load_fato.sql`.

### Consultas Analíticas
TO-DO

## WAL
- **Write-Ahead Log (WAL) do DuckDB:** é como um diário temporário onde o DuckDB registra as alterações antes de gravá-las definitivamente no banco. É um mecanismo de segurança.

- **Com WAL:** o DuckDB consegue recuperar as alterações caso o computador seja desligado durante a execução

## COMO FECHAR O BANCO COM SEGURANÇA
``.exit``

PS: O arquivo Wal é fechado automaticamente após isso

## Organização dos arquivos
- 01 - Cria as tabelas de brutas com os dados carregados
- 02 - Consultas de perfilamento
- 03 - Aplicar as regras de limpeza e gerar a tabela tratada
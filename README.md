# Consultas e uso do DuckDB 🎲

## COMO ABRIR O BANCO
````.\duckdb.exe taxi.duckdb````

## EXECUÇÃO DOS ARQUIVOS SQL
````.read sql/[nome do arquivo].sql````
-  **EX: 02_perfilamento_dominio_esperado:** ````.read sql/02_perfilamento_dominio_esperado.sql````

## COMO USAR O DUCKDB
1. Adiciona os arquivos das tabelas (pasta data)
2. Abre o banco
3. Cria um arquivo para ler as tabelas com ````CREATE OR REPLACE TABLE```` (01_load.sql)
4. Escreve em um novo arquivo sql as consultas feitas (02_perfilamento_dominio_esperado.sql). As consultas podem inicialmente serem feita diretamente no terminal após abrir o banco para ter uma visualização mais rápida.

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
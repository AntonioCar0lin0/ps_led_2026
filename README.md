### COMO ABRIR O BANCO
````.\duckdb.exe taxi.duckdb````

### EXECUÇÃO DO SQL
**dominio_esperado.sql:** ````.read sql/dominio_esperado.sql````

### COMO USAR O DUCKDB
1. Abre o banco
2. Adiciona as tabelas
3. Cria um arquivo para ler as tabelas com ````CREATE OR REPLACE TABLE```` em sql e permitir que os dados sejam salvos no banco (por exemplo a dominio_esperado.sql)
4. Escreve no arquivo sql as consultas ou diretamente no banco de dados antes de adicionar ao arquivo sql para ter um teste mais rápido da consulta executada.

### WAL
- Write-Ahead Log (WAL) do DuckDB: é como um diário temporário onde o DuckDB registra as alterações antes de gravá-las definitivamente no banco. É um mecanismo de segurança.

- Com WAL:o DuckDB consegue recuperar as alterações caso o computador seja desligado durante a execução

### COMO FECHAR O BANCO COM SEGURANÇA
.exit

PS: O arquivo Wal é fechado automaticamente após isso
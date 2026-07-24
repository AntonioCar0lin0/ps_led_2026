# Consultas e uso do DuckDB 🎲

## COMO ABRIR O BANCO
No terminal: `.\duckdb.exe taxi.duckdb`

### EXECUÇÃO DO SQL
**nome_do_arquivo.sql:** `.read caminho_do_arquivo/nome_do_arquivo.sql`

## COMO USAR O DUCKDB
1. Adiciona os arquivos das tabelas (pasta data/01_raw)
2. Abre o banco

### Load & Perfilamento
1. No terminal, com o banco do duckdb aberto, executar o arquivo `sql/load.sql` para ler as tabelas.
2. Escreve em um novo arquivo sql as consultas feitas para o perfilamento em `sql/01_perfilamento/nome_do_arquivo.sql`. As consultas podem inicialmente ser feitas diretamente no terminal após abrir o banco para ter uma visualização mais rápida.

### Clean
1. Após a etapa de load e com os dados carregados, rodar cada arquivo dentro da pasta `sql/02_limpeza`.
2. Quando os arquivos de limpeza tiverem sido rodados, rodar o arquivo `sql/clean.sql` para carregar os dados limpos para `data/02_clean`.

### Modelagem
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
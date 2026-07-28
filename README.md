# LED: ligando dados, pessoas e conhecimento
ELT para base pública de corridas de táxi em Nova York

Grupo 13:
- Antonio Rodrigues Pinheiro Carolino
- Bruna Freytas da Silva
- Fernando Corrêa Gambôa Pereira dos Santos
- Gabriel Valença Mayerhofer

## Documentação do projeto
A documentação do projeto está disponível aqui:

**[Link para a documentação do projeto](https://docs.google.com/document/d/1381uFjZb3ezDOzeP-BGT-wj0dbJOtE7lwzYYSjWeqms/edit?usp=sharing)**

# Como executar o projeto

## 1. Abrir o banco DuckDB
No terminal: 

**Windows:** `.\duckdb.exe taxi.duckdb`

**Linux / macOS:** `duckdb taxi.duckdb` ou `./duckdb taxi.duckdb`

## 2. Executar scripts SQL
Para executar um arquivo SQL no DuckDB:

**nome_do_arquivo.sql:** `.read caminho_do_arquivo/nome_do_arquivo.sql`

Exemplo: `.read sql/00_ingestao/load.sql`

# Pipeline de Processamento
O processamento segue as seguintes etapas:

```text
01_raw ──▶ 00_ingestao ──▶ 01_perfilamento ──▶ 02_limpeza ──▶ 02_clean ──▶ 03_modelagem ──▶ 04_carga ──▶ 03_processed ──▶ 05_consultas
```

# Etapas do Projeto

## Adicionar dados brutos
1. Adicionar os arquivos das tabelas com os dados brutos na pasta `data/01_raw`
2. Abra o banco DuckDB

## 00 - Ingestão
1. No terminal, com o banco do duckdb aberto, executar o arquivo `sql/00_ingestao/load_data.sql` para carregar os arquivos com dados brutos.

## 01 - Perfilamento
1. Após o load, executar os arquivos na pasta `sql/01_perfilamento`. As consultas podem inicialmente ser feitas diretamente no terminal após abrir o banco para ter uma visualização mais rápida.

## 02 - Limpeza
1. Após a etapa de load e com os dados carregados, executar individualmente cada arquivo dentro da pasta `sql/02_limpeza/tratamentos`.
2. Após a execução dos arquivos de limpeza, rodar o arquivo `sql/02_limpeza/clean.sql` para carregar os dados limpos para `data/02_clean`.

## 03 - Modelagem
1. Após a etapa de limpeza dos dados, rodar os arquivos da pasta `sql/03_modelagem` em ordem, primeiro a criação das tabelas de dimensão em `sql/03_modelagem/01_create_dim.sql`, depois a tabela fato em `sql/03_modelagem/02_create_fato.sql`.

## 04 - Carga
1. Após a criação das tabelas de dimensão e fato, para populá-las, executar os arquivos da pasta `sql/04_carga` em ordem, populando primeiro as tabelas de dimensão em `sql/04_carga/01_load_dim.sql`, depois a tabela fato em `sql/04_carga/02_load_fato.sql`.

## 05 - Consultas Analíticas
1. Após carregar os dados nas tabelas dimensão e fato, executar cada arquivo de consulta em `sql/05_consultas/nome_do_arquivo.sql`.

# Estrutura do Projeto
```text
.
├── data                              # Arquivos de dados
│   ├── 01_raw                        # Dados brutos
│   ├── 02_clean                      # Dados limpos
│   └── 03_processed                  # Dados processados nas tabelas dimensão e fato
│
└── sql                               # Scripts SQL
    ├── 00_ingestao                   # Pasta com o script de carregamento dos dados brutos
    │   └── load_data.sql             # Script de ingestão dos dados
    │
    ├── 01_perfilamento               # Pasta com os scripts de perfilamento dos dados
    │
    ├── 02_limpeza                    # Pasta com scripts de limpeza dos dados
    │   ├── tratamentos               # Scripts de tratamento dos dados
    │   │   ├── dominio.sql
    │   │   ├── nulos.sql
    │   │   ├── outliers.sql
    │   │   └── validacao_somas.sql
    │   └── clean.sql                 # Script que consolida a limpeza
    │
    ├── 03_modelagem                  # Pasta com scripts de criação do modelo dimensional
    │   ├── 01_create_dim.sql         # Criação das tabelas dimensão
    │   └── 02_create_fato.sql        # Criação da tabela fato
    │
    ├── 04_carga                      # Pasta com scripts de carga das tabelas do modelo dimensional
    │   ├── 01_load_dim.sql           # Popula as tabelas dimensão
    │   └── 02_load_fato.sql          # Popula a tabela fato
    │
    └── 05_consultas                  # Consultas analíticas
        ├── data_horario.sql
        ├── financeiro.sql
        ├── localizacao.sql
        └── operacional.sql
```
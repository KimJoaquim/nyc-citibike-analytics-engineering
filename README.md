# Otimização de Mobilidade Urbana: Pipeline de Dados NYC Citi Bike 🚲📊

![Dashboard NYC Citi Bike](img/image_b85cc2.png)

Este projeto apresenta uma solução completa de **Analytics Engineering**, transformando dados brutos de milhões de viagens de bicicletas em Nova York em uma camada de dados modelada e pronta para análise estratégica.

## 🛠️ Stack Tecnológica
* **Armazenamento e Processamento:** Google BigQuery.
* **Linguagem:** SQL (Standard SQL).
* **Visualização de Dados:** Looker Studio.

## 🏗️ Arquitetura do Projeto
O pipeline foi estruturado seguindo as melhores práticas de modelagem de dados:
1. **Ingestão:** Conexão com o dataset público `new_york_citibike` via BigQuery Public Data.
2. **Transformação (Analytics Engineering):** Criação de tabelas agregadas para otimização de performance e custo.
3. **Business Intelligence:** Desenvolvimento de dashboards para identificação de padrões de demanda.

## 🔧 Modelagem de Dados (SQL)
Abaixo, a lógica utilizada para higienização e engenharia de atributos (feature engineering):

```sql
CREATE OR REPLACE TABLE analise_citibike.resumo_viagens AS
SELECT 
    start_station_name,
    EXTRACT(HOUR FROM starttime) AS hora_inicio,
    AVG(tripduration / 60) AS media_minutos,
    COUNT(*) AS total_viagens
FROM `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE start_station_name IS NOT NULL
GROUP BY 1, 2
ORDER BY total_viagens DESC;

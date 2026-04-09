# Otimização de Mobilidade Urbana: Pipeline de Dados NYC Citi Bike 🚲📊

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

## 🏗️ Arquitetura da Solução
O projeto foi estruturado utilizando a **Modern Data Stack**:
1. **Raw Data:** Dados brutos provenientes do Google Cloud Marketplace.
2. **Data Warehouse:** Google BigQuery para armazenamento e processamento.
3. **Transformation:** SQL para modelagem, limpeza e agregação de dados.
4. **BI & Analytics:** Looker Studio para visualização de indicadores de performance (KPIs).

## 💡 Insights Extraídos
* **Picos de Demanda:** Identificação clara de aumento de fluxo entre 17h e 19h (comportamento pendular corporativo).
* **Top Hubs:** Estações como Pershing Square North concentram o maior volume de viagens, sugerindo necessidade de logística prioritária.

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

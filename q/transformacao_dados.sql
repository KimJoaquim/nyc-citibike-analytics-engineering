-- Criação da tabela física no seu dataset pessoal
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

-- Agrupamento por hora para identificar janelas de alta demanda
SELECT 
    hora_inicio,
    SUM(total_viagens) AS volume_total
FROM analise_citibike.resumo_viagens
GROUP BY hora_inicio
ORDER BY hora_inicio ASC;

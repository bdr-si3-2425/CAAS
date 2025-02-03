--Quels logements nécessitent le plus d'intervention de maintenance, et pourquoi ?
SELECT
    l.id_logement,
    COUNT(m.id_maintenance) AS nombre_interventions,
    STRING_AGG(DISTINCT tm.type_maintenance, ', ') AS types_interventions
FROM maintenance m
         JOIN logements l ON m.id_logement = l.id_logement
         JOIN types_maintenance tm ON m.id_type_maintenance = tm.id_type_maintenance
GROUP BY l.id_logement
--HAVING COUNT(m.id_maintenance) > 5; si besoint on peut ajouter un filtre pour ne récupérer que les logements avec un certain nombre d'intervention minimum
ORDER BY nombre_interventions DESC;
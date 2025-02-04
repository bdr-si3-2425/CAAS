--requête supplémentaire 3 : Nombre moyen d'équipements par type de logement
SELECT
    t.type_logement,
    ROUND(AVG(equip_count.nb_equipements), 2) AS moyenne_equipements
FROM type_logements t
         JOIN logements l ON t.id_type_logement = l.id_type_logement
         JOIN (
    SELECT id_logement, COUNT(*) as nb_equipements
    FROM logements_equipements
    GROUP BY id_logement
) equip_count ON l.id_logement = equip_count.id_logement
GROUP BY t.type_logement
ORDER BY moyenne_equipements DESC;
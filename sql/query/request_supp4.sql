--requete supplémentaire 4 : Sites avec le plus de maintenances urgentes ce mois-ci
SELECT
    s.nom_site,
    COUNT(*) AS nb_maintenances_urgentes
FROM maintenance m
         JOIN logements l ON m.id_logement = l.id_logement
         JOIN site s ON l.id_site = s.id_site
WHERE m.urgence = true
  AND m.date >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY s.nom_site
ORDER BY nb_maintenances_urgentes DESC;
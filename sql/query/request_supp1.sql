--Quelle est la résidence la plus rentable ? > Classement des résidences en fonction de leur revenu total grâce aux réservations.
SELECT
    s.nom_site AS residence,
    SUM(ROUND(s.indice_forfaitaire * t.indice_forfaitaire * l.surface) * (r.date_fin - r.date_debut)) AS revenu_total
FROM reservations r
         JOIN logements l ON r.id_logement = l.id_logement
         JOIN site s ON l.id_site = s.id_site
         JOIN type_logements t ON l.id_type_logement = t.id_type_logement
GROUP BY s.nom_site
ORDER BY revenu_total DESC;

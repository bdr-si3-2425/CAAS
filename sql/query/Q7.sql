SELECT
    tl.type_logement,
    COUNT(DISTINCT rsv.id_reservation) AS nb_reservations,

    -- Sous-requête pour calculer le nombre moyen d'équipements par logement pour ce type
    round((
        SELECT AVG(somme.nb_equipements::numeric)
        FROM (
                 SELECT COUNT(le2.id_equipement) AS nb_equipements
                 FROM logements l2
                          LEFT JOIN logements_equipements le2 ON l2.id_logement = le2.id_logement
                 WHERE l2.id_type_logement = tl.id_type_logement
                 GROUP BY l2.id_logement
             ) somme
    ),2) AS nb_equipements_moyen,
    -- Sous-requête pour calculer le prix moyen d'une nuit pour ce type de logement
    round((
        SELECT AVG(0.8 * l2.surface * s2.indice_forfaitaire * tl2.indice_forfaitaire)
        FROM logements l2
                 JOIN site s2 ON l2.id_site = s2.id_site
                 JOIN type_logements tl2 ON l2.id_type_logement = tl2.id_type_logement
        WHERE tl2.id_type_logement = tl.id_type_logement
    ))AS prix_nuit_moyen

FROM type_logements tl
         JOIN logements l ON tl.id_type_logement = l.id_type_logement
         LEFT JOIN reservations rsv ON l.id_logement = rsv.id_logement
         LEFT JOIN logements_equipements le ON l.id_logement = le.id_logement
         LEFT JOIN equipements_logement el ON le.id_equipement = el.id_equipement
GROUP BY tl.type_logement, tl.id_type_logement
ORDER BY nb_reservations DESC;






SELECT
    l.id_logement,
    s.nom_site,
    tl.type_logement,
    COUNT(DISTINCT rsv.id_reservation) AS nb_reservations,
    ARRAY_AGG(DISTINCT el.nom_equipement) FILTER (WHERE el.nom_equipement IS NOT NULL) AS equipements_presents,
    ARRAY_AGG(DISTINCT es.nom_equipement) FILTER (WHERE es.nom_equipement IS NOT NULL) AS equipements_sur_site,
    round((AVG(0.8 * l.surface * s.indice_forfaitaire * tl.indice_forfaitaire)))AS prix_nuit

FROM logements l
         JOIN site s ON l.id_site = s.id_site
         JOIN type_logements tl ON l.id_type_logement = tl.id_type_logement
         LEFT JOIN reservations rsv ON l.id_logement = rsv.id_logement
         LEFT JOIN logements_equipements le ON l.id_logement = le.id_logement
         LEFT JOIN equipements_logement el ON le.id_equipement = el.id_equipement
         LEFT JOIN site_equipements se ON se.id_site = s.id_site
         LEFT JOIN equipements_site es ON es.id_equipement = se.id_equipement
GROUP BY l.id_logement,s.nom_site,tl.type_logement
ORDER BY nb_reservations DESC, s.nom_site, tl.type_logement;
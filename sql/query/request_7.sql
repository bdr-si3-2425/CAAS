/*
Question 7- Quels types de logements sont les plus demandés et quelles améliorations peuvent augmenter leur attractivité ?
Pour répondre à cette question on a fait deux requêtes.

La première permet de comparer les différents types de logements.
Pour chaque type de logement on voit le nombre de réservations associé pour observer quels types sont les plus et moins demandés.
Si on remarque qu'un type de logement est beaucoup moins demandé par exemple on peut essayer de trouver une raison à cela.
Pour chercher s'il y a une raison la table nous montre le nombre d'équipements moyen et le prix moyen d'une nuit par type de logement.
On peut par exemple se rendre compte qu'un type est moins demandé car il y a peu d'équipement ou que son prix est trop élevé.

La seconde requête permet de comparer chaque logement.
On voit quels sont les logements les plus et mois demandé.
Il y a écrit pour chaque logement leur nombre de réservations, leur site et leur type de logement.
Pour essayer de comprendre pourquoi des logements marchent mieux que d'autres on voit leurs équipements, les équipements qu'ils ont sur leur site et leurs prix pour une nuit.
*/



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
        SELECT AVG(l2.surface * s2.indice_forfaitaire * tl2.indice_forfaitaire)
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
    round((l.surface * s.indice_forfaitaire * tl.indice_forfaitaire))AS prix_nuit

FROM logements l
         JOIN site s ON l.id_site = s.id_site
         JOIN type_logements tl ON l.id_type_logement = tl.id_type_logement
         LEFT JOIN reservations rsv ON l.id_logement = rsv.id_logement
         LEFT JOIN logements_equipements le ON l.id_logement = le.id_logement
         LEFT JOIN equipements_logement el ON le.id_equipement = el.id_equipement
         LEFT JOIN site_equipements se ON se.id_site = s.id_site
         LEFT JOIN equipements_site es ON es.id_equipement = se.id_equipement
GROUP BY l.id_logement,s.nom_site,tl.type_logement,s.indice_forfaitaire,tl.indice_forfaitaire
ORDER BY nb_reservations DESC, s.nom_site, tl.type_logement;
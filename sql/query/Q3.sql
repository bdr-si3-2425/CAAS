SELECT
    reser.id_reservation,
    s.nom_site,
    l.id_logement,
    ARRAY_AGG(DISTINCT CONCAT(r.prenom, ' ', r.nom)) AS "Résidents actuels",
    --reser.date_debut,
    --reser.date_fin,
    ARRAY_AGG(DISTINCT CONCAT(' N°',c.id_conflit,': ',c.titre)) FILTER (WHERE c.id_conflit IS NOT NULL) AS "Conflits signalés",
    ARRAY_AGG(DISTINCT CONCAT(' N°',e.id_evenement,': ',e.titre)) FILTER (WHERE e.id_evenement IS NOT NULL) AS "Partiticapions aux evenements",

    BOOL_OR( -- TRUE si au moins un conflit implique uniquement des résidents de la même réservation
        EXISTS (
            SELECT 1
            FROM residents_conflits rc2
            WHERE rc2.id_conflit = c.id_conflit
            AND rc2.id_resident NOT IN (
                SELECT id_resident
                FROM residents_reservations
                WHERE id_reservation = reser.id_reservation
            )
        ) = FALSE
    ) AS "Conflit interne ?"

FROM logements l
    JOIN site s ON l.id_site=s.id_site
    JOIN reservations reser ON l.id_logement = reser.id_logement
    JOIN residents_reservations rr ON reser.id_reservation=rr.id_reservation
    JOIN residents r ON rr.id_resident = r.id_resident

    LEFT JOIN residents_conflits rc ON r.id_resident = rc.id_resident
    LEFT JOIN conflits c ON rc.id_conflit = c.id_conflit

    LEFT JOIN residents_evenement re ON r.id_resident = re.id_resident
    LEFT JOIN evenement e ON re.id_evenement = e.id_evenement

GROUP BY reser.id_reservation,l.id_logement, s.nom_site;





/*
WITH reservations_prev AS (
    SELECT
        *,
        LAG(date_fin) OVER (
            PARTITION BY id_logement
            ORDER BY date_debut
            ) AS prev_date_fin
    FROM reservations
),
     reservations_groups AS (
         SELECT
             *,
             SUM(CASE WHEN date_debut > prev_date_fin THEN 1 ELSE 0 END)
             OVER (PARTITION BY id_logement ORDER BY date_debut) AS group_id
         FROM reservations_prev
     )
SELECT
    rg.group_id,
    l.id_logement,
    s.nom_site,
    MIN(rg.date_debut) AS periode_debut,
    MAX(rg.date_fin) AS periode_fin,
    ARRAY_AGG(DISTINCT CONCAT(r.prenom, ' ', r.nom)) AS residents,
    COUNT(DISTINCT c.id_conflit) FILTER (WHERE c.id_conflit IS NOT NULL) AS conflits,
    COUNT(DISTINCT e.id_evenement) FILTER (WHERE e.id_evenement IS NOT NULL) AS evenements,
    BOOL_OR(c.id_conflit IS NOT NULL) AS conflit_interne
FROM reservations_groups rg
         JOIN logements l ON rg.id_logement = l.id_logement
         JOIN site s ON l.id_site = s.id_site
         JOIN residents_reservations rr ON rg.id_reservation = rr.id_reservation
         JOIN residents r ON rr.id_resident = r.id_resident
         LEFT JOIN residents_conflits rc ON r.id_resident = rc.id_resident
         LEFT JOIN conflits c ON rc.id_conflit = c.id_conflit
         LEFT JOIN residents_evenement re ON r.id_resident = re.id_resident
         LEFT JOIN evenement e ON re.id_evenement = e.id_evenement
GROUP BY rg.group_id, l.id_logement, s.nom_site;

 */
SELECT
    reser.id_reservation,
    s.nom_site,
    l.id_logement,
    ARRAY_AGG(DISTINCT CONCAT(r.prenom, ' ', r.nom)) AS "Résidents actuels",
    --reser.date_debut,
    --reser.date_fin,
    ARRAY_AGG(DISTINCT CONCAT(' N°',c.id_conflit,': ',c.titre)) FILTER (WHERE c.id_conflit IS NOT NULL) AS "Conflits signalés",
    ARRAY_AGG(DISTINCT CONCAT(' N°',e.id_evenement,': ',e.titre)) FILTER (WHERE e.id_evenement IS NOT NULL) AS "Partiticapions aux evenements",

    CASE
        WHEN (
                 SELECT COUNT(*)
                 FROM (
                          SELECT rc_inner.id_conflit
                          FROM residents_reservations rr_inner
                                   JOIN residents_conflits rc_inner ON rr_inner.id_resident = rc_inner.id_resident
                          WHERE rr_inner.id_reservation = reser.id_reservation
                          GROUP BY rc_inner.id_conflit
                          HAVING COUNT(DISTINCT rr_inner.id_resident) >= 2
                      ) sub
             ) > 0 THEN true
        ELSE false
        END AS "Conflit interne ?"


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
    COUNT(DISTINCT CASE
                       WHEN rc.id_resident NOT IN (
                           SELECT id_resident
                           FROM residents_reservations
                           WHERE id_reservation = reser.id_reservation
                       ) THEN c.id_conflit
        END) = 0 AS conflit_interne


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

    COUNT(DISTINCT CASE
    WHEN rc.id_resident NOT IN (
        SELECT id_resident
        FROM residents_reservations
        WHERE id_reservation = reser.id_reservation
    ) THEN c.id_conflit
END) = 0 AS "Conflit interne ?"

    CASE
        WHEN EXISTS (
            SELECT 1
            FROM residents_reservations rr1
                     JOIN residents_conflits rc1 ON rr1.id_resident = rc1.id_resident
                     JOIN residents_reservations rr2 ON rr1.id_reservation = rr2.id_reservation
                     JOIN residents_conflits rc2 ON rr2.id_resident = rc2.id_resident
            WHERE rr1.id_reservation = reser.id_reservation
              AND rc1.id_conflit = rc2.id_conflit
              AND rr1.id_resident <> rr2.id_resident
        ) THEN true
        ELSE false
    END AS "Conflit interne ?"
*/

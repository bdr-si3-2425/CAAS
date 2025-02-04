/*
Question 3- Quels résidents partagent actuellement un logement et quelles sont leurs interactions (participation à des événements, conflits signalés)

Pour chaque logement actuellement occupé, on voit la liste des résidents qui le partagent, ce qui permet d'identifier les colocataires.
La table affiche aussi les conflits signalés par ces résidents et les événements auxquels ils ont participé, offrant une vision de leurs interactions.
De plus, une colonne indique si un conflit interne existe entre colocataires, en vérifiant si plusieurs résidents d’un même logement sont impliqués dans un même conflit non résolu.
Cela permet d'identifier rapidement les logements où des tensions existent et de mieux comprendre la dynamique entre les résidents.
*/

SELECT
    reser.id_reservation,
    s.nom_site,
    l.id_logement,
    ARRAY_AGG(DISTINCT CONCAT(r.prenom, ' ', r.nom)) AS "Résidents actuels",
    ARRAY_AGG(DISTINCT CONCAT(' N°',c.id_conflit,': ',c.titre)) FILTER (WHERE c.id_conflit IS NOT NULL) AS "Conflits signalés",
    ARRAY_AGG(DISTINCT CONCAT(' N°',e.id_evenement,': ',e.titre)) FILTER (WHERE e.id_evenement IS NOT NULL) AS "Partiticapions aux evenements",
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM residents_reservations rr1
                     JOIN residents_conflits rc1 ON rr1.id_resident = rc1.id_resident
                     JOIN residents_reservations rr2 ON rr1.id_reservation = rr2.id_reservation
                     JOIN residents_conflits rc2 ON rr2.id_resident = rc2.id_resident
                     JOIN reservations res ON rr1.id_reservation = res.id_reservation
                     JOIN conflits conf ON rc1.id_conflit = conf.id_conflit
            WHERE res.id_logement = l.id_logement
              AND res.date_debut <= CURRENT_DATE AND res.date_fin >= CURRENT_DATE
              AND rc1.id_conflit = rc2.id_conflit AND conf.resolu = false
              AND rr1.id_resident < rr2.id_resident
        ) THEN true
        ELSE false
        END AS "Conflit interne dans le logement ?"

FROM logements l
         JOIN site s ON l.id_site=s.id_site
         JOIN reservations reser ON l.id_logement = reser.id_logement
         JOIN residents_reservations rr ON reser.id_reservation=rr.id_reservation
         JOIN residents r ON rr.id_resident = r.id_resident
         LEFT JOIN residents_conflits rc ON r.id_resident = rc.id_resident
         LEFT JOIN conflits c ON rc.id_conflit = c.id_conflit
         LEFT JOIN residents_evenement re ON r.id_resident = re.id_resident
         LEFT JOIN evenement e ON re.id_evenement = e.id_evenement
WHERE reser.date_debut<=CURRENT_DATE AND reser.date_fin>=CURRENT_DATE
GROUP BY reser.id_reservation,l.id_logement, s.nom_site
ORDER BY "Conflit interne dans le logement ?" DESC, l.id_logement;
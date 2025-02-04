--requête supplémentaire 3 : Taux d'occupation de chaque logement
SELECT
    l.id_logement,
    (nb_lits_simples + nb_lits_doubles * 2) AS capacite_totale,
    COUNT(DISTINCT r.id_resident) AS nombre_residents_actuels,
    ROUND(COUNT(DISTINCT r.id_resident) * 100.0 / (nb_lits_simples + nb_lits_doubles * 2), 2) AS taux_occupation
FROM
    logements l
        LEFT JOIN reservations res ON l.id_logement = res.id_logement
        LEFT JOIN residents_reservations rr ON res.id_reservation = rr.id_reservation
        LEFT JOIN residents r ON rr.id_resident = r.id_resident
WHERE CURRENT_DATE BETWEEN res.date_debut AND res.date_fin
GROUP BY
    l.id_logement, l.nb_lits_simples, l.nb_lits_doubles;
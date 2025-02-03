-- Vue sur la table reservations qui renvoie les réservations avec la date de fin mise à jour selon la date de fin trouvée dans prolongation pour la réservation en question
CREATE OR REPLACE VIEW reservations_dates_view AS
(
SELECT
    r.id_reservation AS "Numéro de réservation",
    r.id_logement AS "Numéro du logement",
    r.date_debut AS "Date de début",
    CASE
        WHEN p.date_fin_reservation IS NOT NULL THEN p.date_fin_reservation
        ELSE r.date_fin
        END AS "Date de fin"
FROM
    reservations r
        LEFT JOIN
    prolongations p ON r.id_reservation = p.id_reservation
ORDER BY "Numéro de réservation"
    );

select  * FROM reservations_dates_view;

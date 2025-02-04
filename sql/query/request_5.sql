-- 5. Quels résidents ont prolongé leur séjour ?

-- 5.1. Affichage des résidents pour chaque réservation qui a été prolongé (et détail sur logement reservé et résident(s))
SELECT
    resident.nom AS "Nom",
    resident.prenom AS "Prénom",
    resident.num_tel AS "Numéro de téléphone",
    resident.date_naissance AS "Date de naissance",
    typeL.type_logement AS "Type de logement",
    s.nom_site AS "Nom du site",
    reservation.date_debut AS "Date de début",
    prolongation.date_fin_reservation AS "Date de fin",
    reservation.id_reservation AS "Numéro de réservation"

FROM residents resident
         JOIN residents_reservations ON resident.id_resident = residents_reservations.id_resident
         JOIN prolongations prolongation ON prolongation.id_reservation= residents_reservations.id_reservation
         JOIN reservations reservation ON prolongation.id_reservation = reservation.id_reservation
         JOIN logements ON logements.id_logement =  reservation.id_logement
         JOIN type_logements typeL ON logements.id_type_logement = typeL.id_type_logement
         JOIN site s ON logements.id_site = s.id_site;


-- 5.2 Vue qui récupère toutes les réservations avec mise à jour sur la date de fin selon les prolongations dans la table prolongations
select  * FROM reservations_dates_view;


-- 5.3 Select pour récupérer les informations des résidents et de leur réservations selon la vue récupérant les réservations selon la date mise à jour dans prolongations
SELECT
    resident.nom AS "Nom",
    resident.prenom AS "Prénom",
    resident.num_tel AS "Numéro de téléphone",
    resident.date_naissance AS "Date de naissance",
    typeL.type_logement AS "Type de logement",
    s.nom_site AS "Nom du site",
    reservation."Date de début",
    reservation."Date de fin"

FROM residents resident
         JOIN residents_reservations ON resident.id_resident = residents_reservations.id_resident
         JOIN reservations_dates_view reservation ON reservation."Numéro de réservation"= residents_reservations.id_reservation
         JOIN logements ON logements.id_logement =  reservation."Numéro du logement"
         JOIN type_logements typeL ON logements.id_type_logement = typeL.id_type_logement
         JOIN site s ON logements.id_site = s.id_site;
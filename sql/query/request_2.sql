--PROBLEME : Comment gérer les réservations et attribuer les logements aux nouveaux résidents en optimisant l’occupation ?

CREATE OR REPLACE FUNCTION get_logement_optimise(
    p_date_debut DATE,
    p_date_fin DATE,
    p_type VARCHAR DEFAULT NULL,
    p_residence VARCHAR DEFAULT NULL,
    p_surface_min DECIMAL(6,2) DEFAULT NULL,
    p_capacite_lit_min INT DEFAULT NULL
) RETURNS TABLE (
    logement_id logements.id_logement%TYPE,
    type_logement type_logements.type_logement%TYPE,
    residence site.nom_site%TYPE,
    nb_chambre logements.nb_chambre%TYPE,
    lits_simples logements.nb_lits_simples%TYPE,
    lits_doubles logements.nb_lits_doubles%TYPE,
    surface logements.surface%TYPE
) AS $$
BEGIN
RETURN QUERY
    WITH logements_dispos AS (
        -- 1) Récupérer les logements disponibles pour la période demandée
        SELECT
            "Numero du logement" AS logement_id,  -- Correction des alias
            "Type de logement" AS type_logement,
            "Nom du site" AS residence,
            "Nombre de chambre" AS nb_chambre,
            "Nombre de lits simples" AS lits_simples,
            "Nombre de lits doubles" AS lits_doubles,
            "Surface du logement en m²" AS surface
        FROM get_logements_disponibles(
            p_date_debut, p_date_fin, p_type, p_residence, p_surface_min, p_capacite_lit_min
        )
    ),
    reservations_avant AS (
        -- 2) Trouver la réservation la plus proche AVANT la date de début
        SELECT r.id_logement, MAX(r.date_fin) AS date_fin
        FROM reservations r
        JOIN logements_dispos ld ON r.id_logement = ld.logement_id  -- Correction du nom de colonne
        WHERE r.date_fin < p_date_debut
        GROUP BY r.id_logement
    ),
    reservations_apres AS (
        -- 3) Trouver la réservation la plus proche APRÈS la date de fin
        SELECT r.id_logement, MIN(r.date_debut) AS date_debut
        FROM reservations r
        JOIN logements_dispos ld ON r.id_logement = ld.logement_id  -- Correction du nom de colonne
        WHERE r.date_debut > p_date_fin
        GROUP BY r.id_logement
    )

-- 4) Sélectionner le logement optimisé en minimisant la période d’inoccupation
SELECT
    ld.logement_id,
    ld.type_logement,
    ld.residence,
    ld.nb_chambre,
    ld.lits_simples,
    ld.lits_doubles,
    ld.surface
FROM logements_dispos ld
         LEFT JOIN reservations_avant ra ON ld.logement_id = ra.id_logement
         LEFT JOIN reservations_apres rp ON ld.logement_id = rp.id_logement
ORDER BY (p_date_debut - COALESCE(ra.date_fin, p_date_debut)) +
         (COALESCE(rp.date_debut, p_date_fin) - p_date_fin) ASC
    LIMIT 1;  -- Retourne le logement avec la plus petite période d’inoccupation
END;
$$ LANGUAGE plpgsql;


   
--Exemple d'utilisation
SELECT * FROM get_logement_optimise(
        '2025-07-01',
        '2025-07-15',
        'Studio',
        'Résidence Lemaire',
        100,
        2
);
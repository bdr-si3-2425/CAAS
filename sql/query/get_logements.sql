CREATE OR REPLACE FUNCTION get_logements_disponibles(
    start_date_wanted reservations.date_debut%TYPE,
    end_date_wanted reservations.date_fin%TYPE,
    type_logement_wanted type_logements.type_logement%TYPE,
    site_wanted site.nom_site%TYPE,
    surface_min_wanted logements.surface%TYPE,
    nb_chambres_min_wanted logements.nb_chambre%TYPE
)   RETURNS TABLE (
                      id_logement logements.id_logement%TYPE,
                      id_type_logement logements.id_type_logement%TYPE,
                      id_site logements.id_site%TYPE,
                      nb_chambre logements.nb_chambre%TYPE,
                      nb_lits_simples logements.nb_lits_simples%TYPE,
                      nb_lits_doubles logements.nb_lits_doubles%TYPE,
                      surface logements.surface%TYPE
                  )
    language plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            l.id_logement,
            l.id_type_logement,
            l.id_site,
            l.nb_chambre,
            l.nb_lits_simples,
            l.nb_lits_doubles,
            l.surface
        FROM logements l
            LEFT JOIN reservations r ON l.id_logement = r.id_logement
            JOIN site s on l.id_site = s.id_site
            JOIN type_logements tl on l.id_type_logement = tl.id_type_logement
        WHERE (
            r.id_logement IS NULL
                OR NOT (
                r.date_debut <= end_date_wanted
                    AND r.date_fin >= start_date_wanted
                )
            )
          AND (type_logement_wanted IS NULL OR tl.type_logement = type_logement_wanted)
          AND (site_wanted IS NULL OR s.nom_site = site_wanted)
          AND (surface_min_wanted IS NULL OR l.surface >= surface_min_wanted)
          AND (nb_chambres_min_wanted IS NULL OR l.nb_chambre >= nb_chambres_min_wanted);
END;
$$ ;

-- Le select que jutilisereqiiiis
SELECT *
FROM get_logements_disponibles(
        '2025-07-01',
        '2025-07-15',
        'Chalet',
        'Résidence Gonzalez',
        100,
     2
     );


SELECT *
FROM get_logements_disponibles(
        '2025-07-01',
        '2025-07-15',
        'Chalet',
        NULL,
        100,
        2
     );
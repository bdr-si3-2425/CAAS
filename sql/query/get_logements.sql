CREATE OR REPLACE FUNCTION get_logements_disponibles(
    start_date_wanted reservations.date_debut%TYPE,
    end_date_wanted reservations.date_fin%TYPE,
    type_logement_wanted type_logements.type_logement%TYPE,
    site_wanted site.nom_site%TYPE,
    surface_min_wanted logements.surface%TYPE,
    nb_chambres_min_wanted logements.nb_chambre%TYPE
)   RETURNS TABLE (
                      "Numero du logement" logements.id_logement%TYPE,
                      "Type de logement" type_logements.type_logement%TYPE,
                      "Nom du site" site.nom_site%TYPE,
                      "Nombre de chambre" logements.nb_chambre%TYPE,
                      "Nombre de lits simples" logements.nb_lits_simples%TYPE,
                      "Nombre de lits doubles" logements.nb_lits_doubles%TYPE,
                      "Surface du logement en m²" logements.surface%TYPE
                  )
    language plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT
            l.id_logement,
            tl.type_logement,
            s.nom_site,
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
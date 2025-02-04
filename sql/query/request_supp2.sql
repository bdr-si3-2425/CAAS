-- requête supplémentaire 2 : Tri des logements par tarif par nuit
SELECT
    l.id_logement,
    t.type_logement,
    s.nom_site AS residence,
    l.surface,
    ROUND(s.indice_forfaitaire * t.indice_forfaitaire * l.surface) AS tarif_nuit
FROM logements l
         JOIN site s ON l.id_site = s.id_site
         JOIN type_logements t ON l.id_type_logement = t.id_type_logement
ORDER BY tarif_nuit DESC;
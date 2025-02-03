


CREATE OR REPLACE FUNCTION get_residents_count_by_age(site_id INT, max_age INT)
    RETURNS TABLE
            (
                age   INT,
                count INT
            )
    LANGUAGE plpgsql
AS
$$
BEGIN
    CREATE OR REPLACE TEMPORARY VIEW current_residents AS
    (
    SELECT r.id_resident,
           r.prenom,
           r.nom,
           r.num_tel,
           r.date_naissance,
           res.id_reservation,
           res.id_logement,
           res.date_debut,
           res.date_fin
    FROM residents AS r
             JOIN residents_reservations AS rr ON r.id_resident = rr.id_resident
             JOIN reservations AS res ON rr.id_reservation = res.id_reservation
    WHERE res.date_debut < CURRENT_DATE
      AND res.date_fin > CURRENT_DATE
        );
    RETURN QUERY
        WITH RECURSIVE numbers AS (SELECT 0 AS num
                                   UNION ALL
                                   SELECT num + 1
                                   FROM numbers
                                   WHERE num < max_age)
        SELECT num                                   as age,
               (SELECT COUNT(*)::INT
                FROM current_residents as curr
                         join logements as l on curr.id_logement = l.id_logement AND l.id_site = site_id AND
                                                EXTRACT(YEAR FROM AGE(CURRENT_DATE, curr.date_naissance)) =
                                                num) as count
        FROM numbers;
END;
$$;

-- La visualisation des résidents actuels pour un site donné permet d'organiser des événements communautaires.
SELECT *
FROM get_residents_count_by_age(2, 100);
-- 1. Quels logements sont disponibles pour une période donnée, selon des critères spécifiques (type, emplacement, prix) ?

-- Exemples de select Pour avoir les logements disponibles à une période donnée :
SELECT *
FROM get_logements_disponibles(
        '2025-07-01',
        '2025-07-15',
        'Studio',
        NULL,
        100,
        2
     );

SELECT *
FROM get_logements_disponibles(
        '2025-07-01',
        '2025-07-15',
        'Studio',
        'Résidence Lemaire',
        100,
        2
     );




-- Insertion des données de test en batch


INSERT INTO site (adresse, ville, pays, code_postal, nom_site, indice_forfaitaire)
VALUES (
    'rue Fernandez',
    'Morin',
    'France',
    04328,
    'Résidence Roger',
    1.28
),(
    '7, chemin de Leblanc',
    'Descamps-sur-Mer',
    'France',
    83812,
    'Résidence Gonzalez',
    1.75
),(
    '97, rue Cécile Ferrand',
    'Louis',
    'France',
    17647,
    'Résidence Albert',
    1.01
);


INSERT INTO residents (nom, prenom, num_tel,date_naissance)
VALUES (
    'Guillot',
    'Alfred',
    '0382763225',
    '1936-03-18'
),(
    'Tessier',
    'Aurore',
    '+33 (0)2 44 14 42 77',
    '1934-10-30'
),(
    'Morel',
    'Thomas',
    '+33 (0)5 65 77 23 98',
    '1957-05-16'
),(
    'Morvan',
    'Jeannine',
    '+33 3 76 75 86 10',
    '1900-10-24'
),(
    'Letellier',
    'Véronique',
    '+33 3 87 25 00 19',
    '1987-10-29'
),(
    'Andre',
    'Amélie',
    '+33 (0)4 26 98 76 81',
    '1916-03-04'
),(
    'Jacquot',
    'Élisabeth',
    '0236389018',
    '1918-03-10'
),(
    'Perret',
    'Charlotte',
    '0230220859',
    '1994-03-24'
),(
    'Descamps',
    'Nathalie',
    '+33 1 80 95 21 65',
    '1944-10-20'
),(
    'Coste',
    'Éric',
    '0432541850',
    '1950-02-09'
),(
    'Dupont',
    'Paulette',
    '+33 (0)1 88 88 42 96',
    '1952-11-02'
),(
    'Mendès',
    'Suzanne',
    '0147306689',
    '1932-08-25'
),(
    'Joubert',
    'Alfred',
    '+33 (0)3 26 98 61 45',
    '1979-12-15'
),(
    'Dupré',
    'Bernard',
    '0559042207',
    '1938-01-24'
),(
    'Samson',
    'Alix',
    '+33 (0)7 94 19 95 43',
    '1946-01-17'
),(
    'Fernandez',
    'Dorothée',
    '+33 (0)3 67 64 74 93',
    '1996-07-25'
),(
    'Paul',
    'Michelle',
    '+33 (0)6 98 64 59 18',
    '1910-05-11'
),(
    'Albert',
    'Mathilde',
    '03 70 54 44 19',
    '1965-11-10'
),(
    'Lefort',
    'Monique',
    '+33 (0)2 29 54 68 92',
    '1984-04-04'
),(
    'Evrard',
    'Nicole',
    '0382126210',
    '1974-09-29'
),(
    'Petitjean',
    'Astrid',
    '0491029296',
    '1962-04-30'
),(
    'Roche',
    'Simone',
    '01 39 55 81 06',
    '1902-08-24'
),(
    'Guérin',
    'Guillaume',
    '0582213794',
    '2018-03-23'
),(
    'Chevalier',
    'Éléonore',
    '+33 (0)2 96 70 50 92',
    '1952-07-24'
),(
    'Foucher',
    'Émilie',
    '+33 2 97 33 38 79',
    '2022-01-12'
);


INSERT INTO logements (id_type_logement, id_site, nb_chambre, nb_lits_simples, nb_lits_doubles, surface)
VALUES (
    2,
    2,
    1,
    3,
    1,
    82.41
),(
    7,
    1,
    4,
    0,
    0,
    113.86
),(
    5,
    1,
    2,
    3,
    2,
    118.34
),(
    6,
    1,
    3,
    4,
    1,
    40.9
),(
    7,
    2,
    2,
    3,
    0,
    107.58
),(
    3,
    1,
    3,
    4,
    0,
    47.85
),(
    5,
    1,
    1,
    3,
    0,
    116.24
),(
    6,
    3,
    3,
    2,
    2,
    92.26
);


INSERT INTO reservations (id_logement, date_debut, date_fin)
VALUES (
    7,
    '2025-01-22',
    '2025-02-05'
),(
    3,
    '2025-04-27',
    '2025-04-28'
),(
    7,
    '2025-04-09',
    '2025-04-23'
),(
    3,
    '2025-01-12',
    '2025-01-23'
),(
    8,
    '2025-03-08',
    '2025-03-16'
),(
    2,
    '2025-01-03',
    '2025-01-09'
),(
    3,
    '2025-01-28',
    '2025-02-02'
),(
    1,
    '2025-01-09',
    '2025-01-20'
),(
    1,
    '2025-01-18',
    '2025-01-30'
),(
    4,
    '2025-01-05',
    '2025-01-18'
);


INSERT INTO evenement (id_categorie, titre, id_site, date_evenement, description)
VALUES (
    2,
    'Soirée Jeux de Société',
    3,
    '2025-04-19',
    'Venez découvrir notre collection de jeux et partagez vos favoris avec la communauté.'
),(
    5,
    'Soirée Jeux de Société',
    3,
    '2025-03-29',
    'Venez découvrir notre collection de jeux et partagez vos favoris avec la communauté.'
),(
    4,
    'Brunch Participatif',
    2,
    '2025-03-17',
    'Chacun apporte quelque chose pour un brunch convivial dans l''espace commun.'
),(
    4,
    'Meditation Collective',
    3,
    '2025-04-06',
    'Une heure de méditation guidée pour décompresser ensemble.'
),(
    4,
    'Atelier Jardinage',
    2,
    '2025-02-15',
    'Entretenons ensemble notre jardin partagé et échangeons nos conseils.'
),(
    2,
    'Soirée Jeux de Société',
    1,
    '2025-02-14',
    'Venez découvrir notre collection de jeux et partagez vos favoris avec la communauté.'
),(
    1,
    'Atelier Jardinage',
    1,
    '2025-04-13',
    'Entretenons ensemble notre jardin partagé et échangeons nos conseils.'
),(
    3,
    'Session de Coworking',
    2,
    '2025-04-07',
    'Travaillons ensemble dans l''espace de coworking avec café et snacks offerts.'
),(
    1,
    'Atelier Jardinage',
    1,
    '2025-03-11',
    'Entretenons ensemble notre jardin partagé et échangeons nos conseils.'
),(
    1,
    'Soirée Jeux de Société',
    2,
    '2025-03-17',
    'Venez découvrir notre collection de jeux et partagez vos favoris avec la communauté.'
);
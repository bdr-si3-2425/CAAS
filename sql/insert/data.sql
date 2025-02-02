-- Insertion des données de test en batch


INSERT INTO site (adresse, ville, pays, code_postal, nom_site, indice_forfaitaire)
VALUES (
    '8, avenue Jeanne Humbert',
    'Weiss',
    'France',
    38910,
    'Résidence Alexandre',
    1.1
),(
    '43, avenue Rossi',
    'KleinBourg',
    'France',
    80687,
    'Résidence Guibert',
    1.19
),(
    '385, chemin Teixeira',
    'Seguin',
    'France',
    20267,
    'Résidence Fouquet',
    1.21
);


INSERT INTO residents (nom, prenom, num_tel,date_naissance)
VALUES (
    'Denis',
    'Aimé',
    '+33 1 58 02 91 56',
    '1904-12-12'
),(
    'Martin',
    'Claude',
    '0297802195',
    '1987-06-16'
),(
    'Gonzalez',
    'David',
    '+33 (0)4 27 99 56 41',
    '1904-08-11'
),(
    'Gosselin',
    'Adrienne',
    '+33 (0)1 40 02 17 00',
    '1983-07-02'
),(
    'Guilbert',
    'Margot',
    '+33 3 60 29 66 56',
    '2010-08-22'
),(
    'Chevalier',
    'Lucy',
    '+33 7 81 17 97 96',
    '1985-05-09'
),(
    'Delorme',
    'Xavier',
    '+33 (0)5 53 04 12 01',
    '1908-03-01'
),(
    'Le Goff',
    'Pénélope',
    '+33 2 85 41 75 91',
    '1907-12-20'
),(
    'Raynaud',
    'Laurent',
    '04 66 03 93 85',
    '1903-02-11'
),(
    'Rossi',
    'Grégoire',
    '04 37 07 73 07',
    '2005-12-19'
),(
    'Mary',
    'Henriette',
    '+33 (0)2 96 89 43 79',
    '2019-02-01'
),(
    'Pascal',
    'Tristan',
    '+33 (0)5 59 52 10 49',
    '2011-06-23'
),(
    'Guilbert',
    'Aimée',
    '+33 2 55 22 67 68',
    '2003-05-23'
),(
    'Leroux',
    'Philippine',
    '0231192525',
    '1909-05-19'
),(
    'Garcia',
    'Rémy',
    '0413257059',
    '1910-02-22'
),(
    'Jacob',
    'Sabine',
    '0698085129',
    '1961-12-17'
),(
    'Lopez',
    'Patrick',
    '0481393931',
    '1978-02-23'
),(
    'Picard',
    'Valérie',
    '+33 4 30 21 63 29',
    '1941-09-17'
),(
    'Fleury',
    'Charlotte',
    '+33 7 71 00 09 84',
    '2003-01-30'
),(
    'Cohen',
    'Jacques',
    '0258192758',
    '1943-05-30'
),(
    'Bouvier',
    'Isabelle',
    '03 83 56 13 45',
    '1969-11-14'
),(
    'Langlois',
    'Victoire',
    '+33 2 58 18 02 58',
    '1919-10-16'
),(
    'Guichard',
    'Colette',
    '0468270692',
    '1945-10-03'
),(
    'Techer',
    'Honoré',
    '0631636800',
    '1978-07-16'
),(
    'Dupuis',
    'Laure',
    '0586390878',
    '1998-10-19'
);


INSERT INTO logements (id_type_logement, id_site, nb_chambre, nb_lits_simples, nb_lits_doubles, surface)
VALUES (
    1,
    2,
    4,
    1,
    0,
    42.52
),(
    5,
    3,
    4,
    4,
    2,
    109.25
),(
    5,
    1,
    2,
    4,
    1,
    66.56
),(
    4,
    3,
    4,
    0,
    1,
    130.57
),(
    5,
    2,
    2,
    0,
    1,
    65.95
),(
    2,
    3,
    3,
    4,
    0,
    137.44
),(
    2,
    3,
    1,
    2,
    2,
    77.58
),(
    6,
    1,
    1,
    2,
    0,
    126.05
);


INSERT INTO reservations (id_logement, date_debut, date_fin)
VALUES (
    7,
    '2025-03-07',
    '2025-03-14'
),(
    3,
    '2025-02-14',
    '2025-02-19'
),(
    6,
    '2025-03-17',
    '2025-03-31'
),(
    3,
    '2025-02-06',
    '2025-02-14'
),(
    1,
    '2025-03-16',
    '2025-03-19'
),(
    7,
    '2025-02-09',
    '2025-02-13'
),(
    2,
    '2025-03-09',
    '2025-03-15'
),(
    6,
    '2025-05-01',
    '2025-05-10'
),(
    2,
    '2025-03-22',
    '2025-04-04'
),(
    8,
    '2025-02-18',
    '2025-02-23'
);


INSERT INTO conflits (etat, titre, description, date_signalement)
VALUES (
    'False',
    'Tapage nocturne',
    'Les résidents ont organisé une fête très bruyante toute la nuit.',
    '2025-01-01'    
),(
    'False',
    'Bagarre',
    'Bagarre autour d''une place de parking.',
    '2024-12-21'    
),(
    'False',
    'Vol',
    'Des objets ont disparu dans la buanderie partagée.',
    '2025-01-08'    
),(
    'False',
    'Vol',
    'Un vélo a été volé dans le parking résidentiel.',
    '2025-01-11'    
),(
    'False',
    'Vol',
    'Des objets ont disparu dans la buanderie partagée.',
    '2025-01-02'    
),(
    'False',
    'Tapage nocturne',
    'Les résidents ont organisé une fête très bruyante toute la nuit.',
    '2024-11-25'    
);


INSERT INTO residents_conflits (id_resident, id_conflit)
VALUES (
    10,
    2
),(
    9,
    2
),(
    16,
    4
),(
    6,
    2
),(
    21,
    4
),(
    22,
    3
),(
    17,
    6
),(
    13,
    5
),(
    1,
    6
),(
    24,
    1
),(
    23,
    1
),(
    8,
    1
),(
    4,
    2
),(
    10,
    5
),(
    15,
    1
);


INSERT INTO maintenance(date, description, rapport, urgence, id_logement, id_type_maintenance)
VALUES (
    2024-02-07,
    'Description : Amélioration et modernisation des équipements et infrastructures.',
    'Rapport : Maintenance évolutive',
    True,
    2,
    6
),(
    2025-01-03,
    'Description : Amélioration et modernisation des équipements et infrastructures.',
    'Rapport : Maintenance évolutive',
    False,
    4,
    10
),(
    2024-10-12,
    'Description : Amélioration et modernisation des équipements et infrastructures.',
    'Rapport : Maintenance évolutive',
    True,
    7,
    4
),(
    2024-02-16,
    'Description : Amélioration et modernisation des équipements et infrastructures.',
    'Rapport : Maintenance évolutive',
    False,
    7,
    5
),(
    2024-05-02,
    'Description : Amélioration et modernisation des équipements et infrastructures.',
    'Rapport : Maintenance évolutive',
    True,
    7,
    5
),(
    2023-12-10,
    'Description : Amélioration et modernisation des équipements et infrastructures.',
    'Rapport : Maintenance évolutive',
    True,
    2,
    1
),(
    2024-05-09,
    'Description : Amélioration et modernisation des équipements et infrastructures.',
    'Rapport : Maintenance évolutive',
    False,
    6,
    10
);


INSERT INTO evenement (id_categorie, titre, id_site, date_evenement, description)
VALUES (
    2,
    'Session de Coworking',
    1,
    '2025-04-15',
    'Travaillons ensemble dans l''espace de coworking avec café et snacks offerts.'
),(
    5,
    'Brunch Participatif',
    3,
    '2025-01-06',
    'Chacun apporte quelque chose pour un brunch convivial dans l''espace commun.'
),(
    6,
    'Atelier Jardinage',
    1,
    '2025-03-23',
    'Entretenons ensemble notre jardin partagé et échangeons nos conseils.'
),(
    1,
    'Apéro Colocataires',
    3,
    '2025-01-21',
    'Moment convivial de rencontre entre tous les résidents autour d''un apéritif partagé.'
),(
    6,
    'Apéro Colocataires',
    2,
    '2025-03-18',
    'Moment convivial de rencontre entre tous les résidents autour d''un apéritif partagé.'
),(
    1,
    'Soirée Jeux de Société',
    2,
    '2025-02-17',
    'Venez découvrir notre collection de jeux et partagez vos favoris avec la communauté.'
),(
    2,
    'Session de Coworking',
    1,
    '2025-01-05',
    'Travaillons ensemble dans l''espace de coworking avec café et snacks offerts.'
),(
    1,
    'Apéro Colocataires',
    3,
    '2025-01-10',
    'Moment convivial de rencontre entre tous les résidents autour d''un apéritif partagé.'
),(
    6,
    'Brunch Participatif',
    1,
    '2025-01-12',
    'Chacun apporte quelque chose pour un brunch convivial dans l''espace commun.'
),(
    4,
    'Session de Coworking',
    2,
    '2025-03-03',
    'Travaillons ensemble dans l''espace de coworking avec café et snacks offerts.'
);
from sqlite3 import Cursor
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker(['fr_FR'], seed=Faker.seed(0))



NUM_SITES = 45
NUM_LOGEMENTS = 300
NUM_RESIDENTS = 2000
NUM_RESERVATION = 2000
NUM_EVENEMENT = 200
NUM_CONFLICTS = 100
NUM_PROLONGATION = 350
NUM_MAINTENANCE = 300

#enums:
NB_TYPE_LOGEMENTS=8
NB_CATEGORIE=6
NUM_TYPE_MAINTENANCE = 7
NUM_EQUIPEMENTS_SITE=11
NUM_EQUIPEMENTS_LOGEMENT=14

#links:
NUM_LINKS_RESIDENTS_RESERVATIONS = 3600
NUM_LINKS_RESIDENTS_CONFLITS = 800
NUM_LINKS_RESIDENTS_EVENEMENT = 1200
NUM_LINKS_EQUIPEMENTS_SITE = 75
NUM_LINKS_EQUIPEMENTS_LOGEMENTS = 600



def random_country_biased():
    fake = Faker()
    countries = ["France"] * 40 + [fake.country() for _ in range(10)]  # Plus de chances d'obtenir "France"
    return random.choice(countries)

def generate_site_inserts(num_sites):
    values = []
    for _ in range(num_sites):
        values.append(f"""(
    '{fake.street_address().replace("'", "''")}',
    '{fake.city().replace("'", "''")}',
    '{random_country_biased().replace("'", "''")}',
    {fake.postcode()},
    'Résidence {fake.last_name().replace("'", "''")}',
    {round(random.uniform(1.0, 2.0), 2)}
)""")

    return f"""
INSERT INTO site (adresse, ville, pays, code_postal, nom_site, indice_forfaitaire)
VALUES {','.join(values)};"""


def generate_resident_inserts(num_residents):
    values = []
    mean_age = 35  # Âge moyen
    std_dev_age = 10  # Écart type de l'âge

    for _ in range(num_residents):
        age = int(random.normalvariate(mean_age, std_dev_age))
        birth_date = datetime.now() - timedelta(days=age * 365)
        values.append(f"""(
        '{fake.last_name().replace("'", "''")}',
        '{fake.first_name().replace("'", "''")}',
        '{fake.phone_number().replace("'", "''")}',
        '{birth_date.date()}'
)""")

    return f"""
INSERT INTO residents (nom, prenom, num_tel,date_naissance)
VALUES {','.join(values)};"""


def generate_logements_inserts(num_logements):
    values = []
    for _ in range(num_logements):
        nb_lits_simples=random.randint(0, 4)
        if nb_lits_simples == 0: nb_lits_doubles=random.randint(1, 2)
        else: nb_lits_doubles=random.randint(0, 2)
        values.append(f"""(
    {random.randint(1, NB_TYPE_LOGEMENTS)},
    {random.randint(1, NUM_SITES)},
    {random.randint(1, 4)},
    {nb_lits_simples},
    {nb_lits_doubles},
    {round(random.uniform(20.0, 150.0), 2)}
)""")

    return f"""
INSERT INTO logements (id_type_logement, id_site, nb_chambre, nb_lits_simples, nb_lits_doubles, surface)
VALUES {','.join(values)};"""


def generate_reservations_inserts(num_reservations):
    values = []
    for _ in range(num_reservations):
        start_date = fake.date_between(start_date='-30d', end_date='+30d')
        end_date = start_date + timedelta(days=random.randint(7, 100))
        values.append(f"""(
    {random.randint(1, NUM_LOGEMENTS)},
    '{start_date}',
    '{end_date}'
)""")

    return f"""
INSERT INTO reservations (id_logement, date_debut, date_fin)
VALUES {','.join(values)};"""


def generate_residents_reservations_inserts(num_links):
    pairs = set() # Pour éviter répet des primary key
    values = []
    while len(pairs) < num_links:
        id_resident = random.randint(1, NUM_RESIDENTS)
        id_reservation = random.randint(1, NUM_RESERVATION)
        if(id_resident, id_reservation) not in pairs:
            pairs.add((id_resident, id_reservation))
            values.append(f"""(
    {id_resident},
    {id_reservation}
)""")

    return f"""
INSERT INTO residents_reservations (id_resident, id_reservation)
VALUES {','.join(values)};"""



def generate_logements_equipements_inserts(num_links):
    values = []
    pairs = set() # Pour éviter répet des primary key
    while len(pairs) < num_links:
        id_logement = random.randint(1, NUM_LOGEMENTS)
        id_equipement = random.randint(1, NUM_EQUIPEMENTS_LOGEMENT)
        if(id_logement, id_equipement) not in pairs:
            pairs.add((id_logement, id_equipement))
            values.append(f"""(
    {id_logement},
    {id_equipement}
)""")

    return f"""
INSERT INTO logements_equipements (id_logement, id_equipement)
VALUES {','.join(values)};"""


def generate_equipements_site_inserts(num_links):
    values = []
    pairs = set() # Pour éviter répet des primary key
    while len(pairs) < num_links:
        id_site = random.randint(1, NUM_SITES)
        id_equipement = random.randint(1, NUM_EQUIPEMENTS_SITE)
        if(id_site, id_equipement) not in pairs:
            pairs.add((id_site, id_equipement))
            values.append(f"""(
    {id_site},
    {id_equipement}
)""")

    return f"""
INSERT INTO site_equipements(id_site, id_equipement)
VALUES {','.join(values)};"""

def generate_maintenance_inserts(num_maintenance=10):
    values = []
    titres_maintenance = [
        "Maintenance préventive",
        "Maintenance corrective",
        "Maintenance curative",
        "Maintenance prédictive",
        "Maintenance saisonnière",
        "Maintenance esthétique",
        "Maintenance hygiénique",
        "Maintenance énergétique",
        "Maintenance légale",
        "Maintenance évolutive",
    ]
    descriptions = [
        "Vérification régulière des équipements pour éviter les pannes.",
        "Réparation des éléments défectueux après une panne.",
        "Intervention rapide pour remettre en état un équipement endommagé.",
        "Surveillance des installations pour anticiper les défaillances.",
        "Entretien spécifique en fonction des saisons (chauffage en hiver, climatisation en été).",
        "Rafraîchissement des peintures, revêtements et finitions.",
        "Nettoyage en profondeur pour éviter moisissures et nuisibles.",
        "Optimisation des installations pour réduire la consommation d’énergie.",
        "Respect des obligations réglementaires (diagnostics, normes de sécurité).",
        "Amélioration et modernisation des équipements et infrastructures.",
    ]

    for _ in range(num_maintenance):
        titre_index = random.randint(0, len(titres_maintenance) - 1)
        titre = titres_maintenance[titre_index]
        description = descriptions[titre_index]
        values.append(f"""(
        
    '{fake.date_between(start_date='-600d', end_date='+0d')}',
    '{"Description : " +description.replace("'", "''")}',
    '{"Rapport : "+ titre.replace("'", "''")}',
    {fake.boolean()},
    {random.randint(1, NUM_LOGEMENTS)},
    {random.randint(1, NUM_TYPE_MAINTENANCE)}
)""")

    return f"""
INSERT INTO maintenance(date, description, rapport, urgence, id_logement, id_type_maintenance)
VALUES {','.join(values)};"""

def generate_conflits_inserts(num_conflicts):
    values = []
    for _ in range(num_conflicts):

        conflicts_tilte_description = {
            "Bagarre": [
                "Bagarre autour d'une place de parking.",
                "Altercation pour avoir la dernière chaise longue au bord de la piscine.",
                "Dispute physique lors d'un événement résidentiel."
            ],
            "Tapage nocturne": [
                "Musique très forte jusqu'à 3 heures du matin.",
                "Les résidents ont organisé une fête très bruyante toute la nuit.",
                "Des cris incessants dans les couloirs après minuit."
            ],
            "Vol": [
                "Un résident a été surpris en train de voler une serviette au bord de la piscine.",
                "Un vélo a été volé dans le parking résidentiel.",
                "Des objets ont disparu dans la buanderie partagée."
            ]
        }
        title = fake.random_element(elements=conflicts_tilte_description.keys())
        description = fake.random_element(elements=conflicts_tilte_description[title])
        signal_date = fake.date_between(start_date='-90d', end_date='+0d')
        state = fake.boolean(chance_of_getting_true=0)

        # Escape the description to handle apostrophes
        escaped_description = description.replace("'", "''")

        values.append(f"""(
    '{state}',
    '{title}',
    '{escaped_description}',
    '{signal_date}'    
)""")

    return f"""
INSERT INTO conflits (resolu, titre, description, date_signalement)
VALUES {','.join(values)};"""

def generate_residents_conflits_inserts(num_links):
    pairs = set() # Pour éviter répet des primary key
    values = []
    while len(pairs) < num_links:
        id_resident = random.randint(1, NUM_RESIDENTS)
        id_conflit = random.randint(1, NUM_CONFLICTS)
        if(id_resident, id_conflit) not in pairs:
            pairs.add((id_resident, id_conflit))
            values.append(f"""(
    {id_resident},
    {id_conflit}
)""")

    return f"""
INSERT INTO residents_conflits (id_resident, id_conflit)
VALUES {','.join(values)};"""

def generate_evenement_inserts(num_evenement):
    values = []
    titres_evenements = [
        "Apéro Colocataires",
        "Soirée Jeux de Société",
        "Brunch Participatif",
        "Session de Coworking",
        "Meditation Collective",
        "Atelier Jardinage",
    ]
    descriptions = [
        "Moment convivial de rencontre entre tous les résidents autour d'un apéritif partagé.",
        "Venez découvrir notre collection de jeux et partagez vos favoris avec la communauté.",
        "Chacun apporte quelque chose pour un brunch convivial dans l'espace commun.",
        "Travaillons ensemble dans l'espace de coworking avec café et snacks offerts.",
        "Une heure de méditation guidée pour décompresser ensemble.",
        "Entretenons ensemble notre jardin partagé et échangeons nos conseils.",
    ]

    for _ in range(num_evenement):
        titre_index = random.randint(0, len(titres_evenements) - 1)
        titre = titres_evenements[titre_index]
        description = descriptions[titre_index]
        date = fake.date_between(start_date='-30d', end_date='+90d')
        values.append(f"""(
    {random.randint(1, NB_CATEGORIE)},
    '{titre.replace("'", "''")}',
    {random.randint(1, NUM_SITES)},
    '{date}',
    '{description.replace("'", "''")}'
)""")

    return f"""
INSERT INTO evenement (id_categorie, titre, id_site, date_evenement, description)
VALUES {','.join(values)};"""

def generate_residents_evenement_inserts(num_links):
    pairs = set() # Pour éviter répet des primary key
    values = []
    while len(pairs) < num_links:
        id_resident = random.randint(1, NUM_RESIDENTS)
        id_evenement = random.randint(1, NUM_EVENEMENT)
        if(id_resident, id_evenement) not in pairs:
            pairs.add((id_resident, id_evenement))
            values.append(f"""(
    {id_resident},
    {id_evenement}
)""")

    return f"""
INSERT INTO residents_evenement (id_resident, id_evenement)
VALUES {','.join(values)};"""


def generate_prolongation_reservation_inserts():
    values = []
    for _ in range (NUM_PROLONGATION):
        id_reservation = random.randint(1, NUM_RESERVATION)
        date_fin_reservation = fake.date_between(start_date='+91d', end_date='+120d') + timedelta(days=random.randint(15, 30))
        values.append(f"""(
    {id_reservation},
    '{date_fin_reservation}'
)""")

    return f"""
INSERT INTO prolongations (id_reservation, date_fin_reservation)
VALUES {','.join(values)};"""


# Générer le fichier SQL final
with open('../sql/insert/data.sql', 'w', encoding='utf-8') as f:
    f.write("-- Insertion des données de test en batch\n\n")
    f.write(generate_site_inserts(NUM_SITES))
    f.write("\n\n")
    f.write(generate_resident_inserts(NUM_RESIDENTS))
    f.write("\n\n")
    f.write(generate_logements_inserts(NUM_LOGEMENTS))
    f.write("\n\n")
    f.write(generate_reservations_inserts(NUM_RESERVATION))
    f.write("\n\n")
    f.write(generate_residents_reservations_inserts(NUM_LINKS_RESIDENTS_RESERVATIONS))
    f.write("\n\n")
    f.write(generate_conflits_inserts(NUM_CONFLICTS))
    f.write("\n\n")
    f.write(generate_residents_conflits_inserts(NUM_LINKS_RESIDENTS_CONFLITS))
    f.write("\n\n")
    f.write(generate_equipements_site_inserts(NUM_LINKS_EQUIPEMENTS_SITE))
    f.write("\n\n")
    f.write(generate_logements_equipements_inserts(NUM_LINKS_EQUIPEMENTS_LOGEMENTS))
    f.write("\n\n")
    f.write(generate_maintenance_inserts(NUM_MAINTENANCE))
    f.write("\n\n")
    f.write(generate_evenement_inserts(NUM_EVENEMENT))
    f.write("\n\n")
    f.write(generate_residents_evenement_inserts(NUM_LINKS_RESIDENTS_EVENEMENT))
    f.write("\n\n")
    f.write(generate_prolongation_reservation_inserts())
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker(['fr_FR'], seed=0)

NUM_SITES=3
NUM_LOGEMENTS=8
NUM_RESIDENTS=25
NUM_RESERVATION=10
NUM_EVENEMENT=10
NUM_CONFLICTS=6
#enums:
NB_TYPE_LOGEMENTS=8
NB_CATEGORIE=6
NB_TYPE_MAINTENANCE=7

#links:
NUM_LINKS_RESIDENTS_RESERVATIONS=30
NUM_LINKS_RESIDENTS_CONFLITS=15

def generate_site_inserts(num_sites):
    values = []
    for _ in range(num_sites):
        values.append(f"""(
    '{fake.street_address().replace("'", "''")}',
    '{fake.city().replace("'", "''")}',
    'France',
    {fake.postcode()},
    'Résidence {fake.last_name().replace("'", "''")}',
    {round(random.uniform(1.0, 2.0), 2)}
)""")

    return f"""
INSERT INTO site (adresse, ville, pays, code_postal, nom_site, indice_forfaitaire)
VALUES {','.join(values)};"""


def generate_resident_inserts(num_residents):
    values = []
    for _ in range(num_residents):
        date = fake.date_between(start_date='-125y', end_date='today')
        values.append(f"""(
    '{fake.last_name().replace("'", "''")}',
    '{fake.first_name().replace("'", "''")}',
    '{fake.phone_number().replace("'", "''")}',
    '{date}'
)""")

    return f"""
INSERT INTO residents (nom, prenom, num_tel,date_naissance)
VALUES {','.join(values)};"""


def generate_logements_inserts(num_logements):
    values = []
    for _ in range(num_logements):
        values.append(f"""(
    {random.randint(1, NB_TYPE_LOGEMENTS)},
    {random.randint(1, NUM_SITES)},
    {random.randint(1, 4)},
    {random.randint(0, 4)},
    {random.randint(0, 2)},
    {round(random.uniform(20.0, 150.0), 2)}
)""")

    return f"""
INSERT INTO logements (id_type_logement, id_site, nb_chambre, nb_lits_simples, nb_lits_doubles, surface)
VALUES {','.join(values)};"""


def generate_reservations_inserts(num_reservations):
    values = []
    for _ in range(num_reservations):
        start_date = fake.date_between(start_date='-30d', end_date='+90d')
        end_date = start_date + timedelta(days=random.randint(1, 14))
        values.append(f"""(
    {random.randint(1, NUM_LOGEMENTS)},
    '{start_date}',
    '{end_date}'
)""")

    return f"""
INSERT INTO reservations (id_logement, date_debut, date_fin)
VALUES {','.join(values)};"""


def generate_residents_reservations_inserts(num_links):
    values = []
    pairs = set() # Pour éviter répet des primary key
    while len(pairs) < num_links:
        id_resident = random.randint(1, NUM_RESIDENTS)
        id_reservation = random.randint(1, NUM_RESERVATION)
        if(id_resident, id_reservation) not in pairs:
            values.append(f"""(
    {id_resident},
    {id_reservation}
)""")

    return f"""
INSERT INTO residents_reservations (id_resident, id_reservation)
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
INSERT INTO conflits (etat, titre, description, date_signalement)
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
    # f.write(generate_residents_reservations_inserts())
    # f.write("\n\n")
    f.write(generate_conflits_inserts(NUM_CONFLICTS))
    f.write("\n\n")
    f.write(generate_residents_conflits_inserts(NUM_LINKS_RESIDENTS_CONFLITS))
    f.write("\n\n")
    f.write(generate_evenement_inserts(NUM_EVENEMENT))
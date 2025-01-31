from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker(['fr_FR'], seed=0)


def generate_site_inserts(num_sites=5):
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


def generate_resident_inserts(num_residents=20):
    values = []
    for _ in range(num_residents):
        values.append(f"""(
    '{fake.last_name().replace("'", "''")}',
    '{fake.first_name().replace("'", "''")}',
    '{fake.phone_number().replace("'", "''")}'
)""")

    return f"""
INSERT INTO residents (nom, prenom, num_tel)
VALUES {','.join(values)};"""


def generate_logements_inserts(num_logements=30):
    values = []
    for _ in range(num_logements):
        values.append(f"""(
    {random.randint(1, 8)},
    {random.randint(1, 5)},
    {random.randint(1, 4)},
    {random.randint(0, 4)},
    {random.randint(0, 2)},
    {round(random.uniform(20.0, 150.0), 2)}
)""")

    return f"""
INSERT INTO logements (id_type_logement, id_site, nb_chambre, nb_lits_simples, nb_lits_doubles, surface)
VALUES {','.join(values)};"""


def generate_reservations_inserts(num_reservations=50):
    values = []
    for _ in range(num_reservations):
        start_date = fake.date_between(start_date='-30d', end_date='+90d')
        end_date = start_date + timedelta(days=random.randint(1, 14))
        values.append(f"""(
    {random.randint(1, 30)},
    '{start_date}',
    '{end_date}'
)""")

    return f"""
INSERT INTO reservations (id_logement, date_debut, date_fin)
VALUES {','.join(values)};"""


def generate_residents_reservations_inserts(num_links=70):
    values = []
    pairs = set() # Pour éviter répet des primary key
    while len(pairs) < num_links:
        id_resident = random.randint(1, 20)
        id_reservation = random.randint(1, 50)
        if(id_resident, id_reservation) not in pairs:
            values.append(f"""(
    {id_resident},
    {id_reservation}
)""")

    return f"""
INSERT INTO residents_reservations (id_resident, id_reservation)
VALUES {','.join(values)};"""

def generate_conflits_inserts(num_conflicts=50):
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

def generate_residents_conflits_inserts(num_links=50):
    pairs = set() # Pour éviter répet des primary key
    values = []
    while len(pairs) < num_links:
        id_resident = random.randint(1, 20)
        id_conflit = random.randint(1, 50)
        if(id_resident, id_conflit) not in pairs:
            pairs.add((id_resident, id_conflit))
            values.append(f"""(
    {id_resident},
    {id_conflit}
)""")

    return f"""
INSERT INTO residents_conflits (id_resident, id_conflit)
VALUES {','.join(values)};"""

# Générer le fichier SQL final
with open('../sql/insert/data.sql', 'w', encoding='utf-8') as f:
    f.write("-- Insertion des données de test en batch\n\n")
    f.write(generate_site_inserts())
    f.write("\n\n")
    f.write(generate_resident_inserts())
    f.write("\n\n")
    f.write(generate_logements_inserts())
    f.write("\n\n")
    f.write(generate_reservations_inserts())
    f.write("\n\n")
    # f.write(generate_residents_reservations_inserts())
    f.write(generate_conflits_inserts())
    f.write("\n\n")
    f.write(generate_residents_conflits_inserts())
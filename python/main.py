from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker(['fr_FR'], seed=0)

NUM_SITES=3
NUM_LOGEMENTS=8
NUM_RESIDENTS=25
NUM_RESERVATION=10
NUM_EVENEMENT=10

#enums:
NB_TYPE_LOGEMENTS=8
NB_CATEGORIE=6
NB_TYPE_MAINTENANCE=7

#links:
NUM_LINKS_RESIDENTS_RESERVATIONS=30

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
    for _ in range(num_links):
        values.append(f"""(
    {random.randint(1, NUM_RESIDENTS)},
    {random.randint(1, NUM_RESERVATION)}
)""")

    return f"""
INSERT INTO residents_reservations (id_resident, id_reservation)
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
    # f.write(generate_residents_reservations_inserts(NUM_LINKS_RESIDENTS_RESERVATIONS))
    # f.write("\n\n")
    f.write(generate_evenement_inserts(NUM_EVENEMENT))
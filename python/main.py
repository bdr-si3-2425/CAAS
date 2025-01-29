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
    for _ in range(num_links):
        values.append(f"""(
    {random.randint(1, 20)},
    {random.randint(1, 50)}
)""")

    return f"""
INSERT INTO residents_reservations (id_resident, id_reservation)
VALUES {','.join(values)};"""

def generate_conflits_inserts(num_conflicts=50):
    values = []
    for _ in range(num_conflicts):
        fake = Faker()
        conflicts = ["Bagarre", "Tapage nocture", "Vol"]
        descriptions = ["Bagarre pour avoir le dernier transat de la piscine", "Les résidents écoutaient de la musique jusqu\'à 3 heures du matin", "Le résident a volé une serviette sur un transat de la piscine"]
        
        title = fake.word(ext_word_list=conflicts)
        description = " ".join(fake.sentences(nb=1, ext_word_list=descriptions))
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
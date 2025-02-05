# CAAS

## Instruction d'exécution
En premier, il faut exécuter le createAllTable_combined.sql qui va créer toutes les tables puis, il faut modifier le nom de votre DB dans createUserAndSchema.sql puis exécuter, ce qui va créer les utilisateurs pour la table.


## Instruction d'exécution depuis les fichiers source (non obligatoire)

Il faut exécuter le fichier main.py dans le dossier de Python, ce qui crée les données de test.

	python main.py

Puis il faut utiliser le linker pour combiner le fichier avec cette commande. link.py createAllTable.sql


	python link.py createAllTable.sql

Après cela, il suffit de faire la procédure d'exécution standard.
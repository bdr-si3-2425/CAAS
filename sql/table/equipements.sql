CREATE TABLE equipements (
    id_equipement SERIAL PRIMARY KEY,
    nom_equipement VARCHAR(100) NOT NULL,
    CHECK (char_length(nom_equipement) > 1)
);

CREATE TABLE logements_equipements (
    id_logement INT NOT NULL,
    id_equipement INT NOT NULL,
    PRIMARY KEY (id_logement, id_equipement),
    FOREIGN KEY (id_logement) REFERENCES logements(id_logement),
    FOREIGN KEY (id_equipement) REFERENCES equipements(id_equipement)
);
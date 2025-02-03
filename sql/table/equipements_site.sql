CREATE TABLE equipements_site (
    id_equipement SERIAL PRIMARY KEY,
    nom_equipement VARCHAR(100) NOT NULL,
    CHECK (char_length(nom_equipement) > 1)
);

CREATE TABLE site_equipements (
    id_site INT NOT NULL,
    id_equipement INT NOT NULL,
    PRIMARY KEY (id_site, id_equipement),
    FOREIGN KEY (id_site) REFERENCES site(id_site),
    FOREIGN KEY (id_equipement) REFERENCES equipements_site(id_equipement)
);
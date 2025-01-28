

CREATE TABLE logements (
    id_logement SERIAL PRIMARY KEY,
    id_type_logement INT NOT NULL,
    nb_chambre INT NOT NULL,
    nb_lits_simples INT NOT NULL,
    nb_lits_doubles INT NOT NULL,
    surface DECIMAL(6,2) NOT NULL,
    CHECK (surface > 0),
    CHECK (nb_chambre > 0),
    CHECK (nb_lits_simples >= 0),
    CHECK (nb_lits_doubles >= 0),
    FOREIGN KEY (id_type_logement) REFERENCES type_logements(id_type_logement)
);
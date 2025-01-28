DROP TABLE IF EXISTS logements;

CREATE TABLE logements (
    id_logement SERIAL PRIMARY KEY,
    nb_chambre INT NOT NULL,
    nb_lits_simples INT NOT NULL,
    nb_lits_doubles INT NOT NULL,
    surface DECIMAL(10,2) NOT NULL,
    CHECK (surface > 0),
    CHECK (nb_chambre > 0),
    CHECK (nb_lits_simples >= 0),
    CHECK (nb_lits_doubles >= 0)
);
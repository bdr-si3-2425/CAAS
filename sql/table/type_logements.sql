
CREATE TABLE type_logements (
    id_type_logement SERIAL PRIMARY KEY,
    type_logement VARCHAR(100) NOT NULL,
    indice_forfaitaire DECIMAL(5,2) NOT NULL,
    CHECK (indice_forfaitaire > 0),
    CHECK (char_length(type_logement) > 1)
);
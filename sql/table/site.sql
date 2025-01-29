CREATE TABLE site (
    id_site SERIAL PRIMARY KEY,
    adresse VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    pays VARCHAR(100) NOT NULL,
    code_postal INT NOT NULL,
    nom_site VARCHAR(100) NOT NULL,
    indice_forfaitaire FLOAT NOT NULL,
    CHECK (code_postal > 0),
    CHECK (indice_forfaitaire > 0),
    CHECK (char_length(adresse) > 1),
    CHECK (char_length(ville) > 1),
    CHECK (char_length(pays) > 1),
    CHECK (char_length(nom_site) > 1)
);
DROP TABLE IF EXISTS conflits;
DROP TABLE IF EXISTS residents_conflits;
CREATE TABLE conflits (
    id_conflit SERIAL PRIMARY KEY,
    etat BOOLEAN DEFAULT FALSE,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    date_signalement DATE DEFAULT CURRENT_DATE
);


CREATE TABLE residents_conflits (
    id_resident INT NOT NULL,
    id_conflit INT NOT NULL,
    PRIMARY KEY (id_resident, id_conflit),
    FOREIGN KEY (id_resident) REFERENCES residents(id_resident),
    FOREIGN KEY (id_conflit) REFERENCES conflits(id_conflit)
);
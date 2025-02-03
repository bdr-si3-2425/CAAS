CREATE TABLE maintenance (
    id_maintenance SERIAL PRIMARY KEY,
    date DATE DEFAULT CURRENT_DATE NOT NULL,
    description VARCHAR(250) NOT NULL,
    rapport VARCHAR(250) NOT NULL,
    urgence BOOLEAN DEFAULT FALSE NOT NULL,
    id_logement INT NOT NULL,
    id_type_maintenance INT NOT NULL,
    CHECK (char_length(description) > 1),
    CHECK (char_length(rapport) > 1),
    FOREIGN KEY (id_logement) REFERENCES logements(id_logement),
    FOREIGN KEY (id_type_maintenance) REFERENCES type_maintenance(id_type_maintenance)
);
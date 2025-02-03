
CREATE TABLE reservations (
    id_reservation SERIAL PRIMARY KEY,
    id_logement INT NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    CHECK (date_fin > date_debut),
    FOREIGN KEY (id_logement) REFERENCES logements(id_logement)
);

CREATE TABLE residents_reservations (
    id_resident INT NOT NULL,
    id_reservation INT NOT NULL,
    PRIMARY KEY (id_resident, id_reservation),
    FOREIGN KEY (id_resident) REFERENCES residents(id_resident),
    FOREIGN KEY (id_reservation) REFERENCES reservations(id_reservation)
);

CREATE TABLE prolongations (
    id_prolongation SERIAL PRIMARY KEY,
    id_reservation INT NOT NULL, 
    FOREIGN KEY (id_reservation) REFERENCES reservations(id_reservation),
    date_fin_reservation DATE NOT NULL
);

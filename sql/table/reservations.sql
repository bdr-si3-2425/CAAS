
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


CREATE OR REPLACE FUNCTION check_reservation_dates()
    RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM reservations_dates_view v
        WHERE v."Numéro du logement" = NEW.id_logement
          AND v."Date de début" < NEW.date_fin
          AND v."Date de fin" > NEW.date_debut
          AND v."Numéro de réservation" <> NEW.id_reservation
    ) THEN
        RAISE EXCEPTION 'Le logement est déjà reservé à ces dates.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*
CREATE TRIGGER VerifyResDate
    BEFORE INSERT OR UPDATE ON reservations
    FOR EACH ROW
EXECUTE FUNCTION check_reservation_dates();

*/
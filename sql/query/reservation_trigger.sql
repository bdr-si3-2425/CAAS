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
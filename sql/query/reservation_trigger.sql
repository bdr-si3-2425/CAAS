CREATE OR REPLACE FUNCTION check_reservation_dates()
    RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.id_logement NOT IN (
        SELECT "Numero du logement"
        FROM get_logements_disponibles(NEW.date_debut, NEW.date_fin, NULL, NULL, NULL, NULL)
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
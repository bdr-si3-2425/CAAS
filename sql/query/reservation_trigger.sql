CREATE OR REPLACE FUNCTION check_reservation_dates()
    RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM get_logements_disponibles(NEW.date_debut, NEW.date_fin, NULL, NULL, NULL, NULL) l
        WHERE l."Numero du logement" = NEW.id_logement
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Le logement est déjà réservé à ces dates.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER VerifyResDate
    BEFORE INSERT OR UPDATE ON reservations
    FOR EACH ROW
EXECUTE FUNCTION check_reservation_dates();

CREATE OR REPLACE FUNCTION check_prolongations_dates()
    RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM get_logements_disponibles(NULL, NEW.date_fin_reservation, NULL, NULL, NULL, NULL) l
        WHERE l."Numero de reservation" = NEW.id_reservation
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Le logement n''est pas libre à ces dates, la prolongation n''est pas possible.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER VerifyProlongationsDate
    BEFORE INSERT OR UPDATE ON prolongations
    FOR EACH ROW
EXECUTE FUNCTION check_prolongations_dates();

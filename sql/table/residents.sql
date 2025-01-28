
CREATE TABLE residents
(
    id_resident SERIAL PRIMARY KEY,
    nom         VARCHAR(100) NOT NULL,
    prenom      VARCHAR(100) NOT NULL,
    num_tel     VARCHAR(15)  NOT NULL UNIQUE,
    CHECK (char_length(nom) > 1),             -- Vérifie que le nom a au moins 2 caractères
    CHECK (char_length(prenom) > 1)           -- Vérifie que le prénom a au moins 2 caractères
);


CREATE OR REPLACE FUNCTION format_num_tel(num_tel_input TEXT)
    RETURNS TEXT AS
$$
DECLARE
    formatted_num TEXT;
BEGIN

    formatted_num := regexp_replace(num_tel_input, '[^0-9]', '', 'g');

    IF formatted_num ~ '^0' THEN
        formatted_num := '33' || substring(formatted_num FROM 2);
    END IF;

    IF NOT formatted_num ~ '^\+' THEN
        formatted_num := '+' || formatted_num;
    END IF;

    RETURN formatted_num;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION trigger_format_num_tel()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.num_tel := format_num_tel(NEW.num_tel);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER format_num_tel_trigger
    BEFORE INSERT OR UPDATE
    ON residents
    FOR EACH ROW
EXECUTE FUNCTION trigger_format_num_tel();




-- unit tests

CREATE OR REPLACE PROCEDURE test.test_format_num_tel() LANGUAGE plpgsql AS $$
BEGIN
    -- arrange
    CREATE TEMP TABLE test_residents (num_tel TEXT);
    INSERT INTO test_residents (num_tel) VALUES
                                             ('0123456789'),
                                             ('+33123456789'),
                                             ('33123456789'),
                                             ('123-456-789');

    -- act
    CREATE TEMP TABLE result ON COMMIT DROP AS
    SELECT num_tel, format_num_tel(num_tel) AS formatted_num FROM test_residents;

    -- assert
    assert((SELECT formatted_num FROM result WHERE num_tel = '0123456789') = '+33123456789'),
        'Expected +33123456788, got ' || (SELECT formatted_num FROM result WHERE num_tel = '0123456789')::text;

    assert((SELECT formatted_num FROM result WHERE num_tel = '+33123456789') = '+33123456789'),
        'Expected +33123456789, got ' || (SELECT formatted_num FROM result WHERE num_tel = '+33123456789')::text;

    assert((SELECT formatted_num FROM result WHERE num_tel = '33123456789') = '+33123456789'),
        'Expected +33123456789, got ' || (SELECT formatted_num FROM result WHERE num_tel = '33123456789')::text;

    assert((SELECT formatted_num FROM result WHERE num_tel = '123-456-789') = '+123456789'),
        'Expected +123456789, got ' || (SELECT formatted_num FROM result WHERE num_tel = '123-456-789')::text;

    ROLLBACK;
END;
$$;

CALL test.test_format_num_tel();
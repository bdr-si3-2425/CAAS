DROP TABLE IF EXISTS residents_conflits;
DROP TABLE IF EXISTS conflits;
DROP TABLE IF EXISTS residents CASCADE;
DROP FUNCTION IF EXISTS public.format_num_tel(text);
DROP FUNCTION IF EXISTS public.trigger_format_num_tel();
DROP TABLE IF EXISTS logements CASCADE;
DROP TABLE IF EXISTS type_logements;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS residents_reservations;
DROP TABLE IF EXISTS logements_equipements;
DROP TABLE IF EXISTS equipements_logement;
DROP TABLE IF EXISTS site_equipements;
DROP TABLE IF EXISTS equipements_site;
DROP TABLE IF EXISTS maintenance;
DROP TABLE IF EXISTS type_maintenance;
DROP TABLE IF EXISTS residents_evenement;
DROP TABLE IF EXISTS evenement;
DROP TABLE IF EXISTS site;
DROP TABLE IF EXISTS categorie;
DROP TABLE IF EXISTS prolongations;
DROP TRIGGER IF EXISTS VerifyResDate ON reservations;
DROP VIEW IF EXISTS reservations_dates_view;
DROP TRIGGER IF EXISTS VerifyProlongationsDate ON prolongations;


DROP FUNCTION IF EXISTS get_logements_disponibles(date,date,character varying,character varying,numeric,integer);
DROP FUNCTION IF EXISTS get_residents_count_by_age(site_id INT, max_age INT);
DROP FUNCTION IF EXISTS check_reservation_dates();
DROP FUNCTION IF EXISTS check_prolongations_dates();

-- Suppression des utilisateurs s'ils existent déjà
CREATE USER mainteneur WITH PASSWORD 'wFRpWJY5gF7tkF';
GRANT ALL PRIVILEGES ON DATABASE "co-living" TO mainteneur;


CREATE USER salarie WITH PASSWORD 'wFRpWJY5gF7tkF';
GRANT CONNECT ON DATABASE "co-living" TO salarie;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO salarie;

-- TODO: need db to test this
-- CREATE USER technicien WITH PASSWORD 'password';
-- GRANT UPDATE ON TABLE public.incident TO technicien;
--
--
-- CREATE USER client WITH PASSWORD 'password';
-- GRANT CONNECT ON DATABASE database_name TO client;
-- GRANT SELECT ON TABLE public.activite TO client;
-- add more permissions here


CREATE DATABASE Alexis_db;
CREATE DATABASE Anais_db;
CREATE DATABASE Corentin_db;
CREATE DATABASE Sabra_db;

CREATE USER Alexis WITH PASSWORD 'wFRpWJY5gF7tkF';
CREATE USER Anais WITH PASSWORD 'wFRpWJY5gF7tkF';
CREATE USER Corentin WITH PASSWORD 'wFRpWJY5gF7tkF';
CREATE USER Sabra WITH PASSWORD 'wFRpWJY5gF7tkF';

GRANT ALL PRIVILEGES ON DATABASE Alexis_db TO Alexis;
GRANT ALL PRIVILEGES ON DATABASE Anais_db TO Anais;
GRANT ALL PRIVILEGES ON DATABASE Corentin_db TO Corentin;
GRANT ALL PRIVILEGES ON DATABASE Sabra_db TO Sabra;


CREATE SCHEMA test;
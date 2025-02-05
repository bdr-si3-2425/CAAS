CREATE USER mainteneur WITH PASSWORD 'wFRpWJY5gF7tkF';
GRANT ALL PRIVILEGES ON DATABASE "co-living" TO mainteneur;


CREATE USER salarie WITH PASSWORD 'wFRpWJY5gF7tkF';
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO salarie;


CREATE USER technicien WITH PASSWORD 'password';
GRANT UPDATE ON TABLE public.maintenance TO technicien;


CREATE USER client WITH PASSWORD 'password';
GRANT SELECT ON TABLE public.evenement TO client;




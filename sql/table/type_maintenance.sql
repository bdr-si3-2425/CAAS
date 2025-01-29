CREATE TABLE type_maintenance (
    id_type_maintenance SERIAL PRIMARY KEY,
    type_maintenance VARCHAR(100) NOT NULL,
    CHECK (char_length(type_maintenance) > 1)
);
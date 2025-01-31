CREATE TABLE categorie (
  id_categorie SERIAL PRIMARY KEY,
  categorie VARCHAR(100) NOT NULL,
  CHECK (char_length(categorie) > 1)
);
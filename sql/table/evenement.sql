
CREATE TABLE evenement (
   id_evenement SERIAL PRIMARY KEY,
   id_categorie INT NOT NULL,
   titre VARCHAR(255) NOT NULL,
   id_site INT NOT NULL,
   date_evenement DATE DEFAULT CURRENT_DATE NOT NULL,
   description TEXT,
   FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie),
   CHECK (char_length(titre) > 1),
   CHECK (description IS NULL OR char_length(description) >= 10),
   FOREIGN KEY (id_site) REFERENCES site(id_site)
);


CREATE TABLE residents_evenement (
    id_resident INT NOT NULL,
    id_evenement INT NOT NULL,
    PRIMARY KEY (id_resident, id_evenement),
    FOREIGN KEY (id_resident) REFERENCES residents(id_resident),
    FOREIGN KEY (id_evenement) REFERENCES evenement(id_evenement)
);
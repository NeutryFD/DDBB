CREATE TABLE provincia (
    cod_prov numeric(10) PRIMARY KEY,
    nom varchar(20) not null,
    CP varchar(5),

    CONSTRAINT CH_provincia_nom_min CHECK (nom = lower(nom)),
    CONSTRAINT CH_provincia_cp_limit CHECK (CP 
);
CREATE TABLE facultad (
    codi numeric(5) PRIMARY KEY,
    nom varchar(50),
    centre numeric(5),
    ubicacion varchar(10)

    constraint mayus1 check (nom = initcap(nom)),--los check retornan boleanos
    constraint allmayus check ( ubicacion = upper(ubicacion)));

CREATE TABLE investigador (
    DNI varchar(9) PRIMARY KEY,
    nom varchar(50) not null ,
    cognom varchar(50),
    codi numeric(5)

    constraint mayus2 check ( nom = initcap(nom) and cognom = initcap(cognom)),
    constraint FK_codi FOREIGN KEY (codi) REFERENCES
                          );
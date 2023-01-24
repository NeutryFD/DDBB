--Creación de tablas
CREATE TABLE facultad (
    codi numeric(5) PRIMARY KEY,
    nom varchar(50),
    centre numeric(5),
    ubicacion varchar(10),

    constraint mayus1 check (nom = initcap(nom)),--los check retornan boleanos
    constraint allmayus check ( ubicacion = upper(ubicacion)));

CREATE TABLE investigador (
    DNI varchar(9) PRIMARY KEY,
    nom varchar(50) not null ,
    cognom varchar(50),
    codi numeric(5),

    constraint mayus2 check ( nom = initcap(nom) and cognom = initcap(cognom)),
    constraint FK_codi_investigador FOREIGN KEY (codi) REFERENCES facultad);

CREATE TABLE equipos (
    NumSerie varchar(10) PRIMARY KEY ,
    nom varchar(50),
    codi numeric(5),

    constraint FK_codi_equipos FOREIGN KEY (codi) REFERENCES facultad);

CREATE TABLE reserva (
    DNI varchar(9),
    NumSerie varchar(10),
    Data_inici date,
    Data_fi date,

    constraint FK_dni_reserva FOREIGN KEY (DNI) REFERENCES investigador,
    constraint FK_numserie FOREIGN KEY (NumSerie) REFERENCES equipos,
    constraint ch_data_inici CHECK ( Data_inici = current_date ),
    constraint ch_data_fi check ( Data_fi = current_date));

/***--------------------------------------------------------------------------------------------------------------------***/
INSERT INTO facultad (Codi, nom, Centre, Ubicacion) VALUES
(1, 'UAB', '12203', 'BCN'),
(2, 'UB', '18890', 'BCN'),
(3, 'UPC', '19901', 'BCN'),
(4, 'ULPGC', '18890', 'CAN'),
(5, 'UCM', '12203', 'MAD'),
(6, 'UDC', '19901', 'ACO');

ALTER TABLE facultad
DROP CONSTRAINT mayus1;

ALTER TABLE facultad
ADD CONSTRAINT mayus1 CHECK ( facultad.nom = upper(facultad.nom) );

select * from facultad;

INSERT INTO investigador (DNI, nom, cognom, codi) VALUES
('33112233W', 'Arnau', 'Plaza', 1),
('78142789Q', 'Lois', 'Leal', 6),
('77891990L', 'Erin', 'Vera', 2);

select * from investigador;

INSERT INTO equipos (NumSerie, nom, codi) VALUES
('68779737WQ', 'Oscil·loscopi', 1),
('35099799RR', 'Generadors de funcions', 5),
('93276015PT', 'Font d’alimentació', 6),
('62755469SW', 'Sniffer digital', 2);

select  * from equipos;

INSERT INTO Reserva (DNI, NumSerie, Data_Inici, Data_Fi) VALUES
('33112233W', '68779737WQ', current_date,current_date),
('78142789Q', '93276015PT', current_date, current_date),
('77891990L', '62755469SW', current_date, current_date);


CREATE  VIEW consulta_investigadores AS
    SELECT * FROM investigador
    ORDER BY cognom ASC
    WITH CHECK OPTION ;

DROP VIEW consulta_investigadores;

SELECT * FROM consulta_investigadores;

ALTER TABLE investigador
ADD CONSTRAINT ch_nom CHECK ( nom is not null ),
ADD CONSTRAINT ch_centro CHECK ( codi > 0 and codi is not null);


ALTER TABLE investigador
DROP CONSTRAINT ch_nom,
DROP CONSTRAINT ch_centro;

delete from investigador
where dni = '4545';

select conname, conrelid::regclass
FROM pg_constraint
WHERE conrelid ='facultad'::regclass;

BEGIN;
ALTER TABLE investigador
ALTER COLUMN cognom TYPE varchar(100);
ROLLBACK;
END;

BEGIN;
CREATE TABLE investigador2(
    research_id,
    first_name,
    last_name
    )AS SELECT DNI,nom,cognom FROM investigador;
END;
SELECT * FROM investigador;

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

COMMENT ON COLUMN facultad.ubicacion IS 'BCN – Barcelona
                                         CAN – Canàries
                                         MAD – Madrid
                                         ACO – A Corunya';

COMMENT ON COLUMN equipos.nom IS 'Descripcion del laboratorio';

SELECT * FROM facultad;

CREATE SEQUENCE codi_facultad
START WITH 7;

DROP SEQUENCE codi_facultad;

DELETE FROM facultad
    WHERE codi = '7';

INSERT INTO  facultad (codi, nom, centre, ubicacion) VALUES (nextval('codi_facultad'),'FIB','12205','BCN'),
                                                            (nextval('codi_facultad'),'UPNA','18898','NAV'),
                                                            (nextval('codi_facultad'),'UDO','19910','AST');
SELECT nextval('{Nombre de la secuencia}')

INSERT INTO equipos (NumSerie, nom, codi) VALUES ('68779737WQ','Oscil·loscopi',nextval('codi_facultad'));
INSERT INTO equipos (NumSerie, nom, codi) VALUES ('35099799RR','Genetador de Funciones',nextval('codi_facultad'));

CREATE INDEX index_con_investigador on investigador(cognom);
CREATE INDEX index_nom_equipos on equipos(nom);


ALTER TABLE investigador
ADD COLUMN telefno varchar(9);

ALTER TABLE equipos
ADD COLUMN preu_lloger numeric(7,2) default 0
    CONSTRAINT preu_no_negativo CHECK ( preu_lloger >= 0 and preu_lloger is not null);


UPDATE equipos
    SET preu_lloger = equipos.preu_lloger*1.18;

ALTER TABLE equipos
DROP COLUMN preu_lloger;


DELETE FROM facultad
WHERE codi = '1';

DELETE FROM investigador
WHERE DNI = '78142789Q';

DELETE FROM equipos
WHERE NumSerie = '932766015PT';

ALTER TABLE equipos
DROP CONSTRAINT FK_codi_equipos;

ALTER TABLE investigador
DROP CONSTRAINT FK_codi_investigador;

ALTER TABLE reserva
DROP CONSTRAINT FK_dni_reserva;
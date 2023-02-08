
/* Ejercicio #1 --> Crear nueva tabla llamada provincia*/
CREATE TABLE provincia (
    cod_prov numeric(10) PRIMARY KEY,
    nom varchar(20) not null,
    CP varchar(5),

    CONSTRAINT CH_provincia_nom_min CHECK (nom = lower(nom)),
    CONSTRAINT CH_provincia_cp_limit CHECK ((substr(CP::text,1,1)) in ('1','0','5')));

/* Ejercicio #2 --> Agragar cuna nueva columna*/

ALTER TABLE zona
ADD COLUMN cod_prov numeric(10),
ADD CONSTRAINT FK_cod_prov FOREIGN KEY (cod_prov) REFERENCES provincia;

/* Ejercicio #3 --> Inserts en la tabla provincia*/
INSERT INTO provincia VALUES (1,'barcelona','08017'),
                             (2,'tarragona','05331'),
                             (3,'lleida','12232'),
                             (4,'girona','55555'),
                             (5,'sevilla','01012');
/* Cuando damos enter nos salta un error en el segundo insert, por que no cumple con la constrain que habiamos establecidos
   antes, cambiamos el valor del codigo postal de tarragona de 25331 --> 05331

   También nos da un error al con el insert de girona, por que los nombres deben de ser en minusculas*/

/* Ejercicio #5 Actualizar el campo cod_prov */

UPDATE zona
SET cod_prov = provincia.cod_prov
FROM provincia
WHERE
  (zona.nom = 'EL remolar' AND provincia.nom = 'barcelona') OR
  (zona.nom IN ('La Marina de baix', 'La Marina de dalt') AND provincia.nom = 'tarragona') OR
  (zona.nom = 'La Ricarda' AND provincia.nom = 'girona') OR
  (zona.nom IN ('La Rivera nord', 'La Rivera sud') AND provincia.nom = 'lleida');

SELECT * FROM zona ORDER BY cod_prov;

/* Ejercicio #6 Crear un secuencia*/

CREATE SEQUENCE seq_explotacio
START 30
INCREMENT 10
MINVALUE 10
MAXVALUE 1000;


/* Ejericio #7 Inserts de valores en la tabla explotacio*/

INSERT INTO explotacio VALUES
  (nextval('seq_explotacio'), 'Cal Arana', current_date, 10.33, 'La Marina de baix'),
  (nextval('seq_explotacio'), 'Cal Tet', current_date, 71.20, 'La Marina de baix'),
  (nextval('seq_explotacio'), 'Cal Filipines', current_date, 16.35, 'El remolar'),
  (nextval('seq_explotacio'), 'Cal Figureta', current_date, 19.30, 'El remolar'),
  (nextval('seq_explotacio'), 'Cal Misses', current_date, 210.32, 'El remolar');

SELECT * FROM explotacio;

/* Ejercicio #8 Vista solo lectura de la tabla empresa */

CREATE VIEW view_copy_empresa AS
SELECT  e.nif as codi_empresa,e.nom as nom_empresa,tr.dni as dni_treballado, tr.nom as nom_treballador,
        tr.cognom as cognom_treballador, pr.titol as nom_projecte, pr.pressupost as pressupost
FROM empresa e
JOIN treballa t on e.nif = t.nif
JOIN treballador  tr on tr.dni = t.dni
JOIN treballen tn on tn.dni_eng = t.dni
JOIN projecte pr on tn.codi_pj = pr.codi_pj
WHERE tr.dni = tn.dni_eng AND pr.pressupost > 1200;
--  Nos sale vacias por que no hay ningún ingeniero que trabaje en una empresa que tenga un proyecto asignado
GRANT SELECT ON TABLE view_copy_empresa TO public; -- esto fue lo que encontre para hacer que la vista solo sea de lectura


SELECT * FROM view_copy_empresa;
DROP VIEW view_copy_empresa;



/* Ejercicio #9 Creacion de Index */

CREATE UNIQUE INDEX nom_index
ON zona (nom);

CREATE INDEX nom_ea_index
ON  explotacio(nom_ea);


DROP INDEX nom_index;
/* Ejercicio #10 Borrar de la tabla provincia la provincia de Barcelona */

DELETE FROM provincia
WHERE nom = 'barcelona';

ALTER TABLE zona
DROP CONSTRAINT FK_cod_prov; --Borramos la constrain que no impide realizar la acción

SELECT * FROM provincia;
SELECT * FROM zona;
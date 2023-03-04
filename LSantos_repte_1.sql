/** Ejercicios 1**/
/*Crea una funció esmentada explotacio_superficie que donada el nom d’una ¿¿¿explotació???(ZONA) ens mostri quina és l’explotació que
té una superfície superior a la mitjana de la superfície de les explotacions.
Aquesta funció és cridarà des de un procediment emmagatzemat, esmentat printar_expl_superficie, que haurà de mostrar
un missatge indicant “L’explotacio amb la superficie superior a la mitjana de la superfície de la resta d’explotacions,
és nom_explotacio i la superficie és superficie”*/

CREATE OR REPLACE FUNCTION explotacio_superficie(nom_zona varchar) RETURNS VARCHAR AS $$
    DECLARE
        V_nombre explotacio.nom_ea%type;
        BEGIN
            SELECT  explotacio.nom_ea
            INTO V_nombre
            FROM explotacio JOIN zona z on z.nom = explotacio.nom_zona
            WHERE z.nom ilike $1 and explotacio.superficie > (SELECT avg(superficie)FROM explotacio);
            RETURN V_nombre;
        END;$$LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE printar_expl_superficie(zona varchar) LANGUAGE plpgsql AS $$
    DECLARE
        nom varchar :=(SELECT explotacio_superficie($1));
        superfice numeric;
        BEGIN
            SELECT explotacio.superficie
            INTO superfice
            FROM explotacio
            WHERE explotacio.nom_ea ilike nom;
            RAISE NOTICE 'La explotacion de la zona: % con la superfice superior a la media del resto de '
                        'superfice de es: % con una superfice de %km² :',$1,nom,superfice;
        END$$;
CALL printar_expl_superficie('La Rivera sud');


/** Ejercicio  2**/
/*Crea un procediment emmagatzemat esmentat  Treballador_llaurador que mostrarà el dni, nom i cognoms dels
llauradors destinats a sectors d’explotacions d’una zona introduïda per pantalla.
Aquest procediment haurà de mostrar un missatge indicant “El treballador amb DNI, nom i cognom està destinat
a l’explotació agrària nom_explotacio situada a la zona nom_zona” Aquest procediment el cridarem des de una consola.
*/

CREATE OR REPLACE PROCEDURE  Treballador_llaurador(zona varchar) LANGUAGE plpgsql AS $$
    DECLARE
        v_treballador treballador%rowtype;
        v_explotacio explotacio%rowtype;
    BEGIN
        SELECT treballador.dni,treballador.nom,treballador.cognom, ex.nom_zona, ex.nom_ea
        INTO v_treballador.dni,v_treballador.nom,v_treballador.cognom, v_explotacio.nom_zona,v_explotacio.nom_ea
        FROM treballador join treballa t on treballador.dni = t.dni
                         join empresa e on e.nif = t.nif
                         join concessio c on e.nif = c.nif
                         join explotacio ex on ex.codi_ea = c.codi_ea
        WHERE ex.nom_zona ilike $1;
        RAISE NOTICE 'Nombre: % | Apellido: % | DNI: %',v_treballador.nom, v_treballador.cognom, v_treballador.dni;
        RAISE NOTICE 'Nombre Explocion Agragria: % | Zona: %' ,v_explotacio.nom_ea, v_explotacio.nom_zona;
END $$;

CALL Treballador_llaurador('La Marina de dalt');

/** Ejercicio 3**/
/*Crea una funció esmentada calcul_superficie que donat el nom d’un cultiu ens retorni la suma de la superficie dedicada a aquest cultiu.
Aquesta funció és cridarà des de un procediment emmagatzemat, esmentat printar_calcul_superficie que haurà de mostrar un missatge
indicant “El cultiu nom_cultiu té un total de quantitat_superficie sembrat.”
Aquest procediment el cridarem des de una consola.*/

DROP FUNCTION  calcul_superficie(cultivo varchar);

CREATE OR REPLACE FUNCTION calcul_superficie(cultivo varchar) RETURNS NUMERIC AS $$
    DECLARE
        v_supercie_cultivo sector.superficie%type;
        v_cultivo cultiu.nom%type;
    BEGIN
        SELECT sum(sector.superficie),c.nom
        INTO v_supercie_cultivo,v_cultivo
        FROM sector join cultiu c on c.codi_cultiu = sector.codi_cultiu
        WHERE c.nom ilike $1
        GROUP BY sector.codi_cultiu,c.nom;
        RETURN v_supercie_cultivo;
    END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE printar_calcul_superficie(cultivo varchar) LANGUAGE plpgsql AS $$
    DECLARE
        total NUMERIC:=(SELECT calcul_superficie($1));
    BEGIN
        RAISE NOTICE 'El cultivo % tiene una cantidad %km² sembrada',$1,total;
    END $$;

CALL  printar_calcul_superficie('FAVA');

/** Ejercicio 4**/
/*Crea una funció esmentada quantitat_treballadors   que donat el CIF d’una empresa i un període de temps, ens indiqui la quantitat
de treballadors que té, o ha tingut.
Aquesta funció és cridarà des de un procediment emmagatzemat, esmentat printar_q_treballador que haurà de mostrar un missatge indicant
“L’empresa amb CIF cif_emp i amb nom nom_emp, té contractats quantitat_treballadors en el període comprés  temps data_1 i data_2”
Aquest procediment el cridarem des de una consola.*/

CREATE TYPE data_empresa_trabajores AS(
    nom varchar(60),
    n_trabajaores INTEGER);

CREATE OR REPLACE FUNCTION quantitat_treballadors(nif varchar,date_inicio date,date_fin date) RETURNS data_empresa_trabajores AS $$
    DECLARE
        data data_empresa_trabajores;
    BEGIN
        SELECT e.nom,count(treballa.dni)
        INTO data
        FROM treballa join empresa e on e.nif = treballa.nif
        WHERE $2 < treballa.data and $3 > treballa.data_fi and e.nif ilike $1
        GROUP BY e.nom;
        RETURN data;
    END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE printar_q_treballador(nif varchar,date_inicio date,date_fin date) LANGUAGE plpgsql AS $$
    DECLARE
        cantidad data_empresa_trabajores:=(SELECT quantitat_treballadors($1,$2,$3));
    BEGIN
        RAISE NOTICE 'La empresa con NIF:% con nombre:% tiene contratado a % en el perido de -> % y -> %',
            $1, cantidad.nom, cantidad.n_trabajaores,$2,$3;
    end $$;

CALL printar_q_treballador('N5655500O','2002-12-5','2025-4-5');

/** Ejercicio 5**/
/*Crea un funció esmentada superficie_con que li passaràs el nom, CIF de l’empresa i un any, i mostrarà la quantitat de superfície que
tenen concedides aquesta empresa, gràcies a les concessions que tenen atorgades.
Per fer aquest exercici et proposo realitzar una funció (per calcular l'any) i  un procediment anomenat printar_super_con  que mostrarà
el següent missatge “L’empresa amb CIF CIF i nom Nom, durant l’any any_introduit ha tingut concedida q_superficie hectàrees”
Aquest procediment el cridarem des de una consola.*/
CREATE TYPE concesio_anio_superfice AS (
    anio_concesio DATE,
    anio_concesio_fin DATE,
    superfice_cincesio  numeric);
DROP TYPE concesio_anio_superfice;
DROP  FUNCTION superficie_con(nom varchar, cif varchar, anio varchar);
CREATE OR REPLACE FUNCTION superficie_con(nom varchar, cif varchar,anio date) RETURNS concesio_anio_superfice AS $$
    DECLARE
        data concesio_anio_superfice;
    BEGIN
        SELECT ex.data_inici, concessio.data_fi, ex.superficie
        INTO data
        FROM concessio join empresa e on e.nif = concessio.nif
                       join explotacio ex on ex.codi_ea = concessio.codi_ea
        WHERE e.nom ilike $1 and e.nif ilike $2 and ex.data_inici = $3;
        RETURN data;
    END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE printar_super_con(nom varchar, cif varchar,anio date) AS $$
    DECLARE
        info concesio_anio_superfice:=(SELECT superficie_con($1,$2,$3));
    BEGIN
        RAISE NOTICE 'La empresa con el CIF:% y con nombre:% Durante el año % a tenido consedidas % hectarias',
            $2,$1,$3,info.superfice_cincesio;

    END; $$ LANGUAGE plpgsql;

CALL printar_super_con('Delta Central, S.A.','H5685454B','2019-10-20');
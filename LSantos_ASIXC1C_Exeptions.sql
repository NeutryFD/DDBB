/* Ejercicio #1*/
/*Programar un bloc principal i un procediment per a consultar les dades de l’empleat. El codi de l’empleat s’introduirà per teclat.

El bloc anònim preguntarà a l’usuari i cridarà al procediment passant al paràmetre 	corresponent. El procediment
consultarà la taula empleat i recuperarà les següents dades: nom, salari, comissió, ofici i cap.
En cas de que la comissió sigui nul·la, ha d’aparèixer 0 i no en blanc. El procediment s’anomenarà imprimir_dades.
A més, s’ha de controlar si existeix o no l’empleat a la base de dades.*/

CREATE TYPE empleat AS(
                          nom varchar(50),
                          salario numeric(8,2),
                          comision numeric (2,2),
                          oficina varchar(10),
                          Jefe numeric(11)
                      );


CREATE OR REPLACE PROCEDURE  imprimir_dades(codigo numeric) AS $$
DECLARE
    empleado empleat;
BEGIN
    SELECT employees.first_name,employees.salary,employees.commission_pct,employees.job_id, employees.manager_id
    INTO STRICT empleado.nom,empleado.salario,empleado.comision,empleado.oficina,empleado.jefe
    FROM employees
    WHERE employees.employee_id = $1;
    RAISE NOTICE ' % % %',empleado.nom,empleado.salario,coalesce(empleado.comision,0);
EXCEPTION
    WHEN  no_data_found THEN
        RAISE EXCEPTION 'Empleado no encontreado % ',$1;

END ;$$ LANGUAGE plpgsql;

CALL imprimir_dades(100);


/* Ejercicio #2 */
/*Programar el mateix exercici que l’anterior  però ara el subprograma serà una funció anomenarà
retornar_dades. La funció no imprimirà cap dada, sinó que retornarà una variable de tipus registre.
S’ha de controlar els possibles errors (com abans) però ara a la funció.*/


CREATE OR REPLACE  FUNCTION retornar_dades(id numeric) RETURNS empleat AS $$
DECLARE
    empleado empleat;
BEGIN
    SELECT employees.first_name,employees.salary,employees.commission_pct,employees.job_id, employees.manager_id
    INTO STRICT empleado
    FROM employees
    WHERE employees.employee_id = $1;
    RETURN empleado;
EXCEPTION
    WHEN  no_data_found THEN
        RAISE EXCEPTION 'Empleado no encontreado % ',$1;
END; $$ LANGUAGE plpgsql ;

CREATE OR REPLACE PROCEDURE imprimir_retornar_dades(id numeric) LANGUAGE plpgsql AS $$
DECLARE
    dadas empleat:=(SELECT retornar_dades($1));
BEGIN
    RAISE NOTICE '% % %',dadas.nom,dadas.comision,dadas.salario;
END $$;

CALL imprimir_dades(:id);
SELECT retornar_dades(100);
/* Ejercicio #3*/
/*Realitzar un programa que ens indiqui si existeix o no el departament a la nostra base de dades. S’ha de tenir en
compte els següents aspectes:
el codi del departament ho introduirà l’usuari per teclat.
per comprovar si existeix o no el departament, s’ha de programar una funció anomenada COMPROVAR_DEPT. A aquesta funció
se li passarà per paràmetre des del bloc principal el codi del departament a comprovar.
el missatge que s’ha de mostrar és el següent: “EXISTEIX DEPARTAMENT” o “NO EXISTEIX DEPARTAMENT”.*/

CREATE OR REPLACE FUNCTION COMPROVAR_DEPT(dep numeric) RETURNS BOOLEAN AS $$
DECLARE
    dep BOOLEAN:=FALSE;
    cont INTEGER:= 0;
BEGIN
    SELECT count(*)
    INTO cont
    FROM departments
    WHERE department_id = $1;
    IF cont >= 1 THEN
        dep := TRUE;
    END IF;
    RETURN dep;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE departament_exist(dep numeric)LANGUAGE plpgsql AS $$
DECLARE
    exits BOOLEAN :=(SELECT COMPROVAR_DEPT($1));
BEGIN
    IF exits = TRUE THEN
        RAISE NOTICE 'El Departamento Existe';
    ELSE
        RAISE NOTICE 'EL Departamento No Existe';
    END IF;
END $$;
CALL departament_exist(:dep);

/* Ejercicio #4 */
/*Realitzar un programa que insereixi les dades d’un departament a la taula corresponent. Aquestes dades les ha d’introduir
l’usuari per teclat. Abans d’inserir el departament, s’ha de comprovar si existeix o no el departament a la base de dades
(per fer aquesta comprovació ens ajudarem de la funció que s’ha creat a l’exercici anterior, COMPROVAR_DEPT).*/

CREATE OR REPLACE PROCEDURE insert_departament(dep_id numeric,dep_name varchar,dep_id_manageer numeric, dep_location_od numeric) LANGUAGE plpgsql AS $$
    DECLARE
        exist BOOLEAN:=(SELECT COMPROVAR_DEPT($1));
        BEGIN
            IF exist = FALSE THEN
                INSERT INTO departments VALUES ($1,$2,$3,$4);
            ELSE
                RAISE NOTICE  'EL departamento % ya existe',$1;
            END IF;
        EXCEPTION
            WHEN FOREIGN_KEY_VIOLATION THEN
                RAISE EXCEPTION 'LOCATION ID no valido: %', $4;

        END $$;

CALL insert_departament(41,'GG',100,100);


CREATE OR REPLACE  PROCEDURE update_dep(dep_id numeric,new_depa_name varchar,new_id_namager numeric,new_local_id numeric) LANGUAGE plpgsql AS $$
    DECLARE
        exist BOOLEAN:=(SELECT COMPROVAR_DEPT($1));
        BEGIN
        IF exist = TRUE THEN
            UPDATE departments
                SET department_name = $2,
                    manager_id = $3,
                    location_id =$4
                    WHERE department_id = $1;
            ELSE
                RAISE NOTICE  'EL departamento % NO existe',$1;
            END IF;
        EXCEPTION
            WHEN FOREIGN_KEY_VIOLATION THEN
                RAISE EXCEPTION 'LOCATION ID no valido: %', $4;
        END$$;

CALL update_dep(100,'nuevo departament',100,177);

SELECT * FROM departments where department_id = 45;


/* Ejercicio #6 */
/*Realitzar un programa  que pregunti a l’usuari el codi de l’empleat per tal de retornar el nom de l’empleat.
El nom de l’empleat ho retornarà una funció que es crearà anomenada NOM. A aquesta funció se li passarà per paràmetre
el codi de l’empleat que l’usuari ha introduït per teclat. A més, s’ha de controlar els errors al bloc anònim.*/

CREATE OR REPLACE  FUNCTION NOM(id numeric) RETURNS varchar AS $$
    DECLARE
        nom employees.first_name%type;
        BEGIN
            SELECT first_name
            INTO STRICT nom
            FROM employees
            WHERE employee_id = $1;
            RETURN nom;
        EXCEPTION
            WHEN no_data_found THEN
                RAISE EXCEPTION 'ID no valido: %',$1;
        END;$$ LANGUAGE plpgsql;

SELECT NOM(105);

DO $$
    DECLARE
        nom  varchar:=(SELECT NOM(:id));
        BEGIN
            RAISE NOTICE 'EL nombre del empeado es: %',nom;
       -- EXCEPTION
        --WHEN no_data_found THEN            -->No puedo contralar la excepcion desde un bloque anonimo
          --  RAISE EXCEPTION 'ID no valido: %',$1;
        END;$$ LANGUAGE plpgsql;


/* Ejercicio #7 */

/*
Realitzar un programa  que ens comprovi si un departament existeix o no a la taula corresponent, consultant pel codi
del departament. En cas d’existir el departament s’ha d’imprimir per pantalla i s’ha de comprovar si comença o no per
la lletra A. Si comença per la lletra A, després d’imprimir el nom del departament, ha de dir, COMENÇA PER LA LLETRA A.
S’ha de programar les següents excepcions:
· Si no hi ha dades, s’ha de retornar: “ERROR: no dades”.
· Si retorna més d’una fila: “ERROR: retorna més files”
· Qualsevol altre error: “ERROR (sense definir)”.*/
CREATE OR REPLACE PROCEDURE comprovar_departament_proc(codi_dept numeric) AS $$
DECLARE
    exits boolean:=(SELECT COMPROVAR_DEPT(codi_dept) );
BEGIN
    IF exits = TRUE THEN
        RAISE NOTICE 'El Departamento Existe';
        DECLARE
            nom_dept text;
        BEGIN
            SELECT department_name
            INTO nom_dept
            FROM departments
            WHERE department_id = codi_dept;

            RAISE NOTICE 'El nombre del departamento es: %', nom_dept;
            IF UPPER(LEFT(nom_dept, 1)) = 'A' THEN
                RAISE NOTICE 'El nombre del departamento comienza por la letra A';
            END IF;
        EXCEPTION
            WHEN no_data_found THEN
                RAISE EXCEPTION 'ERROR: no dades';
            WHEN too_many_rows THEN
                RAISE EXCEPTION 'ERROR: retorna més files';
            WHEN OTHERS THEN
                RAISE EXCEPTION 'ERROR (sense definir)';
        END;
    ELSE
        RAISE NOTICE 'El Departamento No Existe';
    END IF;
END;$$ LANGUAGE plpgsql;

CALL comprovar_departament_proc(114);
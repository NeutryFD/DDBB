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

INSERT INTO departments VALUES (1,'Sales',108,2700),
                               (2,'tarragona',15,2700);

SELECT * FROM departments
WHERE department_id = 1 or department_id = 2;

--Ejercicio #1
CREATE TABLE MY_EMPLOYEE(ID numeric(4),
                        LAST_NAME VARCHAR(25),
                        FIRST_NAME VARCHAR(25),
                        USERID VARCHAR(8),
                        SALARY numeric(8),
                        CONSTRAINT MY_EMPLOYEE_ID_PK PRIMARY KEY (ID));
--Ejercicio #2
INSERT INTO MY_EMPLOYEE VALUES (1,'Patel','Ralph','rpatel',895);
INSERT INTO MY_EMPLOYEE VALUES (2,'Danc','Betty','bdancs',860);
INSERT INTO MY_EMPLOYEE(ID,LAST_NAME,FIRST_NAME,SALARY) VALUES (3,'Biri','Ben',1100);
INSERT INTO MY_EMPLOYEE(ID, LAST_NAME, FIRST_NAME,SALARY) VALUES (4,'Newman','Chad',750);



--Ejercicio #3
UPDATE MY_EMPLOYEE
    SET USERID = concat(substr(lower(FIRST_NAME),1,1),lower(LAST_NAME))
    WHERE ID=3 OR ID=4;

--Ejercicio #4
commit; --Nos aseguramos que las datos estan guardado en la DDBB
SELECT * FROM MY_EMPLOYEE;

--Ejercicio #5
UPDATE MY_EMPLOYEE
    SET LAST_NAME='Drexler'
    WHERE ID=3;

--Ejercicio #6
UPDATE MY_EMPLOYEE
    SET SALARY = 1000
    WHERE SALARY < 900;

--Ejercicio #7
DELETE  FROM MY_EMPLOYEE
    WHERE FIRST_NAME = 'Betty' AND LAST_NAME = 'Danc';

--Ejercicio #8
SELECT * FROM MY_EMPLOYEE;

--Ejercicio #9
COMMIT ;

--Ejericicio #10
begin ;
INSERT INTO MY_EMPLOYEE VALUES (5,'Ropeburn','Audrey','aropebur',1550);
END;

--Ejercicio #11
SELECT * FROM MY_EMPLOYEE ORDER BY 1 ASC ;

--Ejercicio #12
BEGIN ;
SAVEPOINT Marcar14;

--Ejercicio #13
DELETE FROM MY_EMPLOYEE;

--Ejecicio #14
ROLLBACK TO Marcar14;

--Ejercicio #15
SELECT * FROM MY_EMPLOYEE;
END;


/*DELETE FROM MY_EMPLOYEE WHERE ID=5;
SELECT  substr(FIRST_NAME,1,1), LAST_NAME FROM MY_EMPLOYEE;
SELECT * FROM MY_EMPLOYEE ORDER BY 1;*/

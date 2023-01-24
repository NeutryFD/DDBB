/**********************************************************************************************************************/
CREATE TABLE provincia (
    cod_pro varchar(2) not null,
    nombre varchar(30) not null ,

    constraint P_provincia  PRIMARY KEY (cod_pro));

/**********************************************************************************************************************/
CREATE TABLE pueblos (
  codpue varchar(5) not null ,
  nombre varchar(40) not null ,
  cod_pro varchar(2) not null ,

    constraint P_pueblos PRIMARY KEY (codpue),
    constraint F_Cod_pro FOREIGN KEY (cod_pro) REFERENCES provincia on delete cascade);

/**********************************************************************************************************************/
CREATE TABLE clientes (
    codcli numeric(5) not null ,
    nombre varchar(50) not null ,
    direccion varchar(50) not null ,
    codpostal varchar(5) ,
    codpue varchar(5) not null,

        constraint P_codcli PRIMARY KEY (codcli),
        constraint F_codpue FOREIGN KEY (codpue) references pueblos on delete set null );

/**********************************************************************************************************************/
CREATE TABLE vendedores(
    codven numeric(5) not null ,
    nombre varchar(50) not null ,
    direccion varchar(50) not null ,
    codpostal varchar(5) ,
    codpue varchar(5) not null ,
    codjefe numeric(5) ,

        constraint P_codven PRIMARY KEY (codven),
        constraint F_codpue FOREIGN KEY (codpue) references pueblos (codpue) on delete cascade,
        constraint F_codjefe FOREIGN KEY (codjefe) references vendedores (codven)on delete cascade);
/**********************************************************************************************************************/
CREATE TABLE articulos(
    codart varchar(8) not null ,
    descrip varchar(40) not null ,
    precio numeric(7,2) not null ,
    stock numeric(6) ,
    stock_min numeric(6) ,

    constraint P_codart PRIMARY KEY (codart));


DELETE FROM articulos;
SELECT * FROM articulos;

/**********************************************************************************************************************/
CREATE TABLE facturas(
    codfac numeric(6) not null ,
    fecha date not null ,
    codcli numeric(5) ,
    codven numeric(5) ,
    iva numeric(2) ,
    dto numeric(2) ,

        constraint P_codfac PRIMARY KEY (codfac) ,
        constraint F_codcli FOREIGN KEY (codcli) references clientes on delete cascade ,
        constraint F_codven FOREIGN KEY (codven) references vendedores on delete cascade );


/**********************************************************************************************************************/
CREATE TABLE linea_fac (
    codfac numeric(6) not null ,
    linea numeric(2) not null ,
    cant numeric(5) ,
    codart varchar(8) not null ,
    precio numeric(7,2) ,
    dto numeric(2),

        constraint F_codfac FOREIGN KEY (codfac) references facturas on delete cascade ,
        constraint F_codart FOREIGN KEY (codart) references articulos on delete cascade );
/*+++++++******************************************************************************************++++++++++++++++++**/
select * from articulos;


--Ejercicio 2
ALTER TABLE articulos
add constraint chk_art CHECK ( precio > 0 and stock_min > 0 and stock > 0),
add constraint chk_stocks CHECK ( stock is not null and stock_min is not  null);

--Ejercico 3
ALTER TABLE facturas
add constraint Ch_factura CHECK ( iva in  (4,10,21) and dto in (10,20,30,40,50 ));
INSERT INTO facturas(codfac, fecha,iva, dto) values (7,current_date,10,30);

--Ejercicio 4
INSERT INTO articulos VALUES ('ARTXXX','Articulo  prueba',10.20,90,10);
de
--Ejercicio 5
INSERT INTO articulos (codart,descrip,precio) VALUES ('ARTYYY','Articulo de prueba2',10.20); -- unique constrain "p_codart"

--Ejercicio 6
INSERT INTO articulos (codart,descrip,precio) VALUES ('ARTZZZ','Articulo de prueba3',10.20); -- Y el not null? actualizar los valores de la tabala
                                                                    -- o agregar la constrai

--Ejercicio 7




DELETE FROM  articulos
    WHERE codart in ('ARTZZZ','ARTYYY');

/*
ALTER TABLE articulos
    DROP constraint {name_constratin}
*/

SELECT * FROM articulos;
ALTER TABLE articulos
ALTER COLUMN stock SET NOT NULL;

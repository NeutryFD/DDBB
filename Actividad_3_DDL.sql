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
        constraint F_codpue FOREIGN KEY (codpue) references pueblos on delete cascade,
        constraint F_codjefe FOREIGN KEY (codjefe) references vendedores on delete cascade);

/**********************************************************************************************************************/
CREATE TABLE articulos(
    codart varchar(8) not null ,
    descrip varchar(40) not null ,
    precio numeric(7,2) not null ,
    stock numeric(6) not null ,
    stock_min numeric(6) not null ,

    constraint P_codart PRIMARY KEY (codart));

ALTER TABLE articulos
add constraint chk_art CHECK ( precio > 0 and stock_min > 0 and stock > 0);
INSERT INTO articulos VALUES (44,44,5,44,44);
INSERT INTO articulos VALUES ('ARTXXX','Articulo de prueba',10.20,90,10);
INSERT INTO articulos VALUES ('ARTXXX','Articulo de prueba2',10.20); -- unique constrain "p_codart"
INSERT INTO articulos VALUES ('ARTZZZ','Articulo de prueba3',1020); -- Y el not null?


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


ALTER TABLE facturas
add constraint Ch_factura CHECK ( iva in  (4,10,21) and dto in (10,20,30,40,50 ));
INSERT INTO facturas(codfac, fecha,iva, dto) values (7,current_date,10,30);

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
/**********************************************************************************************************************/

select * from articulos;


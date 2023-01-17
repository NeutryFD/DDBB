CREATE TABLE provincia (
    Cod_pro varchar(2) not null,
    Nombre varchar(30) not null ,

    constraint P_provincia  PRIMARY KEY (Cod_pro));


CREATE TABLE prueblos (
  Codpue varchar(5) not null ,
  Nombre varchar(40) not null ,
  Cod_pro varchar(2) not null ,

    constraint P_pueblos PRIMARY KEY (Codpue),
    constraint F_Cod_pro FOREIGN KEY (Cod_pro) REFERENCES provincia on delete cascade);

CREATE TABLE clientes (
    Codcli numeric(5) not null ,
    Nombre varchar(50) not null ,
    Direccion varchar(50) not null 
);
select * from provincia;


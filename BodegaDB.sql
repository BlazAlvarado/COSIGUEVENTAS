drop database if exists BodegaBD;
create database BodegaBD;
use BodegaBD;

create table if not exists Cliente(
dni   int(8) unsigned not null,
cli_nombre      varchar(150) not null,
cli_apellido varchar(150) not null,
cli_direccion varchar(50) default null,
cli_sexo enum('Masculino','Femenino','Otro') default null,
cli_fechanac date default null,
primary key(dni)
);
insert into Cliente(dni,cli_nombre,cli_apellido,cli_direccion,cli_sexo,cli_fechanac) values(71500070,'Cristian','Blaz Alvarado','Jr 28 Julio 1370',1,'2000-10-18'); 

create table if not exists Empleado(
idEmpleado int unsigned not null auto_increment,
emp_nombre      varchar(150) not null,
emp_apellido varchar(150) not null,
emp_sueldo decimal(7,2) not null,
primary key(idEmpleado)using btree
);
insert into Empleado(emp_nombre,emp_apellido,emp_sueldo) values('Antony','Cristobal',500.00);

create table if not exists Categoria (
idCategoria int unsigned not null auto_increment,
cat_Nombre VARCHAR(40) NOT NULL,
primary key(idCategoria)using btree);

insert into Categoria(cat_Nombre) values('Bebidas');

create table if not exists Proveedor(
ruc varchar(11) not null,
prov_Nombre VARCHAR(100) NOT NULL,
prov_Direccion VARCHAR(180),
prov_Telefono INT(9),
primary key(ruc)using btree
);

insert into Proveedor(RUC,prov_Nombre,prov_Direccion,prov_Telefono) values(14745454,'Coca Cola','Av. Lionso Prado 307',933967845);

create table if not exists Producto(
idProducto int unsigned not null auto_increment,
pro_Nombre varchar(100) not null,
pro_PrecioVenta decimal(7,2) not null,
pro_Stock int unsigned not null,
pro_ruc varchar(11)  not null,
pro_idCategoria int unsigned not null,
primary key(idProducto),
constraint fk_producRuc_prove foreign key (pro_ruc) references Proveedor(ruc) on delete no action on update no action,
constraint fk_producId_categ foreign key (pro_idCategoria) references Categoria(idCategoria) on delete no action on update no action
);

insert into Producto(pro_Nombre,pro_PrecioVenta,pro_Stock,pro_ruc,pro_idCategoria) values ('Coca Cola',2.00,100,'14745454',1);

create table if not exists Ventas (
idVenta int unsigned not null auto_increment,
ven_Fecha timestamp default current_timestamp(),
dni int unsigned not null,
idEmpleado int unsigned not null,
primary key(idVenta),
constraint fk_cliente_dni foreign key (dni) references Cliente(dni)  on delete no action on update no action,
constraint fk_empleado_id foreign key (idEmpleado) references Empleado (idEmpleado)on delete no action on update no action
);

insert into Ventas(dni,idEmpleado)values(71500070,1);


create table if not exists DetalleVenta (
idDetalleVenta int unsigned not null auto_increment,
idVenta int unsigned not null,
idProducto int unsigned not null,
dvenCantidad INT(10) NOT NULL,
primary key(idDetalleVenta)using btree,
constraint fk_venta_id foreign key (idVenta) references Ventas(idVenta),
constraint fk_produ_id foreign key (idProducto) references Producto(idProducto));

insert into DetalleVenta(idVenta,idProducto,dvenCantidad) values(1,1,50);



drop procedure if exists sp_insert_clientes;
delimiter //
create procedure sp_insert_clientes(
dni   int(8) ,
nombre 			varchar(150),
apellido 		varchar(150),
direccion       varchar(50),
sexoid			tinyint,
fechnac 		date
)
begin
insert into Cliente(dni,cli_nombre,cli_apellido,cli_direccion,cli_sexo,cli_fechanac) 
values(dni,nombre,apellido,direccion,sexoid,fechnac); 
end//
delimiter ;

call sp_insert_clientes(71500071,'Favio','Blaz Alvarado','Jr. 28 de Julio',1,'2001-03-30');


drop procedure if exists sp_update_clientes;
delimiter //
create procedure sp_update_clientes(
dni_id   int(8) ,
new_dni int(8),
nombre 			varchar(150),
apellido 		varchar(150),
direccion       varchar(50),
sexoid			tinyint,
fechnac 		date
)
begin
	update Cliente 
    set dni=new_dni,
		cli_nombre=nombre,
        cli_apellido=apellido,
        cli_direccion=direccion,
        cli_sexo=sexoid,
        cli_fechanac=fechnac
        where dni=dni_id;
end//
delimiter ;

call sp_update_clientes(71500071,71500072,'Favio Enrrique','Blaz Alvarado','Jr. 28 de Julio',1,'2002-03-30');


drop procedure if exists sp_buscar_clientes;
delimiter //
create procedure sp_buscar_clientes(
id int
)
begin		
	select * from Cliente
    where dni=id ;
end//
delimiter ; 

call sp_buscar_clientes(71500072);

drop procedure if exists sp_delete_clientes;
delimiter //
create procedure sp_delete_clientes(
id				int
)
begin
	delete 
    from Cliente
    where dni=id;
end//
delimiter ;

call sp_delete_clientes(71500072);

drop procedure if exists sp_insert_empleados;
delimiter //
create procedure sp_insert_empleados(
nombre 		varchar(150),
apellido 	varchar(150),
sueldo      decimal(7,2)
)
begin
insert into Empleado(emp_nombre,emp_apellido,emp_sueldo) 
values(nombre,apellido,sueldo); 
end//
delimiter ;
call sp_insert_empleados('Gabriel','Morales Fabian',500.00);

drop procedure if exists sp_update_empleados;
delimiter //
create procedure sp_update_empleados(
empleado_id   int(8) ,
nombre 			varchar(150),
apellido 		varchar(150),
sueldo 			decimal(7,2)
)
begin
	update Empleado 
    set emp_nombre=nombre,
        emp_apellido=apellido,
        emp_sueldo=sueldo
        where idEmpleado=empleado_id;
end//
delimiter ;

call sp_update_empleados(2,'Andres','Prieto Castillo',600.00);

drop procedure if exists sp_buscar_empleados;
delimiter //
create procedure sp_buscar_empleados(
id int
)
begin		
	select * from Empleado
    where idEmpleado=id ;
end//
delimiter ; 

call sp_buscar_empleados(2);

drop procedure if exists sp_delete_empleados;
delimiter //
create procedure sp_delete_empleados(
id int
)
begin
	delete 
    from Empleado
	where idEmpleado=id;
end//
delimiter ;

call sp_delete_empleados(2);
 
 drop procedure if exists sp_insert_productos;
 delimiter //
create procedure sp_insert_productos(
	nombre varchar(100),
    precioventa decimal(7,2),
    stock int,
    ruc varchar(11),
    idCategoria int
    )
    begin
		insert into Producto(pro_Nombre,pro_PrecioVenta,pro_Stock,pro_ruc,pro_idCategoria) values (nombre,precioventa,stock,ruc,idCategoria);
    end //
    delimiter ;
    call sp_insert_productos('CocaCola2',5.00,200,14745454,1);
drop procedure if exists sp_delete_productos;
delimiter //
create procedure sp_delete_productos(
id int)
begin
	delete
    from Producto
    where idProducto=id;
end //
delimiter ;

call sp_delete_productos(3);

drop procedure if exists sp_update_productos;
delimiter //
create procedure sp_update_productos(
id_producto int,
nombre 			varchar(150),
precioventa		decimal(7,2),
stock 			int,
ruc 			varchar(11),
idCategoria 	int
)
begin
	update Producto
    set pro_Nombre=nombre,
        pro_PrecioVenta=precioventa,
        pro_Stock=stock,
        pro_ruc=ruc,
        pro_idCategoria=idCategoria
        where idProducto=id_producto;
end //
delimiter ;

call sp_update_productos(1,'Inca Cola',2.00,200,14745454,1);

drop procedure if exists sp_buscar_productos;
delimiter //
create procedure sp_buscar_productos(
id int
)
begin		
	select * from Producto
    where idProducto=id ;
end//
delimiter ; 

call sp_buscar_productos(1);

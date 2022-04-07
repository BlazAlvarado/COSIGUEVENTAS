-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-04-2022 a las 06:05:35
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de datos: `bodegabd`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_clientes` (`id` INT)   begin		
	select * from Cliente
    where dni=id ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_empleados` (`id` INT)   begin		
	select * from Empleado
    where idEmpleado=id ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_productos` (`id` INT)   begin		
	select * from Producto
    where idProducto=id ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_clientes` (`id` INT)   begin
	delete 
    from Cliente
    where dni=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_empleados` (`id` INT)   begin
	delete 
    from Empleado
	where idEmpleado=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_productos` (`id` INT)   begin
	delete
    from Producto
    where idProducto=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_clientes` (`dni` INT(8), `nombre` VARCHAR(150), `apellido` VARCHAR(150), `direccion` VARCHAR(50), `sexoid` TINYINT, `fechnac` DATE)   begin
insert into Cliente(dni,cli_nombre,cli_apellido,cli_direccion,cli_sexo,cli_fechanac) 
values(dni,nombre,apellido,direccion,sexoid,fechnac); 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_empleados` (`nombre` VARCHAR(150), `apellido` VARCHAR(150), `sueldo` DECIMAL(7,2))   begin
insert into Empleado(emp_nombre,emp_apellido,emp_sueldo) 
values(nombre,apellido,sueldo); 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_productos` (`nombre` VARCHAR(100), `precioventa` DECIMAL(7,2), `stock` INT, `ruc` VARCHAR(11), `idCategoria` INT)   begin
		insert into Producto(pro_Nombre,pro_PrecioVenta,pro_Stock,pro_ruc,pro_idCategoria) values (nombre,precioventa,stock,ruc,idCategoria);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_clientes` (`dni_id` INT(8), `new_dni` INT(8), `nombre` VARCHAR(150), `apellido` VARCHAR(150), `direccion` VARCHAR(50), `sexoid` TINYINT, `fechnac` DATE)   begin
	update Cliente 
    set dni=new_dni,
		cli_nombre=nombre,
        cli_apellido=apellido,
        cli_direccion=direccion,
        cli_sexo=sexoid,
        cli_fechanac=fechnac
        where dni=dni_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_empleados` (`empleado_id` INT(8), `nombre` VARCHAR(150), `apellido` VARCHAR(150), `sueldo` DECIMAL(7,2))   begin
	update Empleado 
    set emp_nombre=nombre,
        emp_apellido=apellido,
        emp_sueldo=sueldo
        where idEmpleado=empleado_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_productos` (`id_producto` INT, `nombre` VARCHAR(150), `precioventa` DECIMAL(7,2), `stock` INT, `ruc` VARCHAR(11), `idCategoria` INT)   begin
	update Producto
    set pro_Nombre=nombre,
        pro_PrecioVenta=precioventa,
        pro_Stock=stock,
        pro_ruc=ruc,
        pro_idCategoria=idCategoria
        where idProducto=id_producto;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(10) UNSIGNED NOT NULL,
  `cat_Nombre` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `cat_Nombre`) VALUES
(1, 'Bebidas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `dni` int(8) UNSIGNED NOT NULL,
  `cli_nombre` varchar(150) NOT NULL,
  `cli_apellido` varchar(150) NOT NULL,
  `cli_direccion` varchar(50) DEFAULT NULL,
  `cli_sexo` enum('Masculino','Femenino','Otro') DEFAULT NULL,
  `cli_fechanac` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`dni`, `cli_nombre`, `cli_apellido`, `cli_direccion`, `cli_sexo`, `cli_fechanac`) VALUES
(71500070, 'Cristian', 'Blaz Alvarado', 'Jr 28 Julio 1370', 'Masculino', '2000-10-18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventa`
--

CREATE TABLE `detalleventa` (
  `idDetalleVenta` int(10) UNSIGNED NOT NULL,
  `idVenta` int(10) UNSIGNED NOT NULL,
  `idProducto` int(10) UNSIGNED NOT NULL,
  `dvenCantidad` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalleventa`
--

INSERT INTO `detalleventa` (`idDetalleVenta`, `idVenta`, `idProducto`, `dvenCantidad`) VALUES
(1, 1, 1, 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idEmpleado` int(10) UNSIGNED NOT NULL,
  `emp_nombre` varchar(150) NOT NULL,
  `emp_apellido` varchar(150) NOT NULL,
  `emp_sueldo` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `emp_nombre`, `emp_apellido`, `emp_sueldo`) VALUES
(1, 'Antony', 'Cristobal', '500.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(10) UNSIGNED NOT NULL,
  `pro_Nombre` varchar(100) NOT NULL,
  `pro_PrecioVenta` decimal(7,2) NOT NULL,
  `pro_Stock` int(10) UNSIGNED NOT NULL,
  `pro_ruc` varchar(11) NOT NULL,
  `pro_idCategoria` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `pro_Nombre`, `pro_PrecioVenta`, `pro_Stock`, `pro_ruc`, `pro_idCategoria`) VALUES
(1, 'Inca Cola', '2.00', 200, '14745454', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `ruc` varchar(11) NOT NULL,
  `prov_Nombre` varchar(100) NOT NULL,
  `prov_Direccion` varchar(180) DEFAULT NULL,
  `prov_Telefono` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`ruc`, `prov_Nombre`, `prov_Direccion`, `prov_Telefono`) VALUES
('14745454', 'Coca Cola', 'Av. Lionso Prado 307', 933967845);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVenta` int(10) UNSIGNED NOT NULL,
  `ven_Fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `dni` int(10) UNSIGNED NOT NULL,
  `idEmpleado` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idVenta`, `ven_Fecha`, `dni`, `idEmpleado`) VALUES
(1, '2022-04-07 03:10:43', 71500070, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`) USING BTREE;

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD PRIMARY KEY (`idDetalleVenta`) USING BTREE,
  ADD KEY `fk_venta_id` (`idVenta`),
  ADD KEY `fk_produ_id` (`idProducto`);

--
-- Indices de la tabla `empleado`
-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-04-2022 a las 06:07:08
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de datos: bodegabd
--
CREATE DATABASE IF NOT EXISTS bodegabd DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE bodegabd;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_buscar_clientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_clientes` (`id` INT)   begin		
	select * from Cliente
    where dni=id ;
end$$

DROP PROCEDURE IF EXISTS `sp_buscar_empleados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_empleados` (`id` INT)   begin		
	select * from Empleado
    where idEmpleado=id ;
end$$

DROP PROCEDURE IF EXISTS `sp_buscar_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_productos` (`id` INT)   begin		
	select * from Producto
    where idProducto=id ;
end$$

DROP PROCEDURE IF EXISTS `sp_delete_clientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_clientes` (`id` INT)   begin
	delete 
    from Cliente
    where dni=id;
end$$

DROP PROCEDURE IF EXISTS `sp_delete_empleados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_empleados` (`id` INT)   begin
	delete 
    from Empleado
	where idEmpleado=id;
end$$

DROP PROCEDURE IF EXISTS `sp_delete_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_productos` (`id` INT)   begin
	delete
    from Producto
    where idProducto=id;
end$$

DROP PROCEDURE IF EXISTS `sp_insert_clientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_clientes` (`dni` INT(8), `nombre` VARCHAR(150), `apellido` VARCHAR(150), `direccion` VARCHAR(50), `sexoid` TINYINT, `fechnac` DATE)   begin
insert into Cliente(dni,cli_nombre,cli_apellido,cli_direccion,cli_sexo,cli_fechanac) 
values(dni,nombre,apellido,direccion,sexoid,fechnac); 
end$$

DROP PROCEDURE IF EXISTS `sp_insert_empleados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_empleados` (`nombre` VARCHAR(150), `apellido` VARCHAR(150), `sueldo` DECIMAL(7,2))   begin
insert into Empleado(emp_nombre,emp_apellido,emp_sueldo) 
values(nombre,apellido,sueldo); 
end$$

DROP PROCEDURE IF EXISTS `sp_insert_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_productos` (`nombre` VARCHAR(100), `precioventa` DECIMAL(7,2), `stock` INT, `ruc` VARCHAR(11), `idCategoria` INT)   begin
		insert into Producto(pro_Nombre,pro_PrecioVenta,pro_Stock,pro_ruc,pro_idCategoria) values (nombre,precioventa,stock,ruc,idCategoria);
    end$$

DROP PROCEDURE IF EXISTS `sp_update_clientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_clientes` (`dni_id` INT(8), `new_dni` INT(8), `nombre` VARCHAR(150), `apellido` VARCHAR(150), `direccion` VARCHAR(50), `sexoid` TINYINT, `fechnac` DATE)   begin
	update Cliente 
    set dni=new_dni,
		cli_nombre=nombre,
        cli_apellido=apellido,
        cli_direccion=direccion,
        cli_sexo=sexoid,
        cli_fechanac=fechnac
        where dni=dni_id;
end$$

DROP PROCEDURE IF EXISTS `sp_update_empleados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_empleados` (`empleado_id` INT(8), `nombre` VARCHAR(150), `apellido` VARCHAR(150), `sueldo` DECIMAL(7,2))   begin
	update Empleado 
    set emp_nombre=nombre,
        emp_apellido=apellido,
        emp_sueldo=sueldo
        where idEmpleado=empleado_id;
end$$

DROP PROCEDURE IF EXISTS `sp_update_productos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_productos` (`id_producto` INT, `nombre` VARCHAR(150), `precioventa` DECIMAL(7,2), `stock` INT, `ruc` VARCHAR(11), `idCategoria` INT)   begin
	update Producto
    set pro_Nombre=nombre,
        pro_PrecioVenta=precioventa,
        pro_Stock=stock,
        pro_ruc=ruc,
        pro_idCategoria=idCategoria
        where idProducto=id_producto;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla categoria
--

DROP TABLE IF EXISTS categoria;
CREATE TABLE categoria (
  idCategoria int(10) UNSIGNED NOT NULL,
  cat_Nombre varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla categoria
--

INSERT INTO categoria (idCategoria, cat_Nombre) VALUES
(1, 'Bebidas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla cliente
--

DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
  dni int(8) UNSIGNED NOT NULL,
  cli_nombre varchar(150) NOT NULL,
  cli_apellido varchar(150) NOT NULL,
  cli_direccion varchar(50) DEFAULT NULL,
  cli_sexo enum('Masculino','Femenino','Otro') DEFAULT NULL,
  cli_fechanac date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla cliente
--

INSERT INTO cliente (dni, cli_nombre, cli_apellido, cli_direccion, cli_sexo, cli_fechanac) VALUES
(71500070, 'Cristian', 'Blaz Alvarado', 'Jr 28 Julio 1370', 'Masculino', '2000-10-18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla detalleventa
--

DROP TABLE IF EXISTS detalleventa;
CREATE TABLE detalleventa (
  idDetalleVenta int(10) UNSIGNED NOT NULL,
  idVenta int(10) UNSIGNED NOT NULL,
  idProducto int(10) UNSIGNED NOT NULL,
  dvenCantidad int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla detalleventa
--

INSERT INTO detalleventa (idDetalleVenta, idVenta, idProducto, dvenCantidad) VALUES
(1, 1, 1, 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla empleado
--

DROP TABLE IF EXISTS empleado;
CREATE TABLE empleado (
  idEmpleado int(10) UNSIGNED NOT NULL,
  emp_nombre varchar(150) NOT NULL,
  emp_apellido varchar(150) NOT NULL,
  emp_sueldo decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla empleado
--

INSERT INTO empleado (idEmpleado, emp_nombre, emp_apellido, emp_sueldo) VALUES
(1, 'Antony', 'Cristobal', '500.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla producto
--

DROP TABLE IF EXISTS producto;
CREATE TABLE producto (
  idProducto int(10) UNSIGNED NOT NULL,
  pro_Nombre varchar(100) NOT NULL,
  pro_PrecioVenta decimal(7,2) NOT NULL,
  pro_Stock int(10) UNSIGNED NOT NULL,
  pro_ruc varchar(11) NOT NULL,
  pro_idCategoria int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla producto
--

INSERT INTO producto (idProducto, pro_Nombre, pro_PrecioVenta, pro_Stock, pro_ruc, pro_idCategoria) VALUES
(1, 'Inca Cola', '2.00', 200, '14745454', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla proveedor
--

DROP TABLE IF EXISTS proveedor;
CREATE TABLE proveedor (
  ruc varchar(11) NOT NULL,
  prov_Nombre varchar(100) NOT NULL,
  prov_Direccion varchar(180) DEFAULT NULL,
  prov_Telefono int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla proveedor
--

INSERT INTO proveedor (ruc, prov_Nombre, prov_Direccion, prov_Telefono) VALUES
('14745454', 'Coca Cola', 'Av. Lionso Prado 307', 933967845);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla ventas
--

DROP TABLE IF EXISTS ventas;
CREATE TABLE ventas (
  idVenta int(10) UNSIGNED NOT NULL,
  ven_Fecha timestamp NOT NULL DEFAULT current_timestamp(),
  dni int(10) UNSIGNED NOT NULL,
  idEmpleado int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla ventas
--

INSERT INTO ventas (idVenta, ven_Fecha, dni, idEmpleado) VALUES
(1, '2022-04-07 03:10:43', 71500070, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla categoria
--
ALTER TABLE categoria
  ADD PRIMARY KEY (idCategoria) USING BTREE;

--
-- Indices de la tabla cliente
--
ALTER TABLE cliente
  ADD PRIMARY KEY (dni);

--
-- Indices de la tabla detalleventa
--
ALTER TABLE detalleventa
  ADD PRIMARY KEY (idDetalleVenta) USING BTREE,
  ADD KEY fk_venta_id (idVenta),
  ADD KEY fk_produ_id (idProducto);

--
-- Indices de la tabla empleado
--
ALTER TABLE empleado
  ADD PRIMARY KEY (idEmpleado) USING BTREE;

--
-- Indices de la tabla producto
--
ALTER TABLE producto
  ADD PRIMARY KEY (idProducto),
  ADD KEY fk_producRuc_prove (pro_ruc),
  ADD KEY fk_producId_categ (pro_idCategoria);

--
-- Indices de la tabla proveedor
--
ALTER TABLE proveedor
  ADD PRIMARY KEY (ruc) USING BTREE;

--
-- Indices de la tabla ventas
--
ALTER TABLE ventas
  ADD PRIMARY KEY (idVenta),
  ADD KEY fk_cliente_dni (dni),
  ADD KEY fk_empleado_id (idEmpleado);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla categoria
--
ALTER TABLE categoria
  MODIFY idCategoria int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla detalleventa
--
ALTER TABLE detalleventa
  MODIFY idDetalleVenta int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla empleado
--
ALTER TABLE empleado
  MODIFY idEmpleado int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla producto
--
ALTER TABLE producto
  MODIFY idProducto int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla ventas
--
ALTER TABLE ventas
  MODIFY idVenta int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla detalleventa
--
ALTER TABLE detalleventa
  ADD CONSTRAINT fk_produ_id FOREIGN KEY (idProducto) REFERENCES producto (idProducto),
  ADD CONSTRAINT fk_venta_id FOREIGN KEY (idVenta) REFERENCES ventas (idVenta);

--
-- Filtros para la tabla producto
--
ALTER TABLE producto
  ADD CONSTRAINT fk_producId_categ FOREIGN KEY (pro_idCategoria) REFERENCES categoria (idCategoria) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_producRuc_prove FOREIGN KEY (pro_ruc) REFERENCES proveedor (ruc) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla ventas
--
ALTER TABLE ventas
  ADD CONSTRAINT fk_cliente_dni FOREIGN KEY (dni) REFERENCES `cliente` (dni) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_empleado_id FOREIGN KEY (idEmpleado) REFERENCES empleado (idEmpleado) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

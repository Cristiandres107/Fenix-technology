-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-09-2023 a las 13:58:15
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fenix_technology`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodegas`
--

CREATE TABLE `bodegas` (
  `Id_bodega` int(5) NOT NULL,
  `Ubicacion_bodega` varchar(20) NOT NULL,
  `PK_fk_marcaproducto_bode` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bodegas`
--

INSERT INTO `bodegas` (`Id_bodega`, `Ubicacion_bodega`, `PK_fk_marcaproducto_bode`) VALUES
(1, 'Almacén Central', 'nike1'),
(2, 'Bodega Norte', 'new balance2'),
(3, 'Bodega Sur', 'adidas3'),
(4, 'Almacén Principal', 'puma4'),
(5, 'Bodega Este', 'puma5'),
(6, 'Bodega Oeste', 'nike6'),
(7, 'Almacén Secundario', 'jordan7'),
(8, 'Bodega Central', 'fila'),
(9, 'Bodega Local', 'rebook9'),
(10, 'Almacén de Reserva', 'fila10'),
(11, 'Bodega Occidental', 'adidas11'),
(12, 'Bodega de Emergencia', 'nike12'),
(13, 'Bodega Local', 'puma13'),
(14, 'Almacén de Distribuc', 'new balance14'),
(15, 'Bodega Central', 'rebook15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devoluciones_locales`
--

CREATE TABLE `devoluciones_locales` (
  `Id_devolucion` int(5) NOT NULL,
  `Pk_fk_producto` int(5) NOT NULL,
  `Fecha_devolucion` datetime NOT NULL,
  `Pk_fk_numlocal` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `devoluciones_locales`
--

INSERT INTO `devoluciones_locales` (`Id_devolucion`, `Pk_fk_producto`, `Fecha_devolucion`, `Pk_fk_numlocal`) VALUES
(1, 1, '2023-08-05 09:30:00', 1),
(2, 2, '2023-08-06 11:15:00', 2),
(3, 3, '2023-08-07 10:00:00', 3),
(4, 4, '2023-08-08 12:45:00', 4),
(5, 5, '2023-08-09 14:30:00', 5),
(6, 1, '2023-08-10 15:00:00', 1),
(7, 2, '2023-08-11 13:30:00', 2),
(8, 3, '2023-08-12 11:45:00', 3),
(9, 4, '2023-08-13 09:15:00', 4),
(10, 5, '2023-08-14 10:30:00', 5),
(11, 1, '2023-08-15 14:00:00', 1),
(12, 2, '2023-08-16 12:00:00', 2),
(13, 3, '2023-08-17 11:15:00', 3),
(14, 4, '2023-08-18 09:30:00', 4),
(15, 5, '2023-08-19 10:45:00', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas_productos`
--

CREATE TABLE `entradas_productos` (
  `id_entradas_producto` int(5) NOT NULL,
  `PK_fk_marcaproducto_entradas` varchar(15) NOT NULL,
  `PK_fk_idbodega_entradas` int(5) NOT NULL,
  `PK_fk_idproveedor_entradas` int(5) NOT NULL,
  `Cantidad_entradas_producto` int(5) NOT NULL,
  `Fecha_entrada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entradas_productos`
--

INSERT INTO `entradas_productos` (`id_entradas_producto`, `PK_fk_marcaproducto_entradas`, `PK_fk_idbodega_entradas`, `PK_fk_idproveedor_entradas`, `Cantidad_entradas_producto`, `Fecha_entrada`) VALUES
(1, 'nike1', 1, 1, 50, '2023-08-01 00:00:00'),
(2, 'new balance2', 2, 2, 30, '2023-08-02 00:00:00'),
(3, 'adidas3', 3, 3, 40, '2023-08-03 00:00:00'),
(4, 'puma4', 4, 1, 25, '2023-08-04 00:00:00'),
(5, 'puma5', 5, 2, 35, '2023-08-05 00:00:00'),
(6, 'nike6', 1, 3, 20, '2023-08-06 00:00:00'),
(7, 'jordan7', 2, 1, 10, '2023-08-07 00:00:00'),
(8, 'fila', 3, 2, 15, '2023-08-08 00:00:00'),
(9, 'rebook9', 4, 3, 30, '2023-08-09 00:00:00'),
(10, 'fila10', 5, 1, 12, '2023-08-10 00:00:00'),
(11, 'adidas11', 1, 2, 28, '2023-08-11 00:00:00'),
(12, 'nike12', 2, 3, 18, '2023-08-12 00:00:00'),
(13, 'puma13', 3, 1, 22, '2023-08-13 00:00:00'),
(14, 'new balance14', 4, 2, 40, '2023-08-14 00:00:00'),
(15, 'rebook15', 5, 3, 16, '2023-08-15 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envios`
--

CREATE TABLE `envios` (
  `Id_envio` int(10) NOT NULL,
  `Tipo_envio` varchar(20) NOT NULL,
  `Nomtransportadora_envio` varchar(20) NOT NULL,
  `Cuidad_envio` varchar(20) NOT NULL,
  `Dirección_entrega_envio` varchar(30) NOT NULL,
  `Valor_envio` bigint(10) NOT NULL,
  `Fecha_estimada_entrega_pedido` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `envios`
--

INSERT INTO `envios` (`Id_envio`, `Tipo_envio`, `Nomtransportadora_envio`, `Cuidad_envio`, `Dirección_entrega_envio`, `Valor_envio`, `Fecha_estimada_entrega_pedido`) VALUES
(1, 'Express', 'TransFast', 'Bogotá', 'Calle 123', 10000, '2023-09-01'),
(2, 'Estándar', 'EnvíoSeguro', 'Medellín', 'Av. Principal', 8000, '2023-09-02'),
(3, 'Express', 'SwiftShip', 'Cali', 'Carrera 456', 12000, '2023-09-03'),
(4, 'Estándar', 'RapidLogistics', 'Barranquilla', 'Calle 789', 9000, '2023-09-04'),
(5, 'Express', 'QuickDeliver', 'Cartagena', 'Av. Costanera', 11000, '2023-09-05'),
(6, 'Estándar', 'FastCargo', 'Santa Marta', 'Calle 1011', 7500, '2023-09-06'),
(7, 'Express', 'SpeedyShip', 'Pereira', 'Carrera 1213', 10500, '2023-09-07'),
(8, 'Estándar', 'SureShip', 'Manizales', 'Av. Andina', 8500, '2023-09-08'),
(9, 'Express', 'SwiftLog', 'Cúcuta', 'Calle Norte', 12500, '2023-09-09'),
(10, 'Estándar', 'EasyDelivery', 'Pasto', 'Carrera Sur', 9500, '2023-09-10'),
(11, 'Express', 'Expresso', 'Neiva', 'Calle 1415', 11500, '2023-09-11'),
(12, 'Estándar', 'ReliableShip', 'Villavicencio', 'Av. Llanera', 7800, '2023-09-12'),
(13, 'Express', 'QuickShip', 'Bucaramanga', 'Calle 1617', 10200, '2023-09-13'),
(14, 'Estándar', 'SafeTransit', 'Ibagué', 'Carrera 1819', 8900, '2023-09-14'),
(15, 'Express', 'SpeedyDelivery', 'Armenia', 'Av. Quindío', 11800, '2023-09-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `Pk_fk_producto` int(5) NOT NULL,
  `Talla_disponible_producto` varchar(10) NOT NULL,
  `Cantidad_disponible_producto` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`Pk_fk_producto`, `Talla_disponible_producto`, `Cantidad_disponible_producto`) VALUES
(1, 'S', 100),
(2, 'M', 150),
(3, 'L', 200),
(4, 'S', 75),
(5, 'M', 100),
(6, 'L', 120),
(7, 'S', 60),
(8, 'M', 90),
(9, 'L', 110),
(10, 'S', 80),
(11, 'M', 110),
(12, 'L', 150),
(13, 'S', 70),
(14, 'M', 95),
(15, 'L', 130);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jefebodega_has_bodegas`
--

CREATE TABLE `jefebodega_has_bodegas` (
  `Jefebodega_id_jefebodega` int(10) NOT NULL,
  `Bodega_id_bodega` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jefebodega_has_bodegas`
--

INSERT INTO `jefebodega_has_bodegas` (`Jefebodega_id_jefebodega`, `Bodega_id_bodega`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(4, 10),
(4, 11),
(4, 12),
(5, 13),
(5, 14),
(5, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jefe_bodega`
--

CREATE TABLE `jefe_bodega` (
  `Tdoc_jefebodega` varchar(20) NOT NULL,
  `Id_jefe_bodega` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jefe_bodega`
--

INSERT INTO `jefe_bodega` (`Tdoc_jefebodega`, `Id_jefe_bodega`) VALUES
('CC', 1),
('CE', 3),
('CNH', 14),
('CPF', 13),
('CUIL', 12),
('DIMEX', 9),
('DNI', 10),
('DNI', 15),
('MS', 8),
('NIT', 4),
('PAS', 5),
('PE', 7),
('RC', 6),
('SSN', 11),
('TI', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jefe_principal`
--

CREATE TABLE `jefe_principal` (
  `Tdoc_jefeprincipal` varchar(20) NOT NULL,
  `Id_jefeprincipal` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jefe_principal`
--

INSERT INTO `jefe_principal` (`Tdoc_jefeprincipal`, `Id_jefeprincipal`) VALUES
('CC', 1),
('CE', 3),
('CNH', 14),
('CPF', 13),
('CUIL', 12),
('DIMEX', 9),
('DNI', 10),
('DNI', 15),
('MS', 8),
('NIT', 4),
('PAS', 5),
('PE', 7),
('RC', 6),
('SSN', 11),
('TI', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `locales`
--

CREATE TABLE `locales` (
  `Num_local` int(5) NOT NULL,
  `Centro_comercial` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `locales`
--

INSERT INTO `locales` (`Num_local`, `Centro_comercial`) VALUES
(1, 'Mall Plaza'),
(2, 'Unicentro'),
(3, 'Centro Comercial'),
(4, 'La Gran Estación'),
(5, 'Titán Plaza'),
(6, 'Centro Mayor'),
(7, 'Hayuelos'),
(8, 'Centro Chía'),
(9, 'Andino'),
(10, 'Centro Santa Fe'),
(11, 'Salitre Plaza'),
(12, 'Centro Usaquén'),
(13, 'Cedritos'),
(14, 'Plaza Imperial'),
(15, 'Centro Granahorrar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca_producto`
--

CREATE TABLE `marca_producto` (
  `Nom_marca_producto` varchar(15) NOT NULL,
  `Estado_marca_producto` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marca_producto`
--

INSERT INTO `marca_producto` (`Nom_marca_producto`, `Estado_marca_producto`) VALUES
('adidas11', 0),
('adidas3', 0),
('fila', 0),
('fila10', 0),
('jordan7', 0),
('new balance14', 0),
('new balance2', 0),
('nike1', 0),
('nike12', 0),
('nike6', 0),
('puma13', 0),
('puma4', 0),
('puma5', 0),
('rebook15', 0),
('rebook9', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `Id_pedido` int(10) NOT NULL,
  `PK_fk_Idproducto_pedido` int(10) NOT NULL,
  `PK_fk_envio_pedido` int(10) NOT NULL,
  `Fecha_pedido` datetime NOT NULL,
  `Nombre_cliente` varchar(10) NOT NULL,
  `Apellido_cliente` varchar(10) NOT NULL,
  `Telefono_cliente` int(10) NOT NULL,
  `Valor_total_pedido` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`Id_pedido`, `PK_fk_Idproducto_pedido`, `PK_fk_envio_pedido`, `Fecha_pedido`, `Nombre_cliente`, `Apellido_cliente`, `Telefono_cliente`, `Valor_total_pedido`) VALUES
(1, 1, 1, '2023-08-01 10:00:00', 'Juan', 'Pérez', 1234567890, 500),
(2, 2, 2, '2023-08-02 11:30:00', 'María', 'Gómez', 2147483647, 800),
(3, 3, 3, '2023-08-03 09:45:00', 'Andrés', 'Rodríguez', 2147483647, 350),
(4, 4, 4, '2023-08-04 14:15:00', 'Ana', 'López', 1234567800, 600),
(5, 5, 5, '2023-08-05 13:00:00', 'Carlos', 'Martínez', 2147483647, 450),
(6, 6, 1, '2023-08-06 16:30:00', 'Laura', 'García', 1112223330, 700),
(7, 7, 2, '2023-08-07 10:45:00', 'Felipe', 'Hernández', 2147483647, 300),
(8, 8, 3, '2023-08-08 12:15:00', 'Elena', 'Vargas', 2147483647, 550),
(9, 9, 4, '2023-08-09 11:00:00', 'Roberto', 'Guzmán', 1112233440, 900),
(10, 10, 5, '2023-08-10 14:45:00', 'Julia', 'Pérez', 2147483647, 400),
(11, 11, 1, '2023-08-11 13:30:00', 'Miguel', 'Díaz', 2147483647, 750),
(12, 12, 2, '2023-08-12 16:00:00', 'Luis', 'Mendoza', 2147483647, 550),
(13, 13, 3, '2023-08-13 09:15:00', 'Ana', 'Silva', 2147483647, 650),
(14, 14, 4, '2023-08-14 10:30:00', 'Joaquín', 'Martínez', 2147483647, 400),
(15, 15, 5, '2023-08-15 12:00:00', 'Valentina', 'Pérez', 1112233440, 700);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `PK_fk_marca_producto` varchar(15) NOT NULL,
  `Id_producto` int(5) NOT NULL,
  `Modelo_producto` varchar(15) NOT NULL,
  `Tipo_producto` varchar(10) NOT NULL,
  `Color_producto` varchar(10) NOT NULL,
  `Precio_producto` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`PK_fk_marca_producto`, `Id_producto`, `Modelo_producto`, `Tipo_producto`, `Color_producto`, `Precio_producto`) VALUES
('adidas11', 0, 'Stan Smith', 'Zapatillas', 'Blanco/Ver', 100),
('adidas3', 0, 'Ultraboost', 'Zapatillas', 'Negro', 180),
('fila', 0, 'Air Jordan 1', 'Zapatillas', 'Rojo/Negro', 160),
('fila10', 0, 'Classic', 'Zapatillas', 'Blanco', 90),
('jordan7', 0, 'Superstar', 'Zapatillas', 'Blanco', 130),
('new balance14', 0, 'FuelCore', 'Zapatillas', 'Azul', 100),
('new balance2', 0, 'Fresh Foam', 'Zapatillas', 'Gris', 120),
('nike1', 0, 'Air Max 1', 'Zapatillas', 'Blanco', 150),
('nike12', 0, 'Air Max 90', 'Zapatillas', 'Gris', 170),
('nike6', 0, 'Air Force 1', 'Zapatillas', 'Blanco', 120),
('puma13', 0, 'RS-0', 'Zapatillas', 'Blanco/Neg', 140),
('puma4', 0, 'RS-X', 'Zapatillas', 'Azul', 130),
('puma5', 0, 'Cali', 'Zapatillas', 'Blanco', 100),
('rebook15', 0, 'Aztrek', 'Zapatillas', 'Negro/Rojo', 95),
('rebook9', 0, 'Disruptor', 'Zapatillas', 'Blanco', 110);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `Tdoc_proveedor` varchar(20) NOT NULL,
  `Id_proveedor` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`Tdoc_proveedor`, `Id_proveedor`) VALUES
('CC', 1),
('CE', 3),
('CNH', 14),
('CPF', 13),
('CUIL', 12),
('DIMEX', 9),
('DNI', 10),
('DNI', 15),
('MS', 8),
('NIT', 4),
('PAS', 5),
('PE', 7),
('RC', 6),
('SSN', 11),
('TI', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `Cod_rol` int(3) NOT NULL,
  `Desc_rol` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`Cod_rol`, `Desc_rol`) VALUES
(1, 'Jefe Princ'),
(2, 'Jefe de Bo'),
(3, 'Bodeguero'),
(4, 'Proveedor'),
(5, 'Bodeguero'),
(6, 'Proveedor'),
(7, 'Bodeguero'),
(8, 'Proveedor'),
(9, 'Bodeguero'),
(10, 'Proveedor'),
(11, 'Bodeguero'),
(12, 'Proveedor'),
(13, 'Bodeguero'),
(14, 'Bodeguero'),
(15, 'Bodeguero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidas_productos`
--

CREATE TABLE `salidas_productos` (
  `id_salidas_producto` int(5) NOT NULL,
  `PK_fk_marcaproducto_salidas` varchar(15) NOT NULL,
  `PK_fk_numlocal_salidas` int(5) NOT NULL,
  `PK_fk_id_jefebodega_salidas` int(5) NOT NULL,
  `Cantidad_salidas_producto` int(5) NOT NULL,
  `Fecha_salidas` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `salidas_productos`
--

INSERT INTO `salidas_productos` (`id_salidas_producto`, `PK_fk_marcaproducto_salidas`, `PK_fk_numlocal_salidas`, `PK_fk_id_jefebodega_salidas`, `Cantidad_salidas_producto`, `Fecha_salidas`) VALUES
(1, 'adidas11', 1, 1, 10, '2023-08-01 14:30:00'),
(2, 'adidas3', 2, 2, 8, '2023-08-02 15:45:00'),
(3, 'fila', 3, 3, 15, '2023-08-03 12:15:00'),
(4, 'fila10', 4, 4, 12, '2023-08-04 10:00:00'),
(5, 'jordan7', 5, 5, 9, '2023-08-05 11:30:00'),
(6, 'new balance14', 1, 1, 7, '2023-08-06 13:45:00'),
(7, 'new balance2', 2, 2, 11, '2023-08-07 14:30:00'),
(8, 'nike1', 3, 3, 14, '2023-08-08 16:00:00'),
(9, 'nike12', 4, 4, 6, '2023-08-09 15:15:00'),
(10, 'nike6', 5, 5, 13, '2023-08-10 12:45:00'),
(11, 'puma13', 1, 1, 8, '2023-08-11 10:30:00'),
(12, 'puma4', 2, 2, 7, '2023-08-12 14:15:00'),
(13, 'puma5', 3, 3, 10, '2023-08-13 13:00:00'),
(14, 'rebook15', 4, 4, 9, '2023-08-14 15:30:00'),
(15, 'rebook9', 5, 5, 12, '2023-08-15 11:45:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `Id_usuario` int(10) NOT NULL,
  `PK_fk_tdoc` varchar(10) NOT NULL,
  `Primer_nombre` varchar(20) NOT NULL,
  `Segundo_nombre` varchar(20) NOT NULL,
  `Primer_apellido` varchar(20) NOT NULL,
  `Segundo_apellido` varchar(20) NOT NULL,
  `Telefono_contacto` int(10) NOT NULL,
  `Nombre_usuario` varchar(15) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Contraseña` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Id_usuario`, `PK_fk_tdoc`, `Primer_nombre`, `Segundo_nombre`, `Primer_apellido`, `Segundo_apellido`, `Telefono_contacto`, `Nombre_usuario`, `Email`, `Contraseña`) VALUES
(1, 'CC', 'Juan', 'Pablo', 'López', 'Gómez', 1234567890, 'juanito', 'juan@example.com', 'clave123'),
(2, 'TI', 'María', 'Alejandra', 'Rodríguez', 'Pérez', 2147483647, 'maria', 'maria@example.com', 'abc456'),
(3, 'CE', 'Andrés', 'Felipe', 'García', 'López', 2147483647, 'andres', 'andres@example.com', 'qwerty12'),
(4, 'NIT', 'Ana', 'Sofía', 'Hernández', 'Martínez', 1234567800, 'ana', 'ana@example.com', 'zxcv789'),
(5, 'PAS', 'Carlos', 'Alberto', 'Martínez', 'Ramírez', 2147483647, 'carlos', 'carlos@example.com', 'password1'),
(6, 'RC', 'Laura', 'Isabel', 'Vargas', 'Gutiérrez', 1112223330, 'laura', 'laura@example.com', 'secure123'),
(7, 'PE', 'Felipe', 'Andrés', 'Díaz', 'Sánchez', 2147483647, 'felipe', 'felipe@example.com', '12345abc'),
(8, 'MS', 'Elena', 'Victoria', 'Mendoza', 'Silva', 2147483647, 'elena', 'elena@example.com', 'pass1234'),
(9, 'DIMEX', 'Roberto', 'Carlos', 'Guzmán', 'Rojas', 1112233440, 'roberto', 'roberto@example.com', 'roberto12'),
(10, 'DNI', 'Julia', 'Margarita', 'Pérez', 'García', 2147483647, 'julia', 'julia@example.com', 'julia567'),
(11, 'SSN', 'Miguel', 'Ángel', 'López', 'Gómez', 2147483647, 'miguel', 'miguel@example.com', 'miguelpass'),
(12, 'CUIL', 'Luis', 'Fernando', 'Rodríguez', 'Martínez', 2147483647, 'luis', 'luis@example.com', 'luis789'),
(13, 'CPF', 'Ana', 'Paula', 'Silva', 'Ferreira', 2147483647, 'anap', 'anap@example.com', 'anapass'),
(14, 'CNH', 'Joaquín', 'Manuel', 'Martínez', 'Rojas', 2147483647, 'joaquin', 'joaquin@example.com', 'passjoaqui'),
(15, 'DNI', 'Valentina', 'Isabel', 'Pérez', 'López', 1112233440, 'valentina', 'valentina@example.com', 'valentina1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_roles`
--

CREATE TABLE `usuario_has_roles` (
  `Usuario_tdoc` varchar(20) NOT NULL,
  `Usuario_id` int(10) NOT NULL,
  `Usuario_rol` int(3) NOT NULL,
  `Estado_rol` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_has_roles`
--

INSERT INTO `usuario_has_roles` (`Usuario_tdoc`, `Usuario_id`, `Usuario_rol`, `Estado_rol`) VALUES
('CC', 1, 1, 1),
('CE', 3, 1, 1),
('CNH', 14, 1, 1),
('CPF', 13, 5, 1),
('CUIL', 12, 3, 1),
('DIMEX', 9, 1, 1),
('DNI', 10, 4, 1),
('DNI', 15, 3, 1),
('MS', 8, 5, 1),
('NIT', 4, 3, 1),
('PAS', 5, 2, 1),
('PE', 7, 3, 1),
('RC', 6, 4, 1),
('SSN', 11, 2, 1),
('TI', 2, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `validacion_documento`
--

CREATE TABLE `validacion_documento` (
  `Tdoc` varchar(20) NOT NULL,
  `Numero_documento` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `validacion_documento`
--

INSERT INTO `validacion_documento` (`Tdoc`, `Numero_documento`) VALUES
('CC', 123456789),
('CE', 543216789),
('CNH', 555444333),
('CPF', 333444555),
('CUIL', 888777666),
('DIMEX', 111223344),
('DNI', 111223344),
('DNII', 998877665),
('MS', 777888999),
('NIT', 12345678),
('PAS', 98765432),
('PE', 444555666),
('RC', 111222333),
('SSN', 554433221),
('TI', 987654321);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `Tdoc_vendedor` varchar(20) NOT NULL,
  `Id_vendedor` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`Tdoc_vendedor`, `Id_vendedor`) VALUES
('CC', 1),
('CE', 3),
('CNH', 14),
('CPF', 13),
('CUIL', 12),
('DIMEX', 9),
('DNI', 10),
('DNI', 15),
('MS', 8),
('NIT', 4),
('PAS', 5),
('PE', 7),
('RC', 6),
('SSN', 11),
('TI', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores_has_locales`
--

CREATE TABLE `vendedores_has_locales` (
  `Vendedor_id_vendedor` int(10) NOT NULL,
  `Local_num_local` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vendedores_has_locales`
--

INSERT INTO `vendedores_has_locales` (`Vendedor_id_vendedor`, `Local_num_local`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5),
(11, 4),
(12, 5),
(13, 1),
(14, 2),
(15, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `Id_venta` int(5) NOT NULL,
  `Pk_fk_idproductoventa` int(5) NOT NULL,
  `Pk_fk_numlocal` int(5) NOT NULL,
  `Fecha_venta` datetime NOT NULL,
  `Totalvalor_venta` bigint(10) NOT NULL,
  `Venta_idpedido` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`Id_venta`, `Pk_fk_idproductoventa`, `Pk_fk_numlocal`, `Fecha_venta`, `Totalvalor_venta`, `Venta_idpedido`) VALUES
(1, 1, 1, '2023-08-01 14:30:00', 500, 1),
(2, 2, 2, '2023-08-02 15:45:00', 800, 2),
(3, 3, 3, '2023-08-03 12:15:00', 350, 3),
(4, 4, 4, '2023-08-04 10:00:00', 600, 4),
(5, 5, 5, '2023-08-05 11:30:00', 450, 5),
(6, 1, 1, '2023-08-06 13:45:00', 700, 6),
(7, 2, 2, '2023-08-07 14:30:00', 300, 7),
(8, 3, 3, '2023-08-08 16:00:00', 550, 8),
(9, 4, 4, '2023-08-09 15:15:00', 900, 9),
(10, 5, 5, '2023-08-10 12:45:00', 400, 10),
(11, 1, 1, '2023-08-11 10:30:00', 750, 11),
(12, 2, 2, '2023-08-12 14:15:00', 550, 12),
(13, 3, 3, '2023-08-13 13:00:00', 650, 13),
(14, 4, 4, '2023-08-14 15:30:00', 400, 14),
(15, 5, 5, '2023-08-15 11:45:00', 700, 15);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  ADD PRIMARY KEY (`Id_bodega`),
  ADD KEY `PK_fk_marcaproducto_bode` (`PK_fk_marcaproducto_bode`);

--
-- Indices de la tabla `devoluciones_locales`
--
ALTER TABLE `devoluciones_locales`
  ADD PRIMARY KEY (`Id_devolucion`,`Pk_fk_numlocal`,`Pk_fk_producto`),
  ADD KEY `Pk_fk_numlocal` (`Pk_fk_numlocal`);

--
-- Indices de la tabla `entradas_productos`
--
ALTER TABLE `entradas_productos`
  ADD PRIMARY KEY (`id_entradas_producto`,`PK_fk_marcaproducto_entradas`,`PK_fk_idbodega_entradas`,`PK_fk_idproveedor_entradas`),
  ADD KEY `PK_fk_marcaproducto_entradas` (`PK_fk_marcaproducto_entradas`),
  ADD KEY `PK_fk_idbodega_entradas` (`PK_fk_idbodega_entradas`);

--
-- Indices de la tabla `envios`
--
ALTER TABLE `envios`
  ADD PRIMARY KEY (`Id_envio`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`Pk_fk_producto`);

--
-- Indices de la tabla `jefebodega_has_bodegas`
--
ALTER TABLE `jefebodega_has_bodegas`
  ADD PRIMARY KEY (`Jefebodega_id_jefebodega`,`Bodega_id_bodega`),
  ADD KEY `Bodega_id_bodega` (`Bodega_id_bodega`);

--
-- Indices de la tabla `jefe_bodega`
--
ALTER TABLE `jefe_bodega`
  ADD PRIMARY KEY (`Tdoc_jefebodega`,`Id_jefe_bodega`);

--
-- Indices de la tabla `jefe_principal`
--
ALTER TABLE `jefe_principal`
  ADD PRIMARY KEY (`Tdoc_jefeprincipal`,`Id_jefeprincipal`);

--
-- Indices de la tabla `locales`
--
ALTER TABLE `locales`
  ADD PRIMARY KEY (`Num_local`);

--
-- Indices de la tabla `marca_producto`
--
ALTER TABLE `marca_producto`
  ADD PRIMARY KEY (`Nom_marca_producto`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`Id_pedido`,`PK_fk_Idproducto_pedido`,`PK_fk_envio_pedido`),
  ADD KEY `PK_fk_envio_pedido` (`PK_fk_envio_pedido`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`PK_fk_marca_producto`,`Id_producto`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`Tdoc_proveedor`,`Id_proveedor`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Cod_rol`);

--
-- Indices de la tabla `salidas_productos`
--
ALTER TABLE `salidas_productos`
  ADD PRIMARY KEY (`id_salidas_producto`,`PK_fk_marcaproducto_salidas`,`PK_fk_numlocal_salidas`,`PK_fk_id_jefebodega_salidas`),
  ADD KEY `PK_fk_marcaproducto_salidas` (`PK_fk_marcaproducto_salidas`),
  ADD KEY `PK_fk_numlocal_salidas` (`PK_fk_numlocal_salidas`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`Id_usuario`,`PK_fk_tdoc`),
  ADD KEY `PK_fk_tdoc` (`PK_fk_tdoc`);

--
-- Indices de la tabla `usuario_has_roles`
--
ALTER TABLE `usuario_has_roles`
  ADD PRIMARY KEY (`Usuario_tdoc`,`Usuario_id`,`Usuario_rol`),
  ADD KEY `Usuario_rol` (`Usuario_rol`);

--
-- Indices de la tabla `validacion_documento`
--
ALTER TABLE `validacion_documento`
  ADD PRIMARY KEY (`Tdoc`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`Tdoc_vendedor`,`Id_vendedor`);

--
-- Indices de la tabla `vendedores_has_locales`
--
ALTER TABLE `vendedores_has_locales`
  ADD PRIMARY KEY (`Vendedor_id_vendedor`,`Local_num_local`),
  ADD KEY `Local_num_local` (`Local_num_local`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`Id_venta`,`Pk_fk_idproductoventa`,`Pk_fk_numlocal`),
  ADD KEY `Pk_fk_numlocal` (`Pk_fk_numlocal`),
  ADD KEY `Venta_idpedido` (`Venta_idpedido`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bodegas`
--
ALTER TABLE `bodegas`
  ADD CONSTRAINT `bodegas_ibfk_1` FOREIGN KEY (`PK_fk_marcaproducto_bode`) REFERENCES `marca_producto` (`Nom_marca_producto`);

--
-- Filtros para la tabla `devoluciones_locales`
--
ALTER TABLE `devoluciones_locales`
  ADD CONSTRAINT `devoluciones_locales_ibfk_1` FOREIGN KEY (`Pk_fk_numlocal`) REFERENCES `locales` (`Num_local`);

--
-- Filtros para la tabla `entradas_productos`
--
ALTER TABLE `entradas_productos`
  ADD CONSTRAINT `entradas_productos_ibfk_1` FOREIGN KEY (`PK_fk_marcaproducto_entradas`) REFERENCES `marca_producto` (`Nom_marca_producto`),
  ADD CONSTRAINT `entradas_productos_ibfk_2` FOREIGN KEY (`PK_fk_idbodega_entradas`) REFERENCES `bodegas` (`Id_bodega`);

--
-- Filtros para la tabla `jefebodega_has_bodegas`
--
ALTER TABLE `jefebodega_has_bodegas`
  ADD CONSTRAINT `jefebodega_has_bodegas_ibfk_1` FOREIGN KEY (`Bodega_id_bodega`) REFERENCES `bodegas` (`Id_bodega`);

--
-- Filtros para la tabla `jefe_bodega`
--
ALTER TABLE `jefe_bodega`
  ADD CONSTRAINT `jefe_bodega_ibfk_1` FOREIGN KEY (`Tdoc_jefebodega`,`Id_jefe_bodega`) REFERENCES `usuario` (`PK_fk_tdoc`, `Id_usuario`);

--
-- Filtros para la tabla `jefe_principal`
--
ALTER TABLE `jefe_principal`
  ADD CONSTRAINT `jefe_principal_ibfk_1` FOREIGN KEY (`Tdoc_jefeprincipal`,`Id_jefeprincipal`) REFERENCES `usuario` (`PK_fk_tdoc`, `Id_usuario`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`PK_fk_envio_pedido`) REFERENCES `envios` (`Id_envio`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`PK_fk_marca_producto`) REFERENCES `marca_producto` (`Nom_marca_producto`);

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`Tdoc_proveedor`,`Id_proveedor`) REFERENCES `usuario` (`PK_fk_tdoc`, `Id_usuario`);

--
-- Filtros para la tabla `salidas_productos`
--
ALTER TABLE `salidas_productos`
  ADD CONSTRAINT `salidas_productos_ibfk_1` FOREIGN KEY (`PK_fk_marcaproducto_salidas`) REFERENCES `marca_producto` (`Nom_marca_producto`),
  ADD CONSTRAINT `salidas_productos_ibfk_2` FOREIGN KEY (`PK_fk_numlocal_salidas`) REFERENCES `locales` (`Num_local`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`PK_fk_tdoc`) REFERENCES `validacion_documento` (`Tdoc`);

--
-- Filtros para la tabla `usuario_has_roles`
--
ALTER TABLE `usuario_has_roles`
  ADD CONSTRAINT `usuario_has_roles_ibfk_1` FOREIGN KEY (`Usuario_tdoc`,`Usuario_id`) REFERENCES `usuario` (`PK_fk_tdoc`, `Id_usuario`),
  ADD CONSTRAINT `usuario_has_roles_ibfk_2` FOREIGN KEY (`Usuario_rol`) REFERENCES `roles` (`Cod_rol`);

--
-- Filtros para la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD CONSTRAINT `vendedores_ibfk_1` FOREIGN KEY (`Tdoc_vendedor`,`Id_vendedor`) REFERENCES `usuario` (`PK_fk_tdoc`, `Id_usuario`);

--
-- Filtros para la tabla `vendedores_has_locales`
--
ALTER TABLE `vendedores_has_locales`
  ADD CONSTRAINT `vendedores_has_locales_ibfk_1` FOREIGN KEY (`Local_num_local`) REFERENCES `locales` (`Num_local`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`Pk_fk_numlocal`) REFERENCES `locales` (`Num_local`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`Venta_idpedido`) REFERENCES `pedidos` (`Id_pedido`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;




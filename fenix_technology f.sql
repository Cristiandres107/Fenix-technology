      -- Creación base de datos
CREATE DATABASE fenix_technology;

-- Seleccionamos la base de datos
USE fenix_technology;

-- Creación de las tablas

-- Tabla de validación del tipo documento de identidad del usuario
CREATE TABLE tipo_documento (
    Id_tdoc INT(5) NOT NULL PRIMARY KEY,
    Tdoc VARCHAR(30) NOT NULL
);

-- Tabla de los roles existentes dentro del aplicativo
CREATE TABLE rol (
    Cod_rol INT(3) NOT NULL PRIMARY KEY,
    Desc_rol VARCHAR(20) NOT NULL,
    Estado_rol BOOLEAN NOT NULL
);

-- Tabla principal del usuario
CREATE TABLE usuario (
    Id_usuario INT(10) NOT NULL,
    PK_fk_Id_tdoc INT(5) NOT NULL,
    Numero_documento INT(10) NOT NULL,
    Primer_nombre VARCHAR(20) NOT NULL, 
    Segundo_nombre VARCHAR(20),         
    Primer_apellido VARCHAR(20) NOT NULL, 
    Segundo_apellido VARCHAR(20),        
    Telefono_contacto INT(10) NOT NULL, 
    Email VARCHAR(50) NOT NULL,   
    Pk_fk_Id_Cod_rol INT(2) NOT NULL,       
    Clave VARCHAR(128) NOT NULL,
    Estado_usuario BOOLEAN NOT NULL,
    PRIMARY KEY(Id_usuario, PK_fk_Id_tdoc, Numero_documento, Pk_fk_Id_Cod_rol)      
) ENGINE=InnoDB DEFAULT CHARSET=LATIN1;


-- Tabla de los locales existentes
CREATE TABLE local (
    Num_local INT(5) NOT NULL,
    Centro_comercial VARCHAR(200) NOT NULL,
    PK_fk_Id_usuariovendedor INT(3) NOT NULL,
    PRIMARY KEY (Num_local, PK_fk_Id_usuariovendedor)     
);

-- Tabla de la relación entre los vendedores y los diferentes locales


-- Proceso del inventario
CREATE TABLE marca_producto (
    Id_marca_producto INT(5) NOT NULL PRIMARY KEY,
    Nom_marca_producto VARCHAR(20) NOT NULL,
    Estado_marca_producto BOOLEAN NOT NULL
);
-- Tabla de las bodegas existentes
CREATE TABLE bodega (
    Id_bodega INT(5) NOT NULL,
    PK_fk_Id_marca_producto INT (3) NOT NULL, 
    Ubicacion_bodega VARCHAR(70) NOT NULL,  
    PK_fk_Id_usuariobodeguero INT(3) NOT NULL,
    PRIMARY KEY (Id_bodega, PK_fk_Id_usuariobodeguero, PK_fk_Id_marca_producto )
);

-- Tabla de la relación entre los jefes de bodega  y las diferentes bodegas


CREATE TABLE producto (
    Id_producto INT(5)  NOT NULL,
    PK_fk_Id_marca_producto INT(5) NOT NULL,
    Modelo_producto VARCHAR(45) NOT NULL,
    Tipo_producto VARCHAR(45) NOT NULL,
    Color_producto VARCHAR(60) NOT NULL,
    Precio_producto BIGINT(10) NOT NULL,
    Talla_disponible_producto VARCHAR(10) NOT NULL,
    Cantidad_disponible_producto INT(6)  NOT NULL,
    CHECK (Cantidad_disponible_producto >= 0), -- Restricción para evitar cantidades negativas
    PRIMARY KEY (Id_producto, PK_fk_Id_marca_producto )
);


CREATE TABLE tipo_movimiento(
    Id_tp_movimiento INT(5) NOT NULL PRIMARY KEY,
    Descrip_tp_movimiento VARCHAR(45) NOT NULL  
    );

-- Proceso de Entradas al Inventario
CREATE TABLE reporte_entrada (
    Id_entrada INT(5) NOT NULL,
    Fecha_emision DATETIME NOT NULL,
    Pk_fk_Id_usuarioproveedor INT(5) NOT NULL,
    Descripcion_entrada VARCHAR(60) NOT NULL,
    PRIMARY KEY (Id_entrada, Pk_fk_Id_usuarioproveedor )
);

CREATE TABLE detalle_reporte_entrada(
    Id_Detalle_reporte_entrada INT(5) NOT NULL,
    PK_fk_Id_entrada INT(5) NOT NULL,
    PK_fk_Id_bodega_destino INT(5) NOT NULL,
    PK_fk_Id_producto INT(5) NOT NULL,
    Cantidad_total_entradas INT(5) NOT NULL,
    Valor_entradas BIGINT(5) NOT NULL,
    Subtotal_entradas BIGINT(5) NOT NULL,
    Primary key ( Id_Detalle_reporte_entrada, PK_fk_Id_entrada, PK_fk_Id_bodega_destino, PK_fk_Id_producto)
);

-- Proceso de Devoluciones de los locales
CREATE TABLE reporte_devolucion_local (
    Id_devolucion INT(5) NOT NULL ,
    Pk_fk_numlocal INT(5) NOT NULL,
    Fecha_devolucion DATETIME NOT NULL,
    Motivo_devolucion TEXT,
    PRIMARY KEY(Id_devolucion,PK_fk_numlocal)
);

CREATE TABLE detalle_devolucion_local (
    Id_detalle_devolucion INT(5) NOT NULL,
    PK_fk_Id_devolucion INT(5) NOT NULL,
    PK_fk_Id_bodega_destino INT(5) NOT NULL,
    PK_fk_Id_producto INT(5) NOT NULL,
    Cantidad_devuelta INT(5) NOT NULL,
    PRIMARY KEY(Id_detalle_devolucion,PK_fk_Id_devolucion, PK_fk_Id_producto, PK_fk_Id_bodega_destino)
);
-- Fin proceso devoluciones de bodega

-- Proceso de Pedidos
CREATE TABLE reporte_pedido (
    Id_pedido INT(5) NOT NULL,
    Pk_fk_numlocal INT(5) NOT NULL,
    Fecha_emision DATETIME NOT NULL,
    Nombre_cliente VARCHAR(10) NOT NULL,
    Apellido_cliente VARCHAR(10) NOT NULL,
    Telefono_cliente INT(10) NOT NULL,
    PRIMARY KEY(Id_pedido, Pk_fk_numlocal)
);

-- Proceso de Facturas de Pedido
    CREATE TABLE detalle_reporte_pedido (
        Id_detalle_pedido INT(5) NOT NULL,
        Pk_fk_id_pedido INT(5) NOT NULL,
        Metodo_pago VARCHAR(50) NOT NULL,
        Pk_fk_Idproducto INT(5) NOT NULL,
        Cantidad_producto INT(5) NOT NULL,
        Valor_producto BIGINT(10) NOT NULL,
        Total_pedido INT(10) NOT NULL,
        PRIMARY KEY (Id_detalle_pedido, Pk_fk_id_pedido, Pk_fk_Idproducto)
        
    );

CREATE TABLE envio (
    Id_envio INT(5) NOT NULL,
    Pk_fk_Id_pedido INT(5) NOT NULL,
    Tipo_envio VARCHAR(20) NOT NULL,
    Nom_transportadora VARCHAR(20) NOT NULL,
    Ciudad_envio VARCHAR(20) NOT NULL,
    Direccion_entrega VARCHAR(30) NOT NULL,
    Valor_envio int(20) NOT NULL, 
    Fecha_estimada_entrega_pedido DATE NOT NULL,
    PRIMARY KEY(Id_envio, Pk_fk_id_pedido)
);

-- Proceso de Movimientos de Inventario
CREATE TABLE movimiento_inventario (
    Id_movimiento INT(5) NOT NULL,
    PK_fk_Id_producto INT(5) NOT NULL,
    PK_fk_Id_tp_movimiento VARCHAR(20) NOT NULL,
    Fecha_movimiento DATETIME NOT NULL,
    PRIMARY KEY(Id_movimiento, PK_fk_Id_producto, PK_fk_Id_tp_movimiento)
);





-- Proceso de Salidas del Inventario

CREATE TABLE reporte_salida (
    Id_salida INT(5) NOT NULL,
    Fecha_emision DATETIME NOT NULL,
    PK_fk_numlocal_destino INT(5) NOT NULL, 
    Descripcion_salida VARCHAR(400) NOT NULL,
    PRIMARY KEY (Id_salida, PK_fk_numlocal_destino)
);

CREATE TABLE detalle_reporte_salida (
    Id_Detalle_reporte_salida INT(5) NOT NULL,
    PK_fk_Id_salida INT(5) NOT NULL,
    PK_fk_Id_bodega INT(5) NOT NULL,
    PK_fk_Id_producto INT(5) NOT NULL,
    Cantidad_total_salidas INT(5) NOT NULL,
    Primary key ( Id_Detalle_reporte_salida, PK_fk_Id_salida, PK_fk_Id_bodega, PK_fk_Id_producto)
);


-- Fin creación de las tablas

-- Relaciones de las tablas
ALTER TABLE usuario
ADD FOREIGN KEY (PK_fk_Id_tdoc)
REFERENCES tipo_documento(Id_tdoc); 

-- Relaciones entre la tabla usuario y rol 

ALTER TABLE usuario 
ADD FOREIGN KEY (Pk_fk_Id_Cod_rol)
REFERENCES rol(Cod_rol);

 -- Fin relaciones entre la tabla usuario y rol
 

ALTER TABLE local
ADD FOREIGN KEY (PK_fk_Id_usuariovendedor)
REFERENCES usuario(Id_usuario);


ALTER TABLE bodega
ADD FOREIGN KEY (PK_fk_Id_usuariobodeguero)
REFERENCES usuario(Id_usuario);


-- Proceso inventario

ALTER TABLE producto
ADD FOREIGN KEY (PK_fk_Id_marca_producto)
REFERENCES marca_producto(Id_marca_producto);

ALTER TABLE bodega
ADD FOREIGN KEY (Id_bodega)
REFERENCES marca_producto(Id_marca_producto);

-- Fin proceso de inventario

-- Proceso de pedidos
ALTER TABLE reporte_pedido
ADD FOREIGN KEY (Pk_fk_numlocal)
REFERENCES local(Num_local);

ALTER TABLE envio
ADD FOREIGN KEY (Pk_fk_Id_pedido)
REFERENCES reporte_pedido(Id_pedido);

ALTER TABLE detalle_reporte_pedido
ADD FOREIGN KEY (Pk_fk_Id_pedido) 
REFERENCES reporte_pedido(Id_pedido);

ALTER TABLE detalle_reporte_pedido
ADD FOREIGN KEY (PK_fk_Idproducto) 
REFERENCES producto(Id_producto);
-- Fin proceso de pedidos

-- Proceso devolución  
ALTER TABLE reporte_devolucion_local
ADD FOREIGN KEY (Pk_fk_numlocal)
REFERENCES local(Num_local);

ALTER TABLE detalle_devolucion_local
ADD FOREIGN KEY (PK_fk_Id_devolucion) 
REFERENCES reporte_devolucion_local(Id_devolucion);
    
ALTER TABLE detalle_devolucion_local    
ADD FOREIGN KEY (PK_fk_Id_bodega_destino) 
REFERENCES bodega(Id_bodega);

ALTER TABLE detalle_devolucion_local    
ADD FOREIGN KEY (PK_fk_Id_producto) 
REFERENCES producto(Id_producto);


ALTER TABLE movimiento_inventario
ADD FOREIGN KEY (PK_fk_Id_producto) 
REFERENCES producto(Id_producto);

ALTER TABLE movimiento_inventario
ADD FOREIGN KEY (PK_fk_Id_tp_movimiento)
REFERENCES tipo_movimiento(Id_tp_movimiento);

ALTER TABLE movimiento_inventario
ADD FOREIGN KEY (Id_movimiento) 
REFERENCES reporte_entrada(Id_entrada);

ALTER TABLE movimiento_inventario
ADD FOREIGN KEY (Id_movimiento) 
REFERENCES reporte_salida(Id_salida);

ALTER TABLE movimiento_inventario
ADD FOREIGN KEY (Id_movimiento) 
REFERENCES reporte_devolucion_local(Id_devolucion);

-- Fin proceso devolución

-- Proceso entrada inventario
ALTER TABLE reporte_entrada
ADD FOREIGN KEY (Pk_fk_Id_usuarioproveedor)
REFERENCES usuario(Id_usuario);

ALTER TABLE detalle_reporte_entrada
ADD FOREIGN KEY (PK_fk_Id_entrada) 
REFERENCES reporte_entrada(Id_entrada);

ALTER TABLE detalle_reporte_entrada
ADD FOREIGN KEY (PK_fk_Id_bodega_destino) 
REFERENCES bodega(Id_bodega);


ALTER TABLE detalle_reporte_entrada
ADD FOREIGN KEY (PK_fk_Id_producto) 
REFERENCES producto(Id_producto);

-- Fin Proceso entrada inventario

-- Proceso salida inventario
ALTER TABLE reporte_salida
ADD FOREIGN KEY (PK_fk_numlocal_destino)
REFERENCES local(Num_local);

ALTER TABLE detalle_reporte_salida
ADD FOREIGN KEY (PK_fk_Id_salida) 
REFERENCES reporte_salida(Id_salida);

ALTER TABLE detalle_reporte_salida
ADD FOREIGN KEY (PK_fk_Id_bodega) 
REFERENCES bodega(Id_bodega);

ALTER TABLE detalle_reporte_salida
ADD FOREIGN KEY (PK_fk_Id_producto) 
REFERENCES producto(Id_producto);
-- Fin proceso salida inventario



-- Insertar datos en la tabla "tipo de documento"

INSERT INTO tipo_documento (Id_tdoc, Tdoc)VALUES
(01, 'Cédula de Ciudadanía'),
(02, 'Tarjeta de Identidad'),
(03, 'Cédula de Extranjería');

--  Insertar datos  en la tabla "rol"
INSERT INTO rol (Cod_rol, Desc_rol, Estado_rol) VALUES
(01, 'jefe principal', 1),
(02, 'jefe de bodega', 1),
(03, 'vendedor', 1),
(04, 'proveedor', 1);
-- Insertar datos en la tabla "usuario"

INSERT INTO usuario (Id_usuario, PK_fk_Id_tdoc, Numero_documento, Primer_nombre, Segundo_nombre, Primer_apellido, Segundo_apellido, Telefono_contacto, Email, PK_fk_Id_Cod_rol, Clave, Estado_usuario) VALUES
(1, 01, 1234567890, 'Camilo', 'Alejandro', 'Cami', 'Cami', 1234567890,'usuario1@gmail.com', 01,  AES_ENCRYPT('cami123', 'aes'), 1),
(2, 02, 9876543210, 'Juan', 'Carlos', 'Pérez', 'Gómez', 9876543210, 'usuario2@gmail.com', 02,  AES_ENCRYPT('juanito', 'aes'), 1),
(3, 03, 1022548720, 'María', 'Isabel', 'López', 'Hernández', 3225486412, 'usuario3@gmail.com', 02,  AES_ENCRYPT('mariia', 'aes'), 1),
(4, 01, 1253045504, 'Luis', 'Alberto', 'Martínez', 'González', 4568963254, 'usuario4@gmail.com', 02,  AES_ENCRYPT('luisito123', 'aes'), 1),
(5, 02, 5679807561, 'Ana', 'Lucía', 'Torres', 'Pérez', 8456325488, 'usuario5@gmail.com',  02,  AES_ENCRYPT('anita1', 'aes'), 1),
(6, 03, 8630246544, 'Carlos', 'Fernando', 'Sánchez', 'Rodríguez', 3542542365, 'usuario6@gmail.com', 02,  AES_ENCRYPT('carlitos2', 'aes'), 1),
(7, 01, 7485214601, 'Laura', 'Patricia', 'Ramírez', 'Gómez', 3253246895, 'usuario7@gmail.com', 03, AES_ENCRYPT('laurita3', 'aes'), 1),
(8, 02, 7589632541, 'Roberto', 'Andrés', 'González', 'López', 2142352641, 'usuario8@gmail.com', 03,  AES_ENCRYPT('roberts', 'aes'), 1),
(9, 03, 7452894201, 'Elena', 'Carmen', 'Hernández', 'Pérez', 5236524125, 'usuario9@gmail.com', 03,  AES_ENCRYPT('elenita', 'aes'), 1),
(10, 01, 1242153781, 'Pedro', 'José', 'Díaz', 'Martínez', 3232584123, 'usuario10@gmail.com', 03,  AES_ENCRYPT('pedrito', 'aes'), 1),
(11, 02, 1012741001, 'Sofía', 'Isabel', 'Pérez', 'López', 3256325412, 'usuario11@gmail.com', 03, AES_ENCRYPT('sofi11', 'aes'), 1),
(12, 03, 1014521014, 'Felipe', 'Andrés', 'Gómez', 'Sánchez', 1232145258, 'usuario12@gmail.com', 04,  AES_ENCRYPT('felipee', 'aes'), 1),
(13, 01, 4152421532, 'Isabella', 'Mariana', 'Rodríguez', 'Gómez', 4526521452, 'usuario13@gmail.com', 04, AES_ENCRYPT('isabella', 'aes'), 1),
(14, 02, 1256324015, 'Miguel', 'Ángel', 'González', 'López', 1245698754, 'usuario14@gmail.com', 04,  AES_ENCRYPT('meguelito', 'aes'), 1),
(15, 03, 7485654215, 'Javier', 'Andrés', 'Hernández', 'Pérez', 3215245698, 'usuario15@gmail.com', 04,  AES_ENCRYPT('javiersito', 'aes'), 1);



-- Insertar datos en la tabla "local"
INSERT INTO local (Num_local, Centro_comercial, PK_fk_Id_usuariovendedor)VALUES
(1, 'centro comercial plaza españa', 03),
(156, 'centro comercial plaza españa', 03),
(155,  'centro comercial plaza españa', 03), 
(190, 'centro comercial plaza españa', 03),
(21, 'centro comercial luxury', 03),
(54, 'centro comercial luxury', 03);

-- Insertar datos en la tabla "marca_producto"
INSERT INTO marca_producto (Id_marca_producto, Nom_marca_producto, Estado_marca_producto)VALUES
(001, 'ADIDAS', 1),
(002, 'FILA', 1),
(003, 'JORDAN', 1),
(004, 'NIKE', 1),
(005, 'PUMA', 1),
(006, 'REBOOK', 1);
-- Insertar datos en la tabla "bodega"
INSERT INTO bodega (Id_bodega, PK_fk_Id_marca_producto, 	Ubicacion_bodega, PK_fk_Id_usuariobodeguero) VALUES
(1, 001, 'Bodega 1 primer pasillo local 1', 02),
(2, 002, 'Bodega 2 encima del local 156', 02),
(3, 003, 'Bodega 3 encima del local 155', 02),
(4, 004, 'Bodega 4 encima del local 190', 02),
(5, 005, 'Bodega 5 encima del local 21', 02),
(6, 006, 'Bodega 6 encima del local 54', 02);

-- Insertar datos en la tabla "producto"
INSERT INTO producto (Id_producto, PK_fk_Id_marca_producto, Modelo_producto, Tipo_producto, Color_producto, Precio_producto, Talla_disponible_producto, Cantidad_disponible_producto)VALUES
(1, 001, ' adidas beyaz erkek spr ayakkab', 'deportiva', 'blanco con azul', '500000', '40-44', '500' ),
(2, 002, 'ARCADE LOW', 'clasica' , 'blanco',  '430000', '32-37', '1000' ),
(3, 003, 'Air Jordan ', 'juvenil',  'gris con tono blanco y negro',  '300250', '40-44', '200'),
(4, 004, 'Dunk Low', 'juvenil', 'azul con blanco', '140000', '37-42', '450'),
(5, 005, 'suede classic', 'deportiva', 'azul oscuro', '150000', '35-40', '100'),
(6, 006, ' vector smash', 'clasicas', 'negro con blanco', '525000','36-39', '400' );
-- Insertar datos en la tabla "tipo_movimiento"
INSERT INTO tipo_movimiento(Id_tp_movimiento, Descrip_tp_movimiento)VALUES
(1, 'entradas '),
(2, 'salidas'),
(3, 'devoluciones');

-- Insertar datos en la tabla "reporte_entrada"
INSERT INTO reporte_entrada (Id_entrada, Fecha_emision, PK_fk_Id_usuarioproveedor, Descripcion_entrada)
VALUES
(1,  '2021-09-14 12:35:00', 04, 'entrada exitosa a la bodega de plaza españa'),
(2, '2022-09-14 12:35:00', 04, 'entrada exitosa a la bodega de plaza españa'),
(3,  '2023-05-14 12:35:00', 04, 'entrada exitosa a la bodega de plaza españa'),
(4,  '2020-11-14 12:35:00', 04, 'entrada exitosa a la bodega de plaza españa'),
(5,  '2023-11-14 12:35:00', 04, 'entrada exitosa a la bodega de plaza luxury'),
(6, '2022-02-14 12:35:00', 04, 'entrada exitosa a la bodega de plaza luxury');

-- Insertar datos en la tabla "detalle_reporte_entrada"
INSERT INTO  detalle_reporte_entrada (Id_Detalle_reporte_entrada, PK_fk_Id_entrada, PK_fk_Id_bodega_destino, PK_fk_Id_producto, Cantidad_total_entradas, Valor_entradas, Subtotal_entradas)VALUES
(11, 1, 1, 1, 5, 500000, 2500000),
(22, 2, 2, 2, 10, 300000, 3000000),
(33, 3, 3, 3, 3, 700000, 2100000),
(44, 4, 4, 4, 8, 500000, 4000000),
(55, 5, 5, 5, 12, 1000000, 12000000),
(66, 6, 6, 6, 11, 300000, 3300000 );

-- Insertar datos en la tabla "reporte_devolucion_local"
INSERT INTO reporte_devolucion_local (Id_devolucion, Pk_fk_numlocal, Fecha_devolucion, Motivo_devolucion) VALUES
(1, 1, '2020-09-12 08:30:00', 'producto defectuoso'),
(2, 156, '2021-10-25 14:15:00', 'producto equivocado'),
(3, 155, '2022-07-04 16:45:00', 'producto defectuoso'),
(4, 190, '2020-08-02 10:00:00', 'tallas incorrectas'),
(5, 21, '2021-01-25 13:20:00', 'compra equivocada'),
(6, 54, '2020-06-17 09:55:00', 'compra equivocada'),
(7, 1, '2020-03-01 11:10:00', 'producto defectuoso'),
(8, 156, '2023-12-12 20:45:00', 'tallas incorrectas'),
(9, 155, '2021-02-15 18:30:00', 'producto equivocado'),
(10, 190, '2023-04-18 19:05:00', 'compra equivocada'),
(11, 21, '2020-10-25 15:40:00', 'marcas incorrectas'),
(12, 54, '2022-04-30 12:25:00', 'producto defectuoso');


-- Insertar datos en la tabla "detalle_devolucion_local"
INSERT INTO detalle_devolucion_local (Id_detalle_devolucion, PK_fk_Id_devolucion, PK_fk_Id_bodega_destino, PK_fk_Id_producto, Cantidad_devuelta )VALUES 
(001, 1, 1, 1, 150),
(002, 2, 2, 2, 50),
(003, 3, 3, 3, 15),
(004, 4, 4, 4, 20),
(005, 5, 5, 5, 15),
(006, 6, 6, 6, 40),
(007, 7, 1, 1, 55),
(008, 8, 2, 2, 47),
(009, 9, 3, 3, 23),
(0010, 10, 4, 4, 5),
(0011, 11, 5, 5, 14),
(0012, 12, 6, 6, 65);


-- Insertar datos en la tabla "reporte_pedido"
INSERT INTO reporte_pedido (Id_pedido, Pk_fk_numlocal,  Fecha_emision, Nombre_cliente, Apellido_cliente, Telefono_cliente) VALUES
(1, 1, '2022-04-20 04:40:23', 'carlos', 'perez', '3223345654'),
(2, 156, '2021-09-13 12:30:48', 'sara', 'diaz', '2352415201'),
(03, 155, '2021-09-24 03:25:55', 'juan', 'herrera', '3547854214'),
(4, 190, '2022-12-20 15:25:42', 'cristian', 'castellanos', '2578945632'),
(5, 21, '2023-01-01 12:30:00', 'maria', 'uribe', '2579846215'),
(6, 54, '2023-03-01 13:30:14', 'paola', 'tovar', '4862153015'),
(7, 1, '2022-03-13 14:20:00', 'camilo', 'diaz',  '1459786245'),
(8, 156,  '2022-11-01 15:32:42', 'marta', 'alvis',  '1593574862'),
(9, 155,'2022-12-01 08:25:00',  'luis', 'ortiz', '3579512864'),
(10, 190,'2023-11-30 10:05:00',  'nicol', 'rodriguez', '4862357418'),
(11, 21, '2023-05-01 09:30:45', 'amparo', 'grisales', '7538624910'),
(012, 54, '2022-12-31 13:30:00',  'tony', 'hernandez', '4896520148');
-- Insertar datos en la tabla "envio"
INSERT INTO envio (Id_envio, Pk_fk_Id_pedido, Tipo_envio, Nom_transportadora, Ciudad_envio, Direccion_entrega, Valor_envio, Fecha_estimada_entrega_pedido)VALUES
(1, 1, 'nacional', 'americans transport', 'bogota', 'Calle 9 # 9. 62, Leticia, Barrio Centro', '300000', '2023-10-20'),
(2, 2, 'nacional', 'multientrega', 'bogota', 'Calle 19 # 80A-40. Barrio Belén', '700000',  '2020-08-30'),
(3, 3, 'nacional', 'entregaflash', 'bogota', 'Calle 100 # 11B-27', '700000',  '2023-12-31' ),
(4, 4, 'nacional', 'americans transport',  'bogota', 'Calle 7 # 19-35', '300000', '2023-12-07' ),
(5, 5, 'nacional', 'multientrega', 'bogota',  'Calle 10 # 8-07', '300000',  '2023-01-25' ),
(6, 6, 'nacional', 'entregaflash', 'bogota', 'Avenida 1 # 28-57', '700000',  '2023-04-01' ),
(7, 7, 'nacional', 'americans transport', 'bogota','Carrera 11 # 41-13', '700000',  '2023-11-07'),
(8, 8, 'nacional', 'multientrega', 'bogota', 'Avenida 3 norte # 50N-20 ', '350000', '2023-11-01'),
(9, 9,'nacional', 'entregaflash', 'bogota', 'CL 143 B 146 A 21', '700000',  '2023-09-15'),
(10, 10, 'internacional','americans transport', 'bogota', 'CL 86 B 99 62 IN 101', '300000',  '2023-10-25'),
(11, 11, 'internacional', 'multientrega', 'bogota', 'CLL. 4 SUR NO.15A-13', '700000',  '2023-11-30'),
(12, 12, 'nacional', 'entregaflash',  'bogota', 'CR. 105C NO.16F-24', '300000', '2023-10-20' );

-- Insertar datos en la tabla "movimiento_inventario"
INSERT INTO  movimiento_inventario ( Id_movimiento, PK_fk_Id_producto, PK_fk_Id_tp_movimiento, Fecha_movimiento)VALUES
(1, 1, 1, '2022-04-05 12:45:20'),
(2, 2, 2, '2021-06-25 12:03:40'),
(3, 3, 3, '2023-12-30 12:41:08' ),
(4, 4, 1,'2023-01-03 12:21:20'),
(5, 5, 2,'2021-04-15 12:20:30' ),
(6, 6, 3,'2022-10-30 12:15:10');


-- Insertar datos en la tabla reporte_salida
INSERT INTO reporte_salida (Id_salida, Fecha_emision, PK_fk_numlocal_destino, Descripcion_salida)
VALUES
(1, '2021-12-14 12:35:00', 1, 'salida exitosa al centro comercial plaza españa local 1'),
(2, '2023-03-20 13:54:00', 156, 'salida exitosa al centro comercial plaza españa local 156'),
(3, '2020-02-03 15:15:00', 155, 'salida exitosa al centro comercial plaza españa local 155'),
(4, '2022-09-17 08:00:00', 190, 'salida exitosa al centro comercial plaza españa local 190'),
(5, '2023-05-12 12:35:00', 21, 'salida exitosa al centro comercial luxury 1 local 21'),
(6, '2021-04-23 13:25:00', 54, 'salida exitosa centro comercial luxury 2 local 54');


-- Insertar datos en la tabla "detalle_reporte_salida"
INSERT INTO  detalle_reporte_salida ( Id_Detalle_reporte_salida, PK_fk_Id_salida, PK_fk_Id_bodega, PK_fk_Id_producto, Cantidad_total_salidas)VALUES
(011, 1, 1,  1, 4 ),
(022, 2, 2,  2, 10),
(033, 3, 3, 3, 1),
(044, 4, 4, 4, 5 ),
(055, 5, 5, 5, 8),
(066, 6, 6, 6, 2);

-- Insertar datos en la tabla "detalle_reporte_pedido"
INSERT INTO detalle_reporte_pedido (Id_detalle_pedido, Pk_fk_Id_pedido, Metodo_pago, Pk_fk_Idproducto, Cantidad_producto,  Valor_producto, Total_pedido)VALUES
(1, 01,'transferencia bancaria', 1, 500, 300000, 150000000 ),
(2, 02,'efectivo', 2, 300, 250000, 75000000 ),
(3, 03, 'efectivo', 3, 300, 140000, 42000000),
(4, 04, 'transferencia bancaria ', 4, 600,  200000, 120000000),
(5, 05, 'transferencia bancaria', 5, 1000, 240000, 240000000),
(6, 06, 'efectivo', 6, 100, 95000, 9500000),
(7, 07, 'transferencia bancaria', 1, 200, 320000, 64000000),
(8, 08, 'efectivo', 2, 50, 85000, 4250000 ),
(9, 09, 'efectivo ', 3, 200, 242000, 48400000 ),
(10, 010, 'transferencia bancaria', 4, 400, 190000, 76000000),
(11, 011, 'transferencia bancaria ', 5, 700, 140000, 98000000),
(12, 012, 'efectivo', 6, 1000, 150000,  150000);
-- fin de la insercion de datos


-- Consulta No.1 Listar las zapatillas en inventario, incluyendo su marca y bodega de almacenamiento: 

SELECT p.Modelo_producto AS Zapatilla,p.Tipo_producto AS Tipo_zapatilla, p.Color_producto AS Color, p.Precio_producto AS Precio, m.Nom_marca_producto AS Marca,p.Talla_disponible_producto AS Tallas_disponibles,p.Cantidad_disponible_producto AS Cantidad_disponible, b.Ubicacion_bodega AS Bodega FROM producto p INNER JOIN producto_has_bodega AS prb ON p.Id_producto = prb.PK_fk_Id_producto INNER JOIN bodega AS b ON b.Id_bodega = prb.PK_fk_Id_bodega INNER JOIN bodega_has_marca_producto AS bm ON bm.PK_fk_Id_bodega = b.Id_bodega INNER JOIN marca_producto AS m ON m.Id_marca_producto = bm.PK_fk_Id_marca_producto;

-- Consulta No.2 Calcular el valor total del inventario de zapatillas en cada bodega: 

SELECT b.Ubicacion_bodega AS Bodega,m.Nom_marca_producto AS Marca ,p.Cantidad_disponible_producto AS Cantidad_disponible,p.Talla_disponible_producto AS Tallas_disponibles, SUM(p.Precio_producto * p.Cantidad_disponible_producto) AS Valor_Inventario FROM producto p INNER JOIN producto_has_bodega prb ON prb.PK_fk_Id_producto = p.Id_producto INNER JOIN bodega b ON b.Id_bodega = prb.PK_fk_Id_bodega INNER JOIN bodega_has_marca_producto bm ON bm.PK_fk_Id_bodega = b.Id_bodega INNER JOIN marca_producto m ON m.Id_marca_producto = bm.PK_fk_Id_marca_producto GROUP BY b.Ubicacion_bodega;

-- Consulta No.3 Encontrar las zapatillas que han tenido movimientos de inventario en los últimos 30 días, incluyendo detalles de los movimientos:

SELECT p.Modelo_producto AS Zapatilla, p.Color_producto AS Color, tm.Descrip_tp_movimiento AS Tipo_movimiento, mi.Fecha_movimiento AS Fecha, p.Cantidad_disponible_producto AS Cantidad FROM producto p INNER JOIN movimiento_inventario mi ON p.Id_producto = mi.PK_fk_Id_producto INNER JOIN tipo_movimiento tm ON tm.Id_tp_movimiento = mi.PK_fk_Id_tmovimiento WHERE mi.Fecha_movimiento >= NOW() - INTERVAL 30 DAY;

-- Consulta No.4 Mostrar detalladamente las devoluciones de cada uno de los locales:

SELECT rd.Id_devolucion,l.Num_local, l.Centro_comercial, rd.Fecha_devolucion, rd.Motivo_devolucion, dd.Id_detalle_devolucion, p.Modelo_producto, p.Color_producto, dd.Cantidad_devuelta FROM reporte_has_devolucion_local rd JOIN local l ON rd.Pk_fk_numlocal = l.Num_local JOIN detalle_devolucion_local dd ON rd.Id_devolucion = dd.PK_fk_Id_devolucion JOIN producto p ON dd.PK_fk_Id_producto = p.Id_producto;

-- Consulta No.5 Listar las zapatillas por su tipo, modelo y respectivo precio:

SELECT DISTINCT p.Tipo_producto, p.Modelo_producto, p.Precio_producto FROM producto p WHERE (p.Tipo_producto, p.Precio_producto) IN ( SELECT Tipo_producto, MAX(p.Precio_producto) AS Max_Precio FROM producto GROUP BY Tipo_producto);

-- Consulta No.6 Listar las zapatillas que tienen menos de 500 unidades disponibles en todas las bodegas:

SELECT p.Modelo_producto AS Zapatilla, p.Color_producto AS Color, p.Cantidad_disponible_producto AS Cantidad_Disponible FROM producto p GROUP BY p.Modelo_producto, p.Color_producto HAVING SUM(p.Cantidad_disponible_producto) < 500;

-- Consulta No.7 Encontrar las bodegas que han tenido salidas de inventario en el último trimestre, incluyendo el total de salidas y el nombre del vendedor asociado:

SELECT l.Num_local AS Local, CONCAT(u.Primer_nombre, ' ', u.Primer_apellido) AS Vendedor, rs.Fecha_emision AS Fecha_Hora, rs.Id_salida AS ID_Salida, b.Ubicacion_bodega AS Bodega, ds.Cantidad_total_salidas AS Cantidad_Total_Productos FROM local l INNER JOIN vendedor_has_local AS vl ON l.Num_local = vl.Local_num_local INNER JOIN vendedor AS v ON vl.Vendedor_id_vendedor = v.Id_vendedor INNER JOIN usuario u ON v.Id_vendedor = u.Id_usuario INNER JOIN reporte_has_salida AS rs ON l.Num_local = rs.PK_fk_numlocal_destino INNER JOIN detalle_reporte_salida AS ds ON rs.Id_salida = ds.PK_fk_Id_salida INNER JOIN bodega AS b ON ds.PK_fk_Id_bodega = b.Id_bodega WHERE rs.Fecha_emision <= DATE_SUB(NOW(), INTERVAL 1 WEEK) GROUP BY Local, Vendedor, Fecha_Hora, ID_Salida, Bodega;

-- Consulta No.8 Encontrar la marca de zapatillas más vendida en un período de tiempo

SELECT mp.Nom_marca_producto, SUM(drp.Cantidad_producto) AS Cantidad_Total_Vendida FROM producto p INNER JOIN detalle_reporte_pedido drp ON p.Id_producto = drp.Pk_fk_Idproducto INNER JOIN reporte_pedido rp ON rp.Id_pedido = drp.Pk_fk_id_pedido INNER JOIN producto_has_bodega pb ON pb.PK_fk_Id_producto = p.Id_producto INNER JOIN bodega b ON b.Id_bodega = pb.PK_fk_Id_bodega INNER JOIN bodega_has_marca_producto bm ON bm.PK_fk_Id_bodega = b.Id_bodega INNER JOIN marca_producto mp ON mp.Id_marca_producto = bm.PK_fk_Id_marca_producto WHERE rp.Fecha_emision BETWEEN '2021-09-13 ' AND '2023-11-30' GROUP BY mp.Nom_marca_producto ORDER BY Cantidad_Total_Vendida DESC;

-- Consulta No.9 Encontrar las bodegas que han tenido entradas de inventario de un proveedor específico en el último año, incluyendo detalles de las entradas:

SELECT b.Ubicacion_bodega AS Bodega, re.Fecha_emision AS Fecha_Entrada, 
       p.Modelo_producto AS Zapatilla, p.Color_producto AS Color,
       CONCAT(u.Primer_nombre, ' ', u.Segundo_nombre) AS proveedor, 
       de.Cantidad_total_entradas AS Cantidad_Entrada
FROM bodega b
INNER JOIN detalle_reporte_entrada de ON b.Id_bodega = de.PK_fk_Id_bodega_destino
INNER JOIN reporte_has_entrada re ON re.Id_entrada = de.PK_fk_Id_entrada
INNER JOIN producto p ON de.PK_fk_Id_producto = p.Id_producto
INNER JOIN proveedor pr ON pr.Id_proveedor = re.Id_proveedor_entrada
INNER JOIN usuario u ON u.Id_usuario = pr.Id_proveedor
WHERE re.Fecha_emision <= NOW() - INTERVAL 1 YEAR;

-- Consulta No.10 Encontrar los vendedores que más han vendido zapatillas en la última semana.

SELECT CONCAT(u.Primer_nombre, ' ', u.Primer_apellido) AS Vendedor,
       SUM(drp.Cantidad_producto) AS Cantidad_Total_Vendida
FROM usuario u
INNER JOIN vendedor v ON u.Id_usuario = v.Id_vendedor
INNER JOIN vendedor_has_local vl ON v.Id_vendedor = vl.Vendedor_id_vendedor
INNER JOIN local l ON vl.Local_num_local = l.Num_local
INNER JOIN reporte_pedido rp ON l.Num_local = rp.Pk_fk_numlocal
INNER JOIN detalle_reporte_pedido drp ON rp.Id_pedido = drp.Pk_fk_id_pedido
INNER JOIN producto p ON drp.PK_fk_Idproducto = p.Id_producto
WHERE rp.Fecha_emision <= NOW() - INTERVAL 1 WEEK
GROUP BY Vendedor
ORDER BY Cantidad_Total_Vendida DESC;

-- Consulta No.11 Encontrar la marca de zapatillas con el precio promedio más alto en un rango de fechas específico.
SELECT mp.Nom_marca_producto,rp.PK_fk_numlocal, rp.Fecha_emision , drp.Cantidad_producto , AVG(p.Precio_producto) AS PrecioPromedio FROM producto p INNER JOIN producto_has_bodega pb ON pb.PK_fk_Id_producto = p.Id_producto INNER JOIN bodega b ON b.Id_bodega = pb.PK_fk_Id_bodega INNER JOIN bodega_has_marca_producto bm ON bm.PK_fk_Id_bodega = b.Id_bodega INNER JOIN marca_producto mp ON mp.Id_marca_producto = bm.PK_fk_Id_marca_producto INNER JOIN detalle_reporte_pedido drp ON p.Id_producto = drp.PK_fk_Idproducto INNER JOIN reporte_pedido rp ON drp.Pk_fk_id_pedido = rp.Id_pedido WHERE rp.Fecha_emision BETWEEN '2021-09-13' AND '2023-09-30' GROUP BY mp.Nom_marca_producto ORDER BY PrecioPromedio DESC;


-- Consulta No.12 Encontrar el vendedor que más ha vendido zapatillas de una marca específica en el último mes.

SELECT CONCAT(u.Primer_nombre, ' ', u.Primer_apellido) AS Vendedor,L.Num_local, SUM(drp.Cantidad_producto) AS Cantidad_Total_Vendida FROM usuario u INNER JOIN vendedor v ON u.Id_usuario = v.Id_vendedor INNER JOIN vendedor_has_local vl ON v.Id_vendedor = vl.Vendedor_id_vendedor INNER JOIN local l ON vl.Local_num_local = l.Num_local INNER JOIN reporte_pedido rp ON l.Num_local = rp.Pk_fk_numlocal INNER JOIN detalle_reporte_pedido drp ON rp.Id_pedido = drp.Pk_fk_id_pedido INNER JOIN producto p ON drp.PK_fk_Idproducto = p.Id_producto INNER JOIN producto_has_bodega pb ON p.Id_producto = pb.PK_fk_Id_producto INNER JOIN bodega_has_marca_producto bm ON pb.PK_fk_Id_bodega = bm.PK_fk_Id_bodega INNER JOIN marca_producto mp ON bm.PK_fk_Id_marca_producto = mp.Id_marca_producto WHERE mp.Nom_marca_producto = 'ADIDAS' AND rp.Fecha_emision <= NOW() - INTERVAL 1 MONTH GROUP BY Vendedor ORDER BY Cantidad_Total_Vendida DESC;

-- Consulta No.13 Listar las zapatillas que menos sean vendido de todo el invetario
SELECT p.Modelo_producto AS Zapatilla, p.Color_producto AS Color, SUM(IFNULL(drp.Cantidad_producto, 0)) AS Total_Vendido FROM producto p LEFT JOIN detalle_reporte_pedido drp ON p.Id_producto = drp.PK_fk_Idproducto GROUP BY p.Modelo_producto, p.Color_producto ORDER BY Total_Vendido ASC LIMIT 3;

-- Consulta No.14 Encontrar los productos que tienen un stock bajo y necesitan ser reabastecidos.

SELECT p.Modelo_producto AS Zapatilla, p.Color_producto AS Color, p.Cantidad_disponible_producto AS Stock_Disponible FROM producto p WHERE p.Cantidad_disponible_producto < 200;

-- Consulta No.15 Recupera información sobre pedidos, incluyendo detalles de los productos en esos pedidos, información de envío y el nombre del cliente:

SELECT rp.Id_pedido, CONCAT(u.Primer_nombre, ' ', u.Primer_apellido) AS Nombre_Cliente, r.Nombre_usuario AS Vendedor, rp.Fecha_emision AS Fecha_Pedido, p.Modelo_producto AS Producto, dtp.Cantidad_producto AS Cantidad, dtp.Metodo_pago AS Metodo_de_Pago, e.Tipo_envio AS Tipo_de_Envio, e.Nom_transportadora AS Transportadora, e.Ciudad_envio AS Ciudad_de_Envio, e.Direccion_entrega AS Direccion_de_Entrega FROM reporte_pedido rp JOIN usuario u ON rp.Telefono_cliente = u.Telefono_contacto JOIN usuario r ON rp.Pk_fk_numlocal = r.Id_usuario JOIN detalle_reporte_pedido dtp ON rp.Id_pedido = dtp.Pk_fk_id_pedido JOIN producto p ON dtp.Pk_fk_idproducto = p.Id_producto JOIN envio e ON rp.Pk_fk_Id_envio = e.Id_envio LEFT JOIN detalle_reporte_entrada dp ON p.Id_producto = dp.PK_fk_Id_producto WHERE rp.Fecha_emision >= '2021-01-01' AND rp.Fecha_emision <= '2023-12-31' ORDER BY rp.Id_pedido;

-- codigo desencriptacion

SELECT *, aes_decrypt(clave, 'aes') AS recuperado FROM usuario;
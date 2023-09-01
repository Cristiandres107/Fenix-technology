Create database fenix_technology;
Use fenix_technology;

    CREATE table validacion_documento(
    Tdoc varchar(20) NOT NULL primary  key,
    Numero_documento int(15) NOT NULL
  );

    CREATE table usuario( 
    Id_usuario int (10) NOT NULL,
    PK_fk_tdoc varchar  (10) NOT NULL,
    Primer_nombre varchar(20) NOT NULL,
    Segundo_nombre varchar(20) NOT NULL,
    Primer_apellido varchar(20) NOT NULL,
    Segundo_apellido varchar(20) NOT NULL,
    Telefono_contacto int (10) NOT NULL,
    Nombre_usuario varchar(15) NOT NULL,
    Email varchar(50) NOT NULL,
    Contraseña varchar(10) NOT NULL,
    primary key(Id_usuario, PK_fk_tdoc)
 );

    CREATE table roles(
        Cod_rol int(3) NOT NULL primary key,
        Desc_rol varchar(10) NOT NULL
    );
     
    CREATE table usuario_has_roles(
        Usuario_tdoc varchar(20) NOT NULL,
        Usuario_id int(10) NOT NULL,
        Usuario_rol int (3) NOT NULL,
        Estado_rol boolean NOT NULL,
        primary key(Usuario_tdoc,Usuario_id, Usuario_rol)
    );

CREATE table jefe_principal(
    Tdoc_jefeprincipal varchar(20) NOT NULL,
    Id_jefeprincipal int (10) NOT NULL,
    primary key(Tdoc_jefeprincipal,Id_jefeprincipal)
);

CREATE table proveedores(
    Tdoc_proveedor varchar(20) NOT NULL,
    Id_proveedor int (10) NOT NULL,  
    primary key (Tdoc_proveedor, Id_proveedor)
);

CREATE table jefe_bodega(
    Tdoc_jefebodega varchar(20) NOT NULL,
    Id_jefe_bodega int (10) NOT NULL,
    primary key(Tdoc_jefebodega, Id_jefe_bodega)
);

CREATE table vendedores(
    Tdoc_vendedor varchar(20) NOT NULL,
    Id_vendedor int (10) NOT NULL,
    primary key(Tdoc_vendedor, Id_vendedor)
);

CREATE table vendedores_has_locales (
    Vendedor_id_vendedor int(10) NOT NULL,
    Local_num_local int (5) NOT NULL,
    primary key (Vendedor_id_vendedor, Local_num_local)
);

CREATE table jefebodega_has_bodegas(
    Jefebodega_id_jefebodega int(10) NOT NULL,
    Bodega_id_bodega int(5) NOT NULL,
    primary key(Jefebodega_id_jefebodega, Bodega_id_bodega)
);


CREATE table pedidos(
    Id_pedido int (10) NOT NULL,
    PK_fk_Idproducto_pedido int(10) NOT NULL,
    PK_fk_envio_pedido int(10) NOT NULL,
    Fecha_pedido DATETIME NOT NULL,
    Nombre_cliente VARCHAR(10) NOT NULL,
    Apellido_cliente VARCHAR(10) NOT NULL,
    Telefono_cliente int(10) NOT NULL,
    Valor_total_pedido int(10) NOT NULL,
    primary key( Id_pedido, PK_fk_Idproducto_pedido, PK_fk_envio_pedido)     
);


CREATE table envios(
    Id_envio int(10) NOT NULL primary key,
    Tipo_envio varchar(20) NOT NULL,
    Nomtransportadora_envio varchar(20) NOT NULL,
    Cuidad_envio varchar(20) NOT NULL,
    Dirección_entrega_envio varchar(30) NOT NULL,
    Valor_envio BIGINT(10) NOT NULL,
    Fecha_estimada_entrega_pedido date NOT NULL
);

Create table locales(
    Num_local int(5) NOT NULL primary key ,
    Centro_comercial VARCHAR(20) NOT NULL
);

CREATE TABLE bodegas(
    Id_bodega int(5) NOT NULL primary key,
    Ubicacion_bodega varchar (20) NOT NULL,
    PK_fk_marcaproducto_bode varchar(20) NOT NULL
);

CREATE table marca_producto(
    Nom_marca_producto varchar(15) NOT NULL primary key,
    Estado_marca_producto boolean NOT NULL
);

CREATE table producto(
    PK_fk_marca_producto VARCHAR(15) NOT NULL,
    Id_producto int(5) NOT NULL,
    Modelo_producto varchar(15) NOT NULL,
    Tipo_producto varchar(10) NOT NULL,
    Color_producto VARCHAR(10) NOT NULL,
    Precio_producto BIGINT(10) NOT NULL,
    primary key(PK_fk_marca_producto, Id_producto)
);

CREATE table inventario(
    Pk_fk_producto int(5) NOT NULL primary key,
    Talla_disponible_producto varchar(10) NOT NULL,
    Cantidad_disponible_producto int(5) NOT NULL
);

CREATE table ventas(    
Id_venta int(5) NOT NULL,
Pk_fk_idproductoventa int(5) NOT NULL,
Pk_fk_numlocal int(5) NOT NULL,
Fecha_venta DATETIME NOT NULL, 
Totalvalor_venta BIGINT(10) NOT NULL,
Venta_idpedido int(5),
primary key (Id_venta, Pk_fk_idproductoventa, Pk_fk_numlocal)
); 

CREATE table devoluciones_locales(
Id_devolucion int(5) NOT NULL,
Pk_fk_producto int(5) NOT NULL, 
Fecha_devolucion DATETIME NOT NULL,
Pk_fk_numlocal int(5) NOT NULL,
primary key (Id_devolucion, Pk_fk_numlocal, Pk_fk_producto)
);

CREATE table entradas_productos(
    id_entradas_producto int(5) NOT NULL,
    PK_fk_marcaproducto_entradas  varchar(15) NOT NULL,
    PK_fk_idbodega_entradas int(5) NOT NULL,
    PK_fk_idproveedor_entradas int(5) NOT NULL,
    Cantidad_entradas_producto int(5) NOT NULL,
    Fecha_entrada DATETIME NOT NULL,
    primary key (id_entradas_producto,PK_fk_marcaproducto_entradas,PK_fk_idbodega_entradas, PK_fk_idproveedor_entradas)
);

CREATE table salidas_productos(
    id_salidas_producto int(5) NOT NULL,
    PK_fk_marcaproducto_salidas  varchar(15) NOT NULL,
    PK_fk_numlocal_salidas int(5) NOT NULL,
    PK_fk_id_jefebodega_salidas int(5) NOT NULL,
    Cantidad_salidas_producto int(5) NOT NULL,
    Fecha_salidas DATETIME NOT NULL,
    primary key (id_salidas_producto,PK_fk_marcaproducto_salidas,PK_fk_numlocal_salidas, PK_fk_id_jefebodega_salidas)
);


ALTER TABLE usuario 
ADD FOREIGN KEY (PK_fk_tdoc)
REFERENCES validacion_documento(Tdoc);

ALTER TABLE usuario_has_roles
ADD FOREIGN KEY (Usuario_tdoc, Usuario_id)
REFERENCES usuario(PK_fk_tdoc, Id_usuario);

ALTER TABLE usuario_has_roles
ADD FOREIGN KEY (Usuario_rol)
REFERENCES roles(Cod_rol);
 
ALTER TABLE jefe_principal
ADD FOREIGN KEY (Tdoc_jefeprincipal, Id_jefeprincipal)
REFERENCES usuario(PK_fk_tdoc, Id_usuario);

ALTER TABLE proveedores 
ADD FOREIGN KEY (Tdoc_proveedor, Id_proveedor)
REFERENCES usuario(PK_fk_tdoc, Id_usuario);

ALTER TABLE jefe_bodega 
ADD FOREIGN KEY (Tdoc_jefebodega, Id_jefe_bodega)
REFERENCES usuario(PK_fk_tdoc, Id_usuario);

ALTER TABLE vendedores 
ADD FOREIGN KEY (Tdoc_vendedor, Id_vendedor)
REFERENCES usuario(PK_fk_tdoc, Id_usuario);

ALTER TABLE vendedores_has_locales
ADD FOREIGN KEY (Vendedor_id_vendedor)
REFERENCES vendedores(Id_vendedor);

ALTER TABLE vendedores_has_locales
ADD FOREIGN KEY (Local_num_local)
REFERENCES locales(Num_local);

ALTER TABLE jefebodega_has_bodegas
ADD FOREIGN KEY (Jefebodega_id_jefebodega)
REFERENCES jefe_bodega(Id_jefe_bodega);

ALTER TABLE jefebodega_has_bodegas
ADD FOREIGN KEY (Bodega_id_bodega)
REFERENCES bodegas(Id_bodega);

ALTER TABLE producto
ADD FOREIGN KEY (PK_fk_marca_producto)
REFERENCES marca_producto(Nom_marca_producto);

ALTER TABLE inventario
ADD FOREIGN KEY (Pk_fk_producto)
REFERENCES producto(Id_producto);

ALTER TABLE devoluciones_locales
ADD FOREIGN KEY (Pk_fk_producto)
REFERENCES producto(Id_producto);

ALTER TABLE devoluciones_locales
ADD FOREIGN KEY (Pk_fk_numlocal)
REFERENCES locales(Num_local);

ALTER TABLE ventas
ADD FOREIGN KEY (Pk_fk_idproductoventa)
REFERENCES producto(Id_producto);

ALTER TABLE ventas
ADD FOREIGN KEY (Pk_fk_numlocal)
REFERENCES locales(Num_local);

ALTER TABLE ventas
ADD FOREIGN KEY (Venta_idpedido)
REFERENCES pedidos(Id_pedido);

ALTER TABLE pedidos
ADD FOREIGN KEY (PK_fk_Idproducto_pedido)
REFERENCES producto(Id_producto);

ALTER TABLE pedidos
ADD FOREIGN KEY (PK_fk_envio_pedido)
REFERENCES envios(Id_envio);

ALTER TABLE bodegas
ADD FOREIGN KEY (PK_fk_marcaproducto_bode)
REFERENCES marca_producto(Nom_marca_producto);

ALTER TABLE entradas_productos
ADD FOREIGN KEY (PK_fk_marcaproducto_entradas)
REFERENCES marca_producto(Nom_marca_producto);

ALTER TABLE entradas_productos
ADD FOREIGN KEY (PK_fk_idbodega_entradas)
REFERENCES bodegas(Id_bodega);

ALTER TABLE entradas_productos
ADD FOREIGN KEY (PK_fk_idproveedor_entradas)
REFERENCES proveedores(Id_proveedor);

ALTER TABLE salidas_productos
ADD FOREIGN KEY (PK_fk_marcaproducto_salidas)
REFERENCES marca_producto(Nom_marca_producto);

ALTER TABLE salidas_productos
ADD FOREIGN KEY (PK_fk_numlocal_salidas)
REFERENCES locales(Num_local);

ALTER TABLE salidas_productos
ADD FOREIGN KEY (PK_fk_id_jefebodega_salidas)
REFERENCES jefe_bodega(Id_jefe_bodega);

USE [TPODB];
GO

/*
Crea todas las tablas y constraints (PK/FK/UNIQUE/CHECK).
Re-ejecutable: primero elimina tablas en orden de dependencias.
*/
-- Elimina tablas en orden de dependencia para poder re-ejecutar el script
IF OBJECT_ID(N'dbo.detalle_pedido_repuesto', N'U') IS NOT NULL DROP TABLE dbo.detalle_pedido_repuesto;
IF OBJECT_ID(N'dbo.pedido_repuesto', N'U') IS NOT NULL DROP TABLE dbo.pedido_repuesto;
IF OBJECT_ID(N'dbo.proveedor_repuesto', N'U') IS NOT NULL DROP TABLE dbo.proveedor_repuesto;
IF OBJECT_ID(N'dbo.proveedores', N'U') IS NOT NULL DROP TABLE dbo.proveedores;
IF OBJECT_ID(N'dbo.turnos', N'U') IS NOT NULL DROP TABLE dbo.turnos;
IF OBJECT_ID(N'dbo.detalle_presupuesto', N'U') IS NOT NULL DROP TABLE dbo.detalle_presupuesto;
IF OBJECT_ID(N'dbo.presupuestos', N'U') IS NOT NULL DROP TABLE dbo.presupuestos;
IF OBJECT_ID(N'dbo.reclamos', N'U') IS NOT NULL DROP TABLE dbo.reclamos;
IF OBJECT_ID(N'dbo.pagos', N'U') IS NOT NULL DROP TABLE dbo.pagos;
IF OBJECT_ID(N'dbo.facturas', N'U') IS NOT NULL DROP TABLE dbo.facturas;
IF OBJECT_ID(N'dbo.detalle_solicitud', N'U') IS NOT NULL DROP TABLE dbo.detalle_solicitud;
IF OBJECT_ID(N'dbo.solicitud_repuesto', N'U') IS NOT NULL DROP TABLE dbo.solicitud_repuesto;
IF OBJECT_ID(N'dbo.stock_sucursal', N'U') IS NOT NULL DROP TABLE dbo.stock_sucursal;
IF OBJECT_ID(N'dbo.stock_almacen', N'U') IS NOT NULL DROP TABLE dbo.stock_almacen;
IF OBJECT_ID(N'dbo.detalle_orden', N'U') IS NOT NULL DROP TABLE dbo.detalle_orden;
IF OBJECT_ID(N'dbo.ordenes_trabajo', N'U') IS NOT NULL DROP TABLE dbo.ordenes_trabajo;
IF OBJECT_ID(N'dbo.estados_orden', N'U') IS NOT NULL DROP TABLE dbo.estados_orden;
IF OBJECT_ID(N'dbo.servicios', N'U') IS NOT NULL DROP TABLE dbo.servicios;
IF OBJECT_ID(N'dbo.mecanicos', N'U') IS NOT NULL DROP TABLE dbo.mecanicos;
IF OBJECT_ID(N'dbo.vehiculos', N'U') IS NOT NULL DROP TABLE dbo.vehiculos;
IF OBJECT_ID(N'dbo.repuestos', N'U') IS NOT NULL DROP TABLE dbo.repuestos;
IF OBJECT_ID(N'dbo.almacen', N'U') IS NOT NULL DROP TABLE dbo.almacen;
IF OBJECT_ID(N'dbo.marcas', N'U') IS NOT NULL DROP TABLE dbo.marcas;
IF OBJECT_ID(N'dbo.clientes', N'U') IS NOT NULL DROP TABLE dbo.clientes;
IF OBJECT_ID(N'dbo.sucursales', N'U') IS NOT NULL DROP TABLE dbo.sucursales;
GO

CREATE TABLE dbo.sucursales (
    id_sucursal INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_sucursales PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    direccion NVARCHAR(200) NOT NULL,
    telefono NVARCHAR(20) NULL
);
GO

CREATE TABLE dbo.clientes (
    id_cliente INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_clientes PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    dni NVARCHAR(20) NOT NULL,
    telefono NVARCHAR(20) NULL,
    email NVARCHAR(120) NULL,
    fecha_registro DATETIME2(0) NOT NULL CONSTRAINT DF_clientes_fecha_registro DEFAULT SYSDATETIME(),
    CONSTRAINT UQ_clientes_dni UNIQUE (dni),
    CONSTRAINT UQ_clientes_email UNIQUE (email)
);
GO

CREATE TABLE dbo.marcas (
    id_marca INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_marcas PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL CONSTRAINT UQ_marcas_nombre UNIQUE
);
GO

CREATE TABLE dbo.almacen (
    id_almacen INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_almacen PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    direccion NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE dbo.proveedores (
    id_proveedor INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_proveedores PRIMARY KEY,
    nombre NVARCHAR(120) NOT NULL,
    telefono NVARCHAR(20) NULL,
    email NVARCHAR(120) NULL,
    direccion NVARCHAR(200) NULL
);
GO

CREATE TABLE dbo.servicios (
    id_servicio INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_servicios PRIMARY KEY,
    descripcion NVARCHAR(200) NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL CONSTRAINT CK_servicios_precio CHECK (precio_base >= 0),
    duracion_estimada INT NOT NULL CONSTRAINT CK_servicios_duracion CHECK (duracion_estimada >= 0)
);
GO

CREATE TABLE dbo.estados_orden (
    id_estado INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_estados_orden PRIMARY KEY,
    descripcion NVARCHAR(50) NOT NULL CONSTRAINT UQ_estados_orden_descripcion UNIQUE
);
GO

CREATE TABLE dbo.vehiculos (
    id_vehiculo INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_vehiculos PRIMARY KEY,
    patente NVARCHAR(20) NOT NULL,
    modelo NVARCHAR(100) NOT NULL,
    anio SMALLINT NOT NULL CONSTRAINT CK_vehiculos_anio CHECK (anio BETWEEN 1900 AND 2100),
    kilometraje INT NOT NULL CONSTRAINT CK_vehiculos_km CHECK (kilometraje >= 0),
    id_cliente INT NOT NULL,
    id_marca INT NOT NULL,
    CONSTRAINT UQ_vehiculos_patente UNIQUE (patente),
    CONSTRAINT FK_vehiculos_clientes FOREIGN KEY (id_cliente) REFERENCES dbo.clientes (id_cliente),
    CONSTRAINT FK_vehiculos_marcas FOREIGN KEY (id_marca) REFERENCES dbo.marcas (id_marca)
);
GO

CREATE TABLE dbo.mecanicos (
    id_mecanico INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_mecanicos PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    especialidad NVARCHAR(100) NULL,
    telefono NVARCHAR(20) NULL,
    fecha_contratacion DATE NOT NULL,
    id_sucursal INT NOT NULL,
    CONSTRAINT FK_mecanicos_sucursales FOREIGN KEY (id_sucursal) REFERENCES dbo.sucursales (id_sucursal)
);
GO

CREATE TABLE dbo.repuestos (
    id_repuesto INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_repuestos PRIMARY KEY,
    nombre NVARCHAR(120) NOT NULL,
    id_marca INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL CONSTRAINT CK_repuestos_precio CHECK (precio_unitario >= 0),
    CONSTRAINT FK_repuestos_marcas FOREIGN KEY (id_marca) REFERENCES dbo.marcas (id_marca)
);
GO

CREATE TABLE dbo.ordenes_trabajo (
    id_orden INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ordenes_trabajo PRIMARY KEY,
    fecha_ingreso DATETIME2(0) NOT NULL CONSTRAINT DF_ordenes_fecha_ingreso DEFAULT SYSDATETIME(),
    fecha_egreso DATETIME2(0) NULL,
    observaciones NVARCHAR(MAX) NULL,
    id_vehiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_estado INT NOT NULL,
    CONSTRAINT CK_ordenes_fechas CHECK (fecha_egreso IS NULL OR fecha_egreso >= fecha_ingreso),
    CONSTRAINT FK_ordenes_vehiculos FOREIGN KEY (id_vehiculo) REFERENCES dbo.vehiculos (id_vehiculo),
    CONSTRAINT FK_ordenes_mecanicos FOREIGN KEY (id_mecanico) REFERENCES dbo.mecanicos (id_mecanico),
    CONSTRAINT FK_ordenes_sucursales FOREIGN KEY (id_sucursal) REFERENCES dbo.sucursales (id_sucursal),
    CONSTRAINT FK_ordenes_estados FOREIGN KEY (id_estado) REFERENCES dbo.estados_orden (id_estado)
);
GO

CREATE TABLE dbo.detalle_orden (
    id_detalle INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_detalle_orden PRIMARY KEY,
    id_orden INT NOT NULL,
    id_servicio INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL CONSTRAINT CK_detalle_orden_precio CHECK (precio >= 0),
    CONSTRAINT FK_detalle_orden_ordenes FOREIGN KEY (id_orden) REFERENCES dbo.ordenes_trabajo (id_orden),
    CONSTRAINT FK_detalle_orden_servicios FOREIGN KEY (id_servicio) REFERENCES dbo.servicios (id_servicio)
);
GO

CREATE TABLE dbo.stock_almacen (
    id_almacen INT NOT NULL,
    id_repuesto INT NOT NULL,
    cantidad INT NOT NULL CONSTRAINT CK_stock_almacen_cantidad CHECK (cantidad >= 0),
    CONSTRAINT PK_stock_almacen PRIMARY KEY (id_almacen, id_repuesto),
    CONSTRAINT FK_stock_almacen_almacen FOREIGN KEY (id_almacen) REFERENCES dbo.almacen (id_almacen),
    CONSTRAINT FK_stock_almacen_repuestos FOREIGN KEY (id_repuesto) REFERENCES dbo.repuestos (id_repuesto)
);
GO

CREATE TABLE dbo.stock_sucursal (
    id_sucursal INT NOT NULL,
    id_repuesto INT NOT NULL,
    cantidad INT NOT NULL CONSTRAINT CK_stock_sucursal_cantidad CHECK (cantidad >= 0),
    CONSTRAINT PK_stock_sucursal PRIMARY KEY (id_sucursal, id_repuesto),
    CONSTRAINT FK_stock_sucursal_sucursales FOREIGN KEY (id_sucursal) REFERENCES dbo.sucursales (id_sucursal),
    CONSTRAINT FK_stock_sucursal_repuestos FOREIGN KEY (id_repuesto) REFERENCES dbo.repuestos (id_repuesto)
);
GO

CREATE TABLE dbo.solicitud_repuesto (
    id_solicitud INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_solicitud_repuesto PRIMARY KEY,
    fecha DATETIME2(0) NOT NULL CONSTRAINT DF_solicitud_fecha DEFAULT SYSDATETIME(),
    estado NVARCHAR(50) NOT NULL,
    id_sucursal INT NOT NULL,
    id_almacen INT NOT NULL,
    CONSTRAINT FK_solicitud_sucursales FOREIGN KEY (id_sucursal) REFERENCES dbo.sucursales (id_sucursal),
    CONSTRAINT FK_solicitud_almacen FOREIGN KEY (id_almacen) REFERENCES dbo.almacen (id_almacen)
);
GO

CREATE TABLE dbo.detalle_solicitud (
    id_solicitud INT NOT NULL,
    id_repuesto INT NOT NULL,
    cantidad INT NOT NULL CONSTRAINT CK_detalle_solicitud_cantidad CHECK (cantidad >= 0),
    CONSTRAINT PK_detalle_solicitud PRIMARY KEY (id_solicitud, id_repuesto),
    CONSTRAINT FK_detalle_solicitud_solicitud FOREIGN KEY (id_solicitud) REFERENCES dbo.solicitud_repuesto (id_solicitud),
    CONSTRAINT FK_detalle_solicitud_repuesto FOREIGN KEY (id_repuesto) REFERENCES dbo.repuestos (id_repuesto)
);
GO

CREATE TABLE dbo.facturas (
    id_factura INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_facturas PRIMARY KEY,
    fecha DATETIME2(0) NOT NULL CONSTRAINT DF_facturas_fecha DEFAULT SYSDATETIME(),
    total DECIMAL(10,2) NOT NULL CONSTRAINT CK_facturas_total CHECK (total >= 0),
    id_orden INT NOT NULL,
    CONSTRAINT FK_facturas_ordenes FOREIGN KEY (id_orden) REFERENCES dbo.ordenes_trabajo (id_orden)
);
GO

CREATE TABLE dbo.pagos (
    id_pago INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_pagos PRIMARY KEY,
    fecha DATETIME2(0) NOT NULL CONSTRAINT DF_pagos_fecha DEFAULT SYSDATETIME(),
    monto DECIMAL(10,2) NOT NULL CONSTRAINT CK_pagos_monto CHECK (monto >= 0),
    medio_pago NVARCHAR(50) NOT NULL,
    id_factura INT NOT NULL,
    CONSTRAINT FK_pagos_facturas FOREIGN KEY (id_factura) REFERENCES dbo.facturas (id_factura)
);
GO

CREATE TABLE dbo.reclamos (
    id_reclamo INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_reclamos PRIMARY KEY,
    fecha DATETIME2(0) NOT NULL CONSTRAINT DF_reclamos_fecha DEFAULT SYSDATETIME(),
    descripcion NVARCHAR(MAX) NOT NULL,
    estado NVARCHAR(50) NOT NULL,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    CONSTRAINT FK_reclamos_clientes FOREIGN KEY (id_cliente) REFERENCES dbo.clientes (id_cliente),
    CONSTRAINT FK_reclamos_vehiculos FOREIGN KEY (id_vehiculo) REFERENCES dbo.vehiculos (id_vehiculo)
);
GO

CREATE TABLE dbo.presupuestos (
    id_presupuesto INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_presupuestos PRIMARY KEY,
    fecha DATETIME2(0) NOT NULL CONSTRAINT DF_presupuestos_fecha DEFAULT SYSDATETIME(),
    estado NVARCHAR(50) NOT NULL,
    total_estimado DECIMAL(10,2) NOT NULL CONSTRAINT CK_presupuestos_total CHECK (total_estimado >= 0),
    id_cliente INT NOT NULL,
    CONSTRAINT FK_presupuestos_clientes FOREIGN KEY (id_cliente) REFERENCES dbo.clientes (id_cliente)
);
GO

CREATE TABLE dbo.detalle_presupuesto (
    id_detalle_presupuesto INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_detalle_presupuesto PRIMARY KEY,
    id_presupuesto INT NOT NULL,
    id_servicio INT NOT NULL,
    precio_estimado DECIMAL(10,2) NOT NULL CONSTRAINT CK_detalle_presupuesto_precio CHECK (precio_estimado >= 0),
    CONSTRAINT FK_detalle_presupuesto_presupuestos FOREIGN KEY (id_presupuesto) REFERENCES dbo.presupuestos (id_presupuesto),
    CONSTRAINT FK_detalle_presupuesto_servicios FOREIGN KEY (id_servicio) REFERENCES dbo.servicios (id_servicio)
);
GO

CREATE TABLE dbo.turnos (
    id_turno INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_turnos PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME(0) NOT NULL,
    estado NVARCHAR(50) NOT NULL,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    id_sucursal INT NOT NULL,
    CONSTRAINT FK_turnos_clientes FOREIGN KEY (id_cliente) REFERENCES dbo.clientes (id_cliente),
    CONSTRAINT FK_turnos_vehiculos FOREIGN KEY (id_vehiculo) REFERENCES dbo.vehiculos (id_vehiculo),
    CONSTRAINT FK_turnos_sucursales FOREIGN KEY (id_sucursal) REFERENCES dbo.sucursales (id_sucursal)
);
GO

CREATE TABLE dbo.proveedor_repuesto (
    id_proveedor INT NOT NULL,
    id_repuesto INT NOT NULL,
    precio_referencia DECIMAL(10,2) NOT NULL CONSTRAINT CK_proveedor_repuesto_precio CHECK (precio_referencia >= 0),
    CONSTRAINT PK_proveedor_repuesto PRIMARY KEY (id_proveedor, id_repuesto),
    CONSTRAINT FK_proveedor_repuesto_proveedores FOREIGN KEY (id_proveedor) REFERENCES dbo.proveedores (id_proveedor),
    CONSTRAINT FK_proveedor_repuesto_repuestos FOREIGN KEY (id_repuesto) REFERENCES dbo.repuestos (id_repuesto)
);
GO

CREATE TABLE dbo.pedido_repuesto (
    id_pedido INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_pedido_repuesto PRIMARY KEY,
    fecha DATETIME2(0) NOT NULL CONSTRAINT DF_pedido_repuesto_fecha DEFAULT SYSDATETIME(),
    estado NVARCHAR(50) NOT NULL,
    id_proveedor INT NOT NULL,
    id_almacen INT NOT NULL,
    CONSTRAINT FK_pedido_repuesto_proveedores FOREIGN KEY (id_proveedor) REFERENCES dbo.proveedores (id_proveedor),
    CONSTRAINT FK_pedido_repuesto_almacen FOREIGN KEY (id_almacen) REFERENCES dbo.almacen (id_almacen)
);
GO

CREATE TABLE dbo.detalle_pedido_repuesto (
    id_pedido INT NOT NULL,
    id_repuesto INT NOT NULL,
    cantidad INT NOT NULL CONSTRAINT CK_detalle_pedido_repuesto_cantidad CHECK (cantidad >= 0),
    precio_unitario DECIMAL(10,2) NOT NULL CONSTRAINT CK_detalle_pedido_repuesto_precio CHECK (precio_unitario >= 0),
    CONSTRAINT PK_detalle_pedido_repuesto PRIMARY KEY (id_pedido, id_repuesto),
    CONSTRAINT FK_detalle_pedido_repuesto_pedido FOREIGN KEY (id_pedido) REFERENCES dbo.pedido_repuesto (id_pedido),
    CONSTRAINT FK_detalle_pedido_repuesto_repuesto FOREIGN KEY (id_repuesto) REFERENCES dbo.repuestos (id_repuesto)
);
GO

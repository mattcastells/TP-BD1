USE [TPODB];
GO

/*
Crea procedimientos almacenados CRUD (Insert/Update/Delete) por tabla.
*/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

/* SUCURSALES */
CREATE OR ALTER PROCEDURE dbo.usp_Sucursales_Insert
    @nombre NVARCHAR(100),
    @direccion NVARCHAR(200),
    @telefono NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.sucursales (nombre, direccion, telefono)
    VALUES (@nombre, @direccion, @telefono);

    SELECT SCOPE_IDENTITY() AS id_sucursal;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Sucursales_Update
    @id_sucursal INT,
    @nombre NVARCHAR(100),
    @direccion NVARCHAR(200),
    @telefono NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.sucursales
    SET nombre = @nombre,
        direccion = @direccion,
        telefono = @telefono
    WHERE id_sucursal = @id_sucursal;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Sucursales_Delete
    @id_sucursal INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.sucursales
    WHERE id_sucursal = @id_sucursal;
END
GO

/* CLIENTES */
CREATE OR ALTER PROCEDURE dbo.usp_Clientes_Insert
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @dni NVARCHAR(20),
    @telefono NVARCHAR(20) = NULL,
    @email NVARCHAR(120) = NULL,
    @fecha_registro DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.clientes (nombre, apellido, dni, telefono, email, fecha_registro)
    VALUES (@nombre, @apellido, @dni, @telefono, @email, COALESCE(@fecha_registro, SYSDATETIME()));

    SELECT SCOPE_IDENTITY() AS id_cliente;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Clientes_Update
    @id_cliente INT,
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @dni NVARCHAR(20),
    @telefono NVARCHAR(20) = NULL,
    @email NVARCHAR(120) = NULL,
    @fecha_registro DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.clientes
    SET nombre = @nombre,
        apellido = @apellido,
        dni = @dni,
        telefono = @telefono,
        email = @email,
        fecha_registro = @fecha_registro
    WHERE id_cliente = @id_cliente;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Clientes_Delete
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.clientes
    WHERE id_cliente = @id_cliente;
END
GO

/* MARCAS */
CREATE OR ALTER PROCEDURE dbo.usp_Marcas_Insert
    @nombre NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.marcas (nombre)
    VALUES (@nombre);

    SELECT SCOPE_IDENTITY() AS id_marca;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Marcas_Update
    @id_marca INT,
    @nombre NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.marcas
    SET nombre = @nombre
    WHERE id_marca = @id_marca;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Marcas_Delete
    @id_marca INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.marcas
    WHERE id_marca = @id_marca;
END
GO

/* ALMACEN */
CREATE OR ALTER PROCEDURE dbo.usp_Almacen_Insert
    @nombre NVARCHAR(100),
    @direccion NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.almacen (nombre, direccion)
    VALUES (@nombre, @direccion);

    SELECT SCOPE_IDENTITY() AS id_almacen;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Almacen_Update
    @id_almacen INT,
    @nombre NVARCHAR(100),
    @direccion NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.almacen
    SET nombre = @nombre,
        direccion = @direccion
    WHERE id_almacen = @id_almacen;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Almacen_Delete
    @id_almacen INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.almacen
    WHERE id_almacen = @id_almacen;
END
GO

/* PROVEEDORES */
CREATE OR ALTER PROCEDURE dbo.usp_Proveedores_Insert
    @nombre NVARCHAR(120),
    @telefono NVARCHAR(20) = NULL,
    @email NVARCHAR(120) = NULL,
    @direccion NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.proveedores (nombre, telefono, email, direccion)
    VALUES (@nombre, @telefono, @email, @direccion);

    SELECT SCOPE_IDENTITY() AS id_proveedor;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Proveedores_Update
    @id_proveedor INT,
    @nombre NVARCHAR(120),
    @telefono NVARCHAR(20) = NULL,
    @email NVARCHAR(120) = NULL,
    @direccion NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.proveedores
    SET nombre = @nombre,
        telefono = @telefono,
        email = @email,
        direccion = @direccion
    WHERE id_proveedor = @id_proveedor;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Proveedores_Delete
    @id_proveedor INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.proveedores
    WHERE id_proveedor = @id_proveedor;
END
GO

/* SERVICIOS */
CREATE OR ALTER PROCEDURE dbo.usp_Servicios_Insert
    @descripcion NVARCHAR(200),
    @precio_base DECIMAL(10,2),
    @duracion_estimada INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.servicios (descripcion, precio_base, duracion_estimada)
    VALUES (@descripcion, @precio_base, @duracion_estimada);

    SELECT SCOPE_IDENTITY() AS id_servicio;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Servicios_Update
    @id_servicio INT,
    @descripcion NVARCHAR(200),
    @precio_base DECIMAL(10,2),
    @duracion_estimada INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.servicios
    SET descripcion = @descripcion,
        precio_base = @precio_base,
        duracion_estimada = @duracion_estimada
    WHERE id_servicio = @id_servicio;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Servicios_Delete
    @id_servicio INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.servicios
    WHERE id_servicio = @id_servicio;
END
GO

/* ESTADOS_ORDEN */
CREATE OR ALTER PROCEDURE dbo.usp_EstadosOrden_Insert
    @descripcion NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.estados_orden (descripcion)
    VALUES (@descripcion);

    SELECT SCOPE_IDENTITY() AS id_estado;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_EstadosOrden_Update
    @id_estado INT,
    @descripcion NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.estados_orden
    SET descripcion = @descripcion
    WHERE id_estado = @id_estado;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_EstadosOrden_Delete
    @id_estado INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.estados_orden
    WHERE id_estado = @id_estado;
END
GO

/* VEHICULOS */
CREATE OR ALTER PROCEDURE dbo.usp_Vehiculos_Insert
    @patente NVARCHAR(20),
    @modelo NVARCHAR(100),
    @anio SMALLINT,
    @kilometraje INT,
    @id_cliente INT,
    @id_marca INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.vehiculos (patente, modelo, anio, kilometraje, id_cliente, id_marca)
    VALUES (@patente, @modelo, @anio, @kilometraje, @id_cliente, @id_marca);

    SELECT SCOPE_IDENTITY() AS id_vehiculo;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Vehiculos_Update
    @id_vehiculo INT,
    @patente NVARCHAR(20),
    @modelo NVARCHAR(100),
    @anio SMALLINT,
    @kilometraje INT,
    @id_cliente INT,
    @id_marca INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.vehiculos
    SET patente = @patente,
        modelo = @modelo,
        anio = @anio,
        kilometraje = @kilometraje,
        id_cliente = @id_cliente,
        id_marca = @id_marca
    WHERE id_vehiculo = @id_vehiculo;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Vehiculos_Delete
    @id_vehiculo INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.vehiculos
    WHERE id_vehiculo = @id_vehiculo;
END
GO

/* MECANICOS */
CREATE OR ALTER PROCEDURE dbo.usp_Mecanicos_Insert
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @especialidad NVARCHAR(100) = NULL,
    @telefono NVARCHAR(20) = NULL,
    @fecha_contratacion DATE,
    @id_sucursal INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.mecanicos (nombre, apellido, especialidad, telefono, fecha_contratacion, id_sucursal)
    VALUES (@nombre, @apellido, @especialidad, @telefono, @fecha_contratacion, @id_sucursal);

    SELECT SCOPE_IDENTITY() AS id_mecanico;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Mecanicos_Update
    @id_mecanico INT,
    @nombre NVARCHAR(100),
    @apellido NVARCHAR(100),
    @especialidad NVARCHAR(100) = NULL,
    @telefono NVARCHAR(20) = NULL,
    @fecha_contratacion DATE,
    @id_sucursal INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.mecanicos
    SET nombre = @nombre,
        apellido = @apellido,
        especialidad = @especialidad,
        telefono = @telefono,
        fecha_contratacion = @fecha_contratacion,
        id_sucursal = @id_sucursal
    WHERE id_mecanico = @id_mecanico;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Mecanicos_Delete
    @id_mecanico INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.mecanicos
    WHERE id_mecanico = @id_mecanico;
END
GO

/* REPUESTOS */
CREATE OR ALTER PROCEDURE dbo.usp_Repuestos_Insert
    @nombre NVARCHAR(120),
    @id_marca INT,
    @precio_unitario DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.repuestos (nombre, id_marca, precio_unitario)
    VALUES (@nombre, @id_marca, @precio_unitario);

    SELECT SCOPE_IDENTITY() AS id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Repuestos_Update
    @id_repuesto INT,
    @nombre NVARCHAR(120),
    @id_marca INT,
    @precio_unitario DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.repuestos
    SET nombre = @nombre,
        id_marca = @id_marca,
        precio_unitario = @precio_unitario
    WHERE id_repuesto = @id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Repuestos_Delete
    @id_repuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.repuestos
    WHERE id_repuesto = @id_repuesto;
END
GO

/* ORDENES_TRABAJO */
CREATE OR ALTER PROCEDURE dbo.usp_OrdenesTrabajo_Insert
    @fecha_ingreso DATETIME2(0) = NULL,
    @fecha_egreso DATETIME2(0) = NULL,
    @observaciones NVARCHAR(MAX) = NULL,
    @id_vehiculo INT,
    @id_mecanico INT,
    @id_sucursal INT,
    @id_estado INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.ordenes_trabajo
        (fecha_ingreso, fecha_egreso, observaciones, id_vehiculo, id_mecanico, id_sucursal, id_estado)
    VALUES
        (COALESCE(@fecha_ingreso, SYSDATETIME()), @fecha_egreso, @observaciones, @id_vehiculo, @id_mecanico, @id_sucursal, @id_estado);

    SELECT SCOPE_IDENTITY() AS id_orden;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_OrdenesTrabajo_Update
    @id_orden INT,
    @fecha_ingreso DATETIME2(0),
    @fecha_egreso DATETIME2(0) = NULL,
    @observaciones NVARCHAR(MAX) = NULL,
    @id_vehiculo INT,
    @id_mecanico INT,
    @id_sucursal INT,
    @id_estado INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ordenes_trabajo
    SET fecha_ingreso = @fecha_ingreso,
        fecha_egreso = @fecha_egreso,
        observaciones = @observaciones,
        id_vehiculo = @id_vehiculo,
        id_mecanico = @id_mecanico,
        id_sucursal = @id_sucursal,
        id_estado = @id_estado
    WHERE id_orden = @id_orden;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_OrdenesTrabajo_Delete
    @id_orden INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.ordenes_trabajo
    WHERE id_orden = @id_orden;
END
GO

/* DETALLE_ORDEN */
CREATE OR ALTER PROCEDURE dbo.usp_DetalleOrden_Insert
    @id_orden INT,
    @id_servicio INT,
    @precio DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.detalle_orden (id_orden, id_servicio, precio)
    VALUES (@id_orden, @id_servicio, @precio);

    SELECT SCOPE_IDENTITY() AS id_detalle;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetalleOrden_Update
    @id_detalle INT,
    @id_orden INT,
    @id_servicio INT,
    @precio DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.detalle_orden
    SET id_orden = @id_orden,
        id_servicio = @id_servicio,
        precio = @precio
    WHERE id_detalle = @id_detalle;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetalleOrden_Delete
    @id_detalle INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.detalle_orden
    WHERE id_detalle = @id_detalle;
END
GO

/* STOCK_ALMACEN */
CREATE OR ALTER PROCEDURE dbo.usp_StockAlmacen_Insert
    @id_almacen INT,
    @id_repuesto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.stock_almacen (id_almacen, id_repuesto, cantidad)
    VALUES (@id_almacen, @id_repuesto, @cantidad);

    SELECT @id_almacen AS id_almacen, @id_repuesto AS id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_StockAlmacen_Update
    @id_almacen INT,
    @id_repuesto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.stock_almacen
    SET cantidad = @cantidad
    WHERE id_almacen = @id_almacen AND id_repuesto = @id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_StockAlmacen_Delete
    @id_almacen INT,
    @id_repuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.stock_almacen
    WHERE id_almacen = @id_almacen AND id_repuesto = @id_repuesto;
END
GO

/* STOCK_SUCURSAL */
CREATE OR ALTER PROCEDURE dbo.usp_StockSucursal_Insert
    @id_sucursal INT,
    @id_repuesto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.stock_sucursal (id_sucursal, id_repuesto, cantidad)
    VALUES (@id_sucursal, @id_repuesto, @cantidad);

    SELECT @id_sucursal AS id_sucursal, @id_repuesto AS id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_StockSucursal_Update
    @id_sucursal INT,
    @id_repuesto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.stock_sucursal
    SET cantidad = @cantidad
    WHERE id_sucursal = @id_sucursal AND id_repuesto = @id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_StockSucursal_Delete
    @id_sucursal INT,
    @id_repuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.stock_sucursal
    WHERE id_sucursal = @id_sucursal AND id_repuesto = @id_repuesto;
END
GO

/* SOLICITUD_REPUESTO */
CREATE OR ALTER PROCEDURE dbo.usp_SolicitudRepuesto_Insert
    @fecha DATETIME2(0) = NULL,
    @estado NVARCHAR(50),
    @id_sucursal INT,
    @id_almacen INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.solicitud_repuesto (fecha, estado, id_sucursal, id_almacen)
    VALUES (COALESCE(@fecha, SYSDATETIME()), @estado, @id_sucursal, @id_almacen);

    SELECT SCOPE_IDENTITY() AS id_solicitud;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SolicitudRepuesto_Update
    @id_solicitud INT,
    @fecha DATETIME2(0),
    @estado NVARCHAR(50),
    @id_sucursal INT,
    @id_almacen INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.solicitud_repuesto
    SET fecha = @fecha,
        estado = @estado,
        id_sucursal = @id_sucursal,
        id_almacen = @id_almacen
    WHERE id_solicitud = @id_solicitud;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_SolicitudRepuesto_Delete
    @id_solicitud INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.solicitud_repuesto
    WHERE id_solicitud = @id_solicitud;
END
GO

/* DETALLE_SOLICITUD */
CREATE OR ALTER PROCEDURE dbo.usp_DetalleSolicitud_Insert
    @id_solicitud INT,
    @id_repuesto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.detalle_solicitud (id_solicitud, id_repuesto, cantidad)
    VALUES (@id_solicitud, @id_repuesto, @cantidad);

    SELECT @id_solicitud AS id_solicitud, @id_repuesto AS id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetalleSolicitud_Update
    @id_solicitud INT,
    @id_repuesto INT,
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.detalle_solicitud
    SET cantidad = @cantidad
    WHERE id_solicitud = @id_solicitud AND id_repuesto = @id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetalleSolicitud_Delete
    @id_solicitud INT,
    @id_repuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.detalle_solicitud
    WHERE id_solicitud = @id_solicitud AND id_repuesto = @id_repuesto;
END
GO

/* FACTURAS */
CREATE OR ALTER PROCEDURE dbo.usp_Facturas_Insert
    @fecha DATETIME2(0) = NULL,
    @total DECIMAL(10,2),
    @id_orden INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.facturas (fecha, total, id_orden)
    VALUES (COALESCE(@fecha, SYSDATETIME()), @total, @id_orden);

    SELECT SCOPE_IDENTITY() AS id_factura;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Facturas_Update
    @id_factura INT,
    @fecha DATETIME2(0),
    @total DECIMAL(10,2),
    @id_orden INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.facturas
    SET fecha = @fecha,
        total = @total,
        id_orden = @id_orden
    WHERE id_factura = @id_factura;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Facturas_Delete
    @id_factura INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.facturas
    WHERE id_factura = @id_factura;
END
GO

/* PAGOS */
CREATE OR ALTER PROCEDURE dbo.usp_Pagos_Insert
    @fecha DATETIME2(0) = NULL,
    @monto DECIMAL(10,2),
    @medio_pago NVARCHAR(50),
    @id_factura INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.pagos (fecha, monto, medio_pago, id_factura)
    VALUES (COALESCE(@fecha, SYSDATETIME()), @monto, @medio_pago, @id_factura);

    SELECT SCOPE_IDENTITY() AS id_pago;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Pagos_Update
    @id_pago INT,
    @fecha DATETIME2(0),
    @monto DECIMAL(10,2),
    @medio_pago NVARCHAR(50),
    @id_factura INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.pagos
    SET fecha = @fecha,
        monto = @monto,
        medio_pago = @medio_pago,
        id_factura = @id_factura
    WHERE id_pago = @id_pago;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Pagos_Delete
    @id_pago INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.pagos
    WHERE id_pago = @id_pago;
END
GO

/* RECLAMOS */
CREATE OR ALTER PROCEDURE dbo.usp_Reclamos_Insert
    @fecha DATETIME2(0) = NULL,
    @descripcion NVARCHAR(MAX),
    @estado NVARCHAR(50),
    @id_cliente INT,
    @id_vehiculo INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.reclamos (fecha, descripcion, estado, id_cliente, id_vehiculo)
    VALUES (COALESCE(@fecha, SYSDATETIME()), @descripcion, @estado, @id_cliente, @id_vehiculo);

    SELECT SCOPE_IDENTITY() AS id_reclamo;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Reclamos_Update
    @id_reclamo INT,
    @fecha DATETIME2(0),
    @descripcion NVARCHAR(MAX),
    @estado NVARCHAR(50),
    @id_cliente INT,
    @id_vehiculo INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.reclamos
    SET fecha = @fecha,
        descripcion = @descripcion,
        estado = @estado,
        id_cliente = @id_cliente,
        id_vehiculo = @id_vehiculo
    WHERE id_reclamo = @id_reclamo;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Reclamos_Delete
    @id_reclamo INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.reclamos
    WHERE id_reclamo = @id_reclamo;
END
GO

/* PRESUPUESTOS */
CREATE OR ALTER PROCEDURE dbo.usp_Presupuestos_Insert
    @fecha DATETIME2(0) = NULL,
    @estado NVARCHAR(50),
    @total_estimado DECIMAL(10,2),
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.presupuestos (fecha, estado, total_estimado, id_cliente)
    VALUES (COALESCE(@fecha, SYSDATETIME()), @estado, @total_estimado, @id_cliente);

    SELECT SCOPE_IDENTITY() AS id_presupuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Presupuestos_Update
    @id_presupuesto INT,
    @fecha DATETIME2(0),
    @estado NVARCHAR(50),
    @total_estimado DECIMAL(10,2),
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.presupuestos
    SET fecha = @fecha,
        estado = @estado,
        total_estimado = @total_estimado,
        id_cliente = @id_cliente
    WHERE id_presupuesto = @id_presupuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Presupuestos_Delete
    @id_presupuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.presupuestos
    WHERE id_presupuesto = @id_presupuesto;
END
GO

/* DETALLE_PRESUPUESTO */
CREATE OR ALTER PROCEDURE dbo.usp_DetallePresupuesto_Insert
    @id_presupuesto INT,
    @id_servicio INT,
    @precio_estimado DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.detalle_presupuesto (id_presupuesto, id_servicio, precio_estimado)
    VALUES (@id_presupuesto, @id_servicio, @precio_estimado);

    SELECT SCOPE_IDENTITY() AS id_detalle_presupuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetallePresupuesto_Update
    @id_detalle_presupuesto INT,
    @id_presupuesto INT,
    @id_servicio INT,
    @precio_estimado DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.detalle_presupuesto
    SET id_presupuesto = @id_presupuesto,
        id_servicio = @id_servicio,
        precio_estimado = @precio_estimado
    WHERE id_detalle_presupuesto = @id_detalle_presupuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetallePresupuesto_Delete
    @id_detalle_presupuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.detalle_presupuesto
    WHERE id_detalle_presupuesto = @id_detalle_presupuesto;
END
GO

/* TURNOS */
CREATE OR ALTER PROCEDURE dbo.usp_Turnos_Insert
    @fecha DATE,
    @hora TIME(0),
    @estado NVARCHAR(50),
    @id_cliente INT,
    @id_vehiculo INT,
    @id_sucursal INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.turnos (fecha, hora, estado, id_cliente, id_vehiculo, id_sucursal)
    VALUES (@fecha, @hora, @estado, @id_cliente, @id_vehiculo, @id_sucursal);

    SELECT SCOPE_IDENTITY() AS id_turno;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Turnos_Update
    @id_turno INT,
    @fecha DATE,
    @hora TIME(0),
    @estado NVARCHAR(50),
    @id_cliente INT,
    @id_vehiculo INT,
    @id_sucursal INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.turnos
    SET fecha = @fecha,
        hora = @hora,
        estado = @estado,
        id_cliente = @id_cliente,
        id_vehiculo = @id_vehiculo,
        id_sucursal = @id_sucursal
    WHERE id_turno = @id_turno;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_Turnos_Delete
    @id_turno INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.turnos
    WHERE id_turno = @id_turno;
END
GO

/* PROVEEDOR_REPUESTO */
CREATE OR ALTER PROCEDURE dbo.usp_ProveedorRepuesto_Insert
    @id_proveedor INT,
    @id_repuesto INT,
    @precio_referencia DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.proveedor_repuesto (id_proveedor, id_repuesto, precio_referencia)
    VALUES (@id_proveedor, @id_repuesto, @precio_referencia);

    SELECT @id_proveedor AS id_proveedor, @id_repuesto AS id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_ProveedorRepuesto_Update
    @id_proveedor INT,
    @id_repuesto INT,
    @precio_referencia DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.proveedor_repuesto
    SET precio_referencia = @precio_referencia
    WHERE id_proveedor = @id_proveedor AND id_repuesto = @id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_ProveedorRepuesto_Delete
    @id_proveedor INT,
    @id_repuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.proveedor_repuesto
    WHERE id_proveedor = @id_proveedor AND id_repuesto = @id_repuesto;
END
GO

/* PEDIDO_REPUESTO */
CREATE OR ALTER PROCEDURE dbo.usp_PedidoRepuesto_Insert
    @fecha DATETIME2(0) = NULL,
    @estado NVARCHAR(50),
    @id_proveedor INT,
    @id_almacen INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.pedido_repuesto (fecha, estado, id_proveedor, id_almacen)
    VALUES (COALESCE(@fecha, SYSDATETIME()), @estado, @id_proveedor, @id_almacen);

    SELECT SCOPE_IDENTITY() AS id_pedido;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_PedidoRepuesto_Update
    @id_pedido INT,
    @fecha DATETIME2(0),
    @estado NVARCHAR(50),
    @id_proveedor INT,
    @id_almacen INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.pedido_repuesto
    SET fecha = @fecha,
        estado = @estado,
        id_proveedor = @id_proveedor,
        id_almacen = @id_almacen
    WHERE id_pedido = @id_pedido;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_PedidoRepuesto_Delete
    @id_pedido INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.pedido_repuesto
    WHERE id_pedido = @id_pedido;
END
GO

/* DETALLE_PEDIDO_REPUESTO */
CREATE OR ALTER PROCEDURE dbo.usp_DetallePedidoRepuesto_Insert
    @id_pedido INT,
    @id_repuesto INT,
    @cantidad INT,
    @precio_unitario DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.detalle_pedido_repuesto (id_pedido, id_repuesto, cantidad, precio_unitario)
    VALUES (@id_pedido, @id_repuesto, @cantidad, @precio_unitario);

    SELECT @id_pedido AS id_pedido, @id_repuesto AS id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetallePedidoRepuesto_Update
    @id_pedido INT,
    @id_repuesto INT,
    @cantidad INT,
    @precio_unitario DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.detalle_pedido_repuesto
    SET cantidad = @cantidad,
        precio_unitario = @precio_unitario
    WHERE id_pedido = @id_pedido AND id_repuesto = @id_repuesto;
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_DetallePedidoRepuesto_Delete
    @id_pedido INT,
    @id_repuesto INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.detalle_pedido_repuesto
    WHERE id_pedido = @id_pedido AND id_repuesto = @id_repuesto;
END
GO

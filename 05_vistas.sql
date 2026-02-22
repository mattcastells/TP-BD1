USE [TPODB];
GO

/*
Crea vistas para consultas frecuentes y resúmenes.
*/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

-- 1) Clientes y vehiculos
CREATE OR ALTER VIEW dbo.vw_clientes_vehiculos
AS
SELECT c.id_cliente, c.nombre, c.apellido, c.dni, c.telefono, c.email,
       v.id_vehiculo, v.patente, v.modelo, v.anio, v.kilometraje,
       m.nombre AS marca
FROM dbo.clientes c
LEFT JOIN dbo.vehiculos v ON v.id_cliente = c.id_cliente
LEFT JOIN dbo.marcas m ON m.id_marca = v.id_marca;
GO

-- 2) Resumen de ordenes de trabajo
CREATE OR ALTER VIEW dbo.vw_ordenes_resumen
AS
SELECT o.id_orden, o.fecha_ingreso, o.fecha_egreso,
       e.descripcion AS estado,
       s.nombre AS sucursal,
       me.apellido + ', ' + me.nombre AS mecanico,
       v.patente,
       c.apellido + ', ' + c.nombre AS cliente,
       SUM(d.precio) AS total_orden
FROM dbo.ordenes_trabajo o
JOIN dbo.estados_orden e ON e.id_estado = o.id_estado
JOIN dbo.sucursales s ON s.id_sucursal = o.id_sucursal
JOIN dbo.mecanicos me ON me.id_mecanico = o.id_mecanico
JOIN dbo.vehiculos v ON v.id_vehiculo = o.id_vehiculo
JOIN dbo.clientes c ON c.id_cliente = v.id_cliente
LEFT JOIN dbo.detalle_orden d ON d.id_orden = o.id_orden
GROUP BY o.id_orden, o.fecha_ingreso, o.fecha_egreso,
         e.descripcion, s.nombre, me.apellido, me.nombre,
         v.patente, c.apellido, c.nombre;
GO

-- 3) Stock total por repuesto
CREATE OR ALTER VIEW dbo.vw_stock_total_repuesto
AS
SELECT r.id_repuesto, r.nombre, m.nombre AS marca,
       ISNULL(sa.total_almacen, 0) AS total_almacen,
       ISNULL(ss.total_sucursal, 0) AS total_sucursal,
       ISNULL(sa.total_almacen, 0) + ISNULL(ss.total_sucursal, 0) AS total
FROM dbo.repuestos r
JOIN dbo.marcas m ON m.id_marca = r.id_marca
LEFT JOIN (
    SELECT id_repuesto, SUM(cantidad) AS total_almacen
    FROM dbo.stock_almacen
    GROUP BY id_repuesto
) sa ON sa.id_repuesto = r.id_repuesto
LEFT JOIN (
    SELECT id_repuesto, SUM(cantidad) AS total_sucursal
    FROM dbo.stock_sucursal
    GROUP BY id_repuesto
) ss ON ss.id_repuesto = r.id_repuesto;
GO

-- 4) Facturacion mensual
CREATE OR ALTER VIEW dbo.vw_facturacion_mensual
AS
SELECT DATEFROMPARTS(YEAR(fecha), MONTH(fecha), 1) AS mes,
       SUM(total) AS total_facturado,
       COUNT(*) AS cantidad_facturas
FROM dbo.facturas
GROUP BY DATEFROMPARTS(YEAR(fecha), MONTH(fecha), 1);
GO

-- 5) Agenda de turnos
CREATE OR ALTER VIEW dbo.vw_turnos_agenda
AS
SELECT t.id_turno, t.fecha, t.hora, t.estado,
       s.nombre AS sucursal,
       c.apellido + ', ' + c.nombre AS cliente,
       v.patente, v.modelo
FROM dbo.turnos t
JOIN dbo.sucursales s ON s.id_sucursal = t.id_sucursal
JOIN dbo.clientes c ON c.id_cliente = t.id_cliente
JOIN dbo.vehiculos v ON v.id_vehiculo = t.id_vehiculo;
GO

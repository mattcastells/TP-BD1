USE [TPODB];
GO

/*
Consultas de práctica (15) con distintos niveles de complejidad.
*/
-- 1) Total pagado por cliente
SELECT c.id_cliente, c.nombre, c.apellido,
       SUM(p.monto) AS total_pagado,
       COUNT(DISTINCT f.id_factura) AS facturas
FROM dbo.clientes c
JOIN dbo.vehiculos v ON v.id_cliente = c.id_cliente
JOIN dbo.ordenes_trabajo o ON o.id_vehiculo = v.id_vehiculo
JOIN dbo.facturas f ON f.id_orden = o.id_orden
JOIN dbo.pagos p ON p.id_factura = f.id_factura
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY total_pagado DESC;
GO

-- 2) Ordenes abiertas y dias desde ingreso
SELECT o.id_orden, e.descripcion AS estado,
       c.apellido + ', ' + c.nombre AS cliente,
       v.patente,
       DATEDIFF(day, o.fecha_ingreso, SYSDATETIME()) AS dias_abierta
FROM dbo.ordenes_trabajo o
JOIN dbo.estados_orden e ON e.id_estado = o.id_estado
JOIN dbo.vehiculos v ON v.id_vehiculo = o.id_vehiculo
JOIN dbo.clientes c ON c.id_cliente = v.id_cliente
WHERE e.descripcion IN ('Pendiente', 'En proceso')
ORDER BY dias_abierta DESC;
GO

-- 3) Servicios mas solicitados
SELECT s.id_servicio, s.descripcion,
       COUNT(*) AS veces,
       AVG(d.precio) AS precio_promedio
FROM dbo.detalle_orden d
JOIN dbo.servicios s ON s.id_servicio = d.id_servicio
GROUP BY s.id_servicio, s.descripcion
ORDER BY veces DESC;
GO

-- 4) Clientes sin ordenes registradas
SELECT c.id_cliente, c.nombre, c.apellido, c.dni
FROM dbo.clientes c
LEFT JOIN dbo.vehiculos v ON v.id_cliente = c.id_cliente
LEFT JOIN dbo.ordenes_trabajo o ON o.id_vehiculo = v.id_vehiculo
WHERE o.id_orden IS NULL;
GO

-- 5) Repuestos con bajo stock en sucursales
SELECT s.nombre AS sucursal, r.nombre AS repuesto, ss.cantidad
FROM dbo.stock_sucursal ss
JOIN dbo.sucursales s ON s.id_sucursal = ss.id_sucursal
JOIN dbo.repuestos r ON r.id_repuesto = ss.id_repuesto
WHERE ss.cantidad < 5
ORDER BY ss.cantidad, s.nombre;
GO

-- 6) Stock total por repuesto (almacen + sucursal)
SELECT r.id_repuesto, r.nombre,
       ISNULL(sa.total_almacen, 0) AS total_almacen,
       ISNULL(ss.total_sucursal, 0) AS total_sucursal,
       ISNULL(sa.total_almacen, 0) + ISNULL(ss.total_sucursal, 0) AS total
FROM dbo.repuestos r
LEFT JOIN (
    SELECT id_repuesto, SUM(cantidad) AS total_almacen
    FROM dbo.stock_almacen
    GROUP BY id_repuesto
) sa ON sa.id_repuesto = r.id_repuesto
LEFT JOIN (
    SELECT id_repuesto, SUM(cantidad) AS total_sucursal
    FROM dbo.stock_sucursal
    GROUP BY id_repuesto
) ss ON ss.id_repuesto = r.id_repuesto
ORDER BY total DESC;
GO

-- 7) Facturacion mensual
SELECT DATEFROMPARTS(YEAR(fecha), MONTH(fecha), 1) AS mes,
       SUM(total) AS total_facturado,
       COUNT(*) AS cantidad_facturas
FROM dbo.facturas
GROUP BY DATEFROMPARTS(YEAR(fecha), MONTH(fecha), 1)
ORDER BY mes;
GO

-- 8) Duracion de ordenes finalizadas (en horas)
SELECT o.id_orden, e.descripcion AS estado,
       DATEDIFF(hour, o.fecha_ingreso, o.fecha_egreso) AS horas
FROM dbo.ordenes_trabajo o
JOIN dbo.estados_orden e ON e.id_estado = o.id_estado
WHERE o.fecha_egreso IS NOT NULL
ORDER BY horas DESC;
GO

-- 9) Productividad por mecanico
SELECT m.id_mecanico, m.nombre, m.apellido,
       COUNT(o.id_orden) AS ordenes,
       AVG(DATEDIFF(hour, o.fecha_ingreso, o.fecha_egreso)) AS prom_horas
FROM dbo.mecanicos m
LEFT JOIN dbo.ordenes_trabajo o ON o.id_mecanico = m.id_mecanico
GROUP BY m.id_mecanico, m.nombre, m.apellido
ORDER BY ordenes DESC;
GO

-- 10) Servicios no utilizados en ninguna orden
SELECT s.id_servicio, s.descripcion
FROM dbo.servicios s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.detalle_orden d
    WHERE d.id_servicio = s.id_servicio
);
GO

-- 11) Turnos en los proximos 7 dias
SELECT t.id_turno, t.fecha, t.hora, t.estado,
       s.nombre AS sucursal,
       c.apellido + ', ' + c.nombre AS cliente,
       v.patente
FROM dbo.turnos t
JOIN dbo.sucursales s ON s.id_sucursal = t.id_sucursal
JOIN dbo.clientes c ON c.id_cliente = t.id_cliente
JOIN dbo.vehiculos v ON v.id_vehiculo = t.id_vehiculo
WHERE t.fecha BETWEEN CAST(GETDATE() AS date) AND DATEADD(day, 7, CAST(GETDATE() AS date))
ORDER BY t.fecha, t.hora;
GO

-- 12) Clientes con facturacion mayor o igual a un umbral
SELECT c.id_cliente, c.nombre, c.apellido,
       SUM(f.total) AS total_facturado
FROM dbo.clientes c
JOIN dbo.vehiculos v ON v.id_cliente = c.id_cliente
JOIN dbo.ordenes_trabajo o ON o.id_vehiculo = v.id_vehiculo
JOIN dbo.facturas f ON f.id_orden = o.id_orden
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING SUM(f.total) >= 50000
ORDER BY total_facturado DESC;
GO

-- 13) Comparacion de total calculado vs total facturado
WITH totales AS (
    SELECT id_orden, SUM(precio) AS total_calculado
    FROM dbo.detalle_orden
    GROUP BY id_orden
)
SELECT o.id_orden, t.total_calculado, f.total AS total_factura,
       t.total_calculado - f.total AS diferencia
FROM totales t
JOIN dbo.facturas f ON f.id_orden = t.id_orden
JOIN dbo.ordenes_trabajo o ON o.id_orden = t.id_orden;
GO

-- 14) Compras por proveedor (total por pedidos)
SELECT p.id_proveedor, p.nombre,
       SUM(dp.cantidad * dp.precio_unitario) AS total_compras,
       COUNT(DISTINCT pr.id_pedido) AS pedidos
FROM dbo.proveedores p
JOIN dbo.pedido_repuesto pr ON pr.id_proveedor = p.id_proveedor
JOIN dbo.detalle_pedido_repuesto dp ON dp.id_pedido = pr.id_pedido
GROUP BY p.id_proveedor, p.nombre
ORDER BY total_compras DESC;
GO

-- 15) Ultima orden por vehiculo
SELECT v.id_vehiculo, v.patente,
       c.apellido + ', ' + c.nombre AS cliente,
       oa.fecha_ingreso AS ultima_visita,
       oa.estado
FROM dbo.vehiculos v
JOIN dbo.clientes c ON c.id_cliente = v.id_cliente
OUTER APPLY (
    SELECT TOP (1) o.fecha_ingreso, e.descripcion AS estado
    FROM dbo.ordenes_trabajo o
    JOIN dbo.estados_orden e ON e.id_estado = o.id_estado
    WHERE o.id_vehiculo = v.id_vehiculo
    ORDER BY o.fecha_ingreso DESC
) oa
ORDER BY v.patente;
GO

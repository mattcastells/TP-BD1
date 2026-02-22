USE [TPODB];
GO

/*
Inserta datos de ejemplo para practicar consultas.
*/
SET NOCOUNT ON;
GO

-- Sucursales
INSERT INTO dbo.sucursales (nombre, direccion, telefono) VALUES
('Centro', 'Calle 1 123', '1111-1111'),
('Norte', 'Av. Norte 456', '2222-2222'),
('Sur', 'Av. Sur 789', '3333-3333');
GO

-- Clientes
INSERT INTO dbo.clientes (nombre, apellido, dni, telefono, email, fecha_registro) VALUES
('Juan', 'Perez', '30111222', '341-111111', 'juan.perez@mail.com', '2025-12-01'),
('Maria', 'Lopez', '30222333', '341-222222', 'maria.lopez@mail.com', '2025-12-05'),
('Carlos', 'Gomez', '30333444', '341-333333', 'carlos.gomez@mail.com', '2025-12-10'),
('Ana', 'Torres', '30444555', '341-444444', 'ana.torres@mail.com', '2025-12-12'),
('Luis', 'Martinez', '30555666', '341-555555', 'luis.martinez@mail.com', '2025-12-15'),
('Sofia', 'Diaz', '30666777', '341-666666', 'sofia.diaz@mail.com', '2025-12-20'),
('Pedro', 'Ruiz', '30777888', '341-777777', 'pedro.ruiz@mail.com', '2025-12-22'),
('Laura', 'Romero', '30888999', '341-888888', 'laura.romero@mail.com', '2025-12-24'),
('Martin', 'Silva', '30999000', '341-999999', 'martin.silva@mail.com', '2025-12-26'),
('Paula', 'Fernandez', '31000111', '341-000111', 'paula.fernandez@mail.com', '2025-12-28');
GO

-- Marcas
INSERT INTO dbo.marcas (nombre) VALUES
('Ford'),
('Toyota'),
('Volkswagen'),
('Chevrolet');
GO

-- Vehiculos
INSERT INTO dbo.vehiculos (patente, modelo, anio, kilometraje, id_cliente, id_marca) VALUES
('AA111AA', 'Fiesta', 2015, 85000, 1, 1),
('AB222BB', 'Corolla', 2018, 60000, 2, 2),
('AC333CC', 'Gol', 2012, 120000, 3, 3),
('AD444DD', 'Cruze', 2019, 50000, 4, 4),
('AE555EE', 'Hilux', 2017, 90000, 5, 2),
('AF666FF', 'Focus', 2014, 130000, 6, 1),
('AG777GG', 'Onix', 2020, 30000, 7, 4),
('AH888HH', 'Golf', 2016, 80000, 8, 3),
('AI999II', 'Etios', 2013, 110000, 9, 2),
('AJ101JJ', 'Ranger', 2021, 40000, 10, 1);
GO

-- Mecanicos
INSERT INTO dbo.mecanicos (nombre, apellido, especialidad, telefono, fecha_contratacion, id_sucursal) VALUES
('Diego', 'Rojas', 'Motor', '341-101010', '2018-03-10', 1),
('Pablo', 'Vega', 'Electricidad', '341-202020', '2019-07-05', 1),
('Martin', 'Luna', 'Frenos', '341-303030', '2020-02-12', 2),
('Natalia', 'Soto', 'Suspension', '341-404040', '2017-11-20', 2),
('Lucia', 'Ortiz', 'General', '341-505050', '2021-01-15', 3);
GO

-- Servicios
INSERT INTO dbo.servicios (descripcion, precio_base, duracion_estimada) VALUES
('Cambio de aceite', 12000, 60),
('Alineacion y balanceo', 18000, 90),
('Frenos', 25000, 120),
('Diagnostico electronico', 15000, 60),
('Reparacion motor', 120000, 480),
('Limpieza inyectores', 22000, 90);
GO

-- Estados de orden
INSERT INTO dbo.estados_orden (descripcion) VALUES
('Pendiente'),
('En proceso'),
('Finalizada'),
('Cancelada');
GO

-- Almacenes
INSERT INTO dbo.almacen (nombre, direccion) VALUES
('Central', 'Parque Industrial 100'),
('Secundario', 'Ruta 9 Km 12');
GO

-- Repuestos
INSERT INTO dbo.repuestos (nombre, id_marca, precio_unitario) VALUES
('Filtro aceite', 1, 3500),
('Pastillas freno', 4, 15000),
('Bujias', 1, 8000),
('Correa distribucion', 2, 45000),
('Amortiguador', 3, 60000),
('Bateria', 4, 90000),
('Aceite 10W40', 2, 5000),
('Kit embrague', 1, 110000);
GO

-- Stock en almacen
INSERT INTO dbo.stock_almacen (id_almacen, id_repuesto, cantidad) VALUES
(1, 1, 40),
(1, 2, 25),
(1, 3, 50),
(1, 4, 15),
(1, 5, 10),
(2, 2, 12),
(2, 6, 8),
(2, 7, 60),
(2, 8, 5);
GO

-- Stock en sucursal
INSERT INTO dbo.stock_sucursal (id_sucursal, id_repuesto, cantidad) VALUES
(1, 1, 6),
(1, 2, 4),
(1, 7, 10),
(2, 3, 5),
(2, 5, 2),
(2, 6, 3),
(3, 4, 1),
(3, 8, 2);
GO

-- Proveedores
INSERT INTO dbo.proveedores (nombre, telefono, email, direccion) VALUES
('Autopartes SA', '011-4000-1000', 'ventas@autopartessa.com', 'Av. Industria 500'),
('Repuestos Delta', '011-4000-2000', 'contacto@delta.com', 'Calle 8 220'),
('MotorPlus', '011-4000-3000', 'ventas@motorplus.com', 'Av. Taller 900');
GO

-- Proveedor por repuesto
INSERT INTO dbo.proveedor_repuesto (id_proveedor, id_repuesto, precio_referencia) VALUES
(1, 1, 3000),
(1, 2, 14000),
(2, 4, 42000),
(2, 5, 57000),
(3, 6, 85000),
(3, 8, 105000),
(3, 7, 4500);
GO

-- Pedidos a proveedores
INSERT INTO dbo.pedido_repuesto (fecha, estado, id_proveedor, id_almacen) VALUES
('2026-02-01 09:00', 'Enviado', 1, 1),
('2026-02-05 11:30', 'Recibido', 2, 1),
('2026-02-10 08:15', 'Pendiente', 3, 2);
GO

-- Detalle de pedidos
INSERT INTO dbo.detalle_pedido_repuesto (id_pedido, id_repuesto, cantidad, precio_unitario) VALUES
(1, 1, 20, 2900),
(1, 2, 10, 13500),
(2, 4, 6, 41000),
(2, 5, 4, 56000),
(3, 6, 5, 84000),
(3, 7, 30, 4300),
(3, 8, 2, 102000);
GO

-- Solicitudes de repuesto
INSERT INTO dbo.solicitud_repuesto (fecha, estado, id_sucursal, id_almacen) VALUES
('2026-02-03 10:00', 'Pendiente', 1, 1),
('2026-02-06 12:00', 'En proceso', 2, 1),
('2026-02-08 15:00', 'Enviada', 3, 2);
GO

-- Detalle de solicitudes
INSERT INTO dbo.detalle_solicitud (id_solicitud, id_repuesto, cantidad) VALUES
(1, 2, 4),
(1, 7, 8),
(2, 5, 2),
(3, 8, 1);
GO

-- Ordenes de trabajo
INSERT INTO dbo.ordenes_trabajo (fecha_ingreso, fecha_egreso, observaciones, id_vehiculo, id_mecanico, id_sucursal, id_estado) VALUES
('2026-02-02 09:00', '2026-02-03 17:30', 'Servicio completo', 1, 1, 1, 3),
('2026-02-04 10:00', NULL, 'Revisar frenos', 2, 3, 2, 2),
('2026-02-05 08:30', '2026-02-05 12:00', 'Cambio de aceite', 3, 2, 1, 3),
('2026-02-06 14:00', '2026-02-07 16:00', 'Motor ruidoso', 4, 1, 1, 3),
('2026-02-10 09:15', NULL, 'Diagnostico', 5, 4, 2, 1),
('2026-02-12 11:00', '2026-02-12 13:00', 'Alineacion', 6, 5, 3, 3);
GO

-- Detalle de ordenes
INSERT INTO dbo.detalle_orden (id_orden, id_servicio, precio) VALUES
(1, 1, 12000),
(1, 2, 18000),
(1, 6, 22000),
(2, 3, 26000),
(3, 1, 12000),
(3, 4, 15000),
(4, 5, 125000),
(5, 4, 15000),
(6, 2, 18000);
GO

-- Facturas
INSERT INTO dbo.facturas (fecha, total, id_orden) VALUES
('2026-02-03 18:00', 52000, 1),
('2026-02-05 12:30', 27000, 3),
('2026-02-07 16:30', 125000, 4),
('2026-02-12 13:30', 18000, 6);
GO

-- Pagos
INSERT INTO dbo.pagos (fecha, monto, medio_pago, id_factura) VALUES
('2026-02-03 19:00', 30000, 'Tarjeta', 1),
('2026-02-04 10:00', 22000, 'Efectivo', 1),
('2026-02-05 13:00', 27000, 'Debito', 2),
('2026-02-07 17:00', 125000, 'Transferencia', 3),
('2026-02-12 14:00', 18000, 'Efectivo', 4);
GO

-- Reclamos
INSERT INTO dbo.reclamos (fecha, descripcion, estado, id_cliente, id_vehiculo) VALUES
('2026-02-08 09:00', 'Ruido persistente', 'Abierto', 2, 2),
('2026-02-15 10:30', 'Fuga de aceite', 'Cerrado', 1, 1);
GO

-- Presupuestos
INSERT INTO dbo.presupuestos (fecha, estado, total_estimado, id_cliente) VALUES
('2026-02-09 11:00', 'Pendiente', 65000, 7),
('2026-02-11 16:00', 'Aprobado', 80000, 8),
('2026-02-13 09:30', 'Rechazado', 27000, 9);
GO

-- Detalle de presupuestos
INSERT INTO dbo.detalle_presupuesto (id_presupuesto, id_servicio, precio_estimado) VALUES
(1, 3, 25000),
(1, 2, 18000),
(1, 6, 22000),
(2, 5, 80000),
(3, 1, 12000),
(3, 4, 15000);
GO

-- Turnos
INSERT INTO dbo.turnos (fecha, hora, estado, id_cliente, id_vehiculo, id_sucursal) VALUES
('2026-02-20', '09:00', 'Confirmado', 1, 1, 1),
('2026-02-20', '11:00', 'Confirmado', 2, 2, 2),
('2026-02-21', '10:30', 'Pendiente', 3, 3, 1),
('2026-02-22', '15:00', 'Confirmado', 4, 4, 1),
('2026-02-24', '09:30', 'Cancelado', 5, 5, 2),
('2026-02-25', '16:00', 'Confirmado', 6, 6, 3);
GO

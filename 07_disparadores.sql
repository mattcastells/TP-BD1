USE [TPODB];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

/*
Triggers de automatización y validación básica.
*/

/* 1) Completar fecha_egreso cuando una orden pasa a Finalizada */
CREATE OR ALTER TRIGGER dbo.tr_ordenes_trabajo_set_fecha_egreso
ON dbo.ordenes_trabajo
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE o
    SET fecha_egreso = COALESCE(o.fecha_egreso, SYSDATETIME())
    FROM dbo.ordenes_trabajo o
    JOIN inserted i ON i.id_orden = o.id_orden
    JOIN dbo.estados_orden e ON e.id_estado = i.id_estado
    WHERE e.descripcion = N'Finalizada'
      AND o.fecha_egreso IS NULL;
END
GO

/* 2) Recalcular total de factura si cambia el detalle de la orden */
CREATE OR ALTER TRIGGER dbo.tr_detalle_orden_recalcular_factura
ON dbo.detalle_orden
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH afectados AS (
        SELECT id_orden FROM inserted
        UNION
        SELECT id_orden FROM deleted
    ),
    totales AS (
        SELECT a.id_orden, SUM(d.precio) AS total
        FROM afectados a
        LEFT JOIN dbo.detalle_orden d ON d.id_orden = a.id_orden
        GROUP BY a.id_orden
    )
    UPDATE f
    SET total = ISNULL(t.total, 0)
    FROM dbo.facturas f
    JOIN totales t ON t.id_orden = f.id_orden;
END
GO

/* 3) Evitar que los pagos superen el total de la factura */
CREATE OR ALTER TRIGGER dbo.tr_pagos_evitar_sobrepago
ON dbo.pagos
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM (
            SELECT id_factura FROM inserted
            UNION
            SELECT id_factura FROM deleted
        ) a
        JOIN dbo.facturas f ON f.id_factura = a.id_factura
        CROSS APPLY (
            SELECT SUM(p.monto) AS total_pagado
            FROM dbo.pagos p
            WHERE p.id_factura = a.id_factura
        ) s
        WHERE s.total_pagado > f.total
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, 'El total de pagos supera el total de la factura.', 1;
    END
END
GO

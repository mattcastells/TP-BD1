/*
Crea la base de datos TPODB (si no existe) y la selecciona.
*/
IF DB_ID(N'TPODB') IS NULL
BEGIN
    CREATE DATABASE [TPODB];
END
GO

USE [TPODB];
GO

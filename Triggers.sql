------------------------DDL----------------------------------------
-- Crear el trigger
CREATE TRIGGER trg_AfterCreateTable
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Se ha creado una nueva tabla en la base de datos.'
END;

-- Ejecutar un ejemplo de creación de tabla
CREATE TABLE EjemploTabla (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(100)
);
---------------------------------------------------------------
-- Crear el trigger
CREATE TRIGGER trg_AfterDropTable
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'Se ha eliminado una tabla de la base de datos.'
END;

-- Ejecutar un ejemplo de eliminación de tabla
DROP TABLE EjemploTabla;
--------------------------DML------------------------------------
-- Crear el trigger
CREATE TRIGGER trg_AfterInsertUsuarios
ON Usuarios
AFTER INSERT
AS
BEGIN
    DECLARE @UsuarioID INT, @Nombre NVARCHAR(100);
    SELECT @UsuarioID = INSERTED.UsuarioID, @Nombre = INSERTED.Nombre FROM INSERTED;
    PRINT 'Se ha insertado un nuevo usuario: ' + @Nombre + ' con ID: ' + CAST(@UsuarioID AS NVARCHAR(10));
END;

-- Ejecutar un ejemplo de inserción en la tabla Usuarios
INSERT INTO Usuarios (Nombre, Email, Pass) VALUES ('Mario Bros', 'mario.bros@gmail.com', 'mario123');
------------------------------------------------------------------------------------------
-- Crear el trigger
CREATE TRIGGER trg_AfterUpdateSuscripciones
ON Suscripciones
AFTER UPDATE
AS
BEGIN
    DECLARE @UsuarioID INT, @FechaFin DATE;
    SELECT @UsuarioID = INSERTED.UsuarioID, @FechaFin = INSERTED.FechaFin FROM INSERTED;
    PRINT 'Se ha actualizado la suscripción del usuario con ID: ' + CAST(@UsuarioID AS NVARCHAR(10)) + '. Nueva fecha de fin: ' + CAST(@FechaFin AS NVARCHAR(10));
END;

-- Ejecutar un ejemplo de actualización en la tabla Suscripciones
UPDATE Suscripciones SET FechaFin = '2024-12-31' WHERE UsuarioID = 1;
SELECT * FROM Suscripciones
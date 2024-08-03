CREATE TRIGGER trigger_Afterinsertarcliente
ON Clientes 
AFTER INSERT
AS
BEGIN
    DECLARE @ClienteID INT, @Nombre NVARCHAR(100);
    SELECT @ClienteID = INSERTED.ClienteID, @Nombre = INSERTED.Nombre FROM INSERTED;
    PRINT 'Se ha insertado un nuevo Cliente: ' + @Nombre + ' con ID: ' + CAST(@ClienteID AS NVARCHAR(10));
END;


INSERT INTO Clientes(Nombre, Direccion, Telefono,Email) VALUES ('Bladimir Reyes ', 'Francisco Villa', '4424503922','bladimirreyes2132@gmail.com');
SELECT * FROM Clientes
-------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER trigger_AfterEliminarCliente
ON Clientes
AFTER DELETE
AS
BEGIN
    DECLARE @ClienteID INT, @Nombre NVARCHAR(100);
    SELECT @ClienteID = ClienteID, @Nombre = Nombre FROM DELETED;
    PRINT 'Se ha eliminado un Cliente: ' + @Nombre + ' con ID: ' + CAST(@ClienteID AS NVARCHAR);
END;

DELETE FROM Clientes WHERE ClienteID = 7;
------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER trigger_cuentaexistente
ON Cuentas
INSTEAD OF UPDATE
AS
BEGIN
    DECLARE @CuentaID INT, @NuevoSaldo DECIMAL(18, 2);
	

    SELECT @CuentaID = CuentaID, @NuevoSaldo = Saldo
    FROM INSERTED;

    IF @NuevoSaldo < 0
    BEGIN
        PRINT 'Error: No se puede actualizar la cuenta con ID ' + CAST(@CuentaID AS NVARCHAR) + ' a un saldo negativo.';
    END
    ELSE
    BEGIN
        UPDATE Cuentas
        SET ClienteID = i.ClienteID,
            Tipocuenta = i.Tipocuenta,
            Saldo = i.Saldo,
            FechaApertura = i.FechaApertura
        FROM INSERTED i
        WHERE Cuentas.CuentaID = i.CuentaID;
        
        PRINT 'La cuenta con ID ' + CAST(@CuentaID AS NVARCHAR) + ' ha sido actualizada exitosamente.';
    END
END;


-------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER trigger_SaldoNegativo
ON Cuentas
INSTEAD OF UPDATE
AS
BEGIN
DECLARE @CuentaID INT, @NuevoSaldo DECIMAL(18, 2);
SELECT @CuentaID = CuentaID, @NuevoSaldo = Saldo
FROM INSERTED;
IF @NuevoSaldo < 0
BEGIN
PRINT 'Error: No se puede actualizar la cuenta con ID ' + CAST(@CuentaID AS NVARCHAR) + ' a un saldo negativo.';
END
ELSE
BEGIN
UPDATE Cuentas
SET ClienteID = i.ClienteID,
Tipocuenta = i.Tipocuenta,
Saldo = i.Saldo,
FechaApertura = i.FechaApertura
FROM INSERTED i
WHERE Cuentas.CuentaID = i.CuentaID;
PRINT 'La cuenta con ID ' + CAST(@CuentaID AS NVARCHAR) + ' ha sido actualizada exitosamente.';
END
END;
;
UPDATE Cuentas
SET Saldo = 300.00
WHERE CuentaID = 1;


UPDATE Cuentas
SET Saldo = -100.00
WHERE CuentaID = 1;
------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER triggerEliminarPrestamo
ON Prestamos
AFTER DELETE
AS
BEGIN
IF EXISTS (SELECT 1 FROM PagosPrestamos WHERE PrestamoID IN (SELECT PrestamoID FROM DELETED))
BEGIN
RAISERROR('No se puede eliminar el préstamo porque tiene pagos asociados.', 16, 1);
ROLLBACK TRANSACTION;
END
END

DELETE FROM Prestamos WHERE PrestamoID = 1;

select *from Prestamos
--------------------------------------------------------------------------------------------------------------------
CREATE TABLE logClientes (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Operacion NVARCHAR(10),
    FechaHora DATETIME DEFAULT GETDATE()
);
-----------------------------------------------------------------------------------------------------

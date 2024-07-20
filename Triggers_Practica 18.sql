-- Crear el trigger
CREATE TRIGGER Trigger_Crear_tabla
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Se ha creado una nueva tabla en DBBank.'
END;

--------------------------------------------------------
SELECT*FROM Clientes
CREATE TABLE Prestamos (
PrestamoID INT IDENTITY (1,1) PRIMARY KEY,
ClienteID INT,
Monto DECIMAL (18, 2), 
TasaInteres DECIMAL (5, 2),
FechaInicio DATE,
FechaFin DATE,
FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);
INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin)
VALUES 
    (1, 10000.00, 5.75, '2023-01-01', '2025-01-01'),
    (3, 20000.00, 6.00, '2023-03-01', '2027-03-01'),
    (4, 25000.00, 4.25, '2023-04-01', '2028-04-01');

------------------------------------------------------------
SELECT * FROM Prestamos
CREATE TABLE PagosPrestamos (
PagoID INT IDENTITY(1,1) PRIMARY KEY,
PrestamoID INT,
MontoPagado DECIMAL (18, 2),
FechaPago DATE,
FOREIGN KEY (PrestamoID) REFERENCES Prestamos(PrestamoID)
);
INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago)
VALUES 
    (3, 1000.00, '2023-01-15'),
    (4, 2000.00, '2023-03-10'),
    (5, 2500.00, '2023-04-05');
-----------------------------------------------------------------
CREATE TRIGGER Trigger_Procedimiento_Creado
ON DATABASE
FOR CREATE_PROCEDURE
AS
BEGIN
    PRINT 'Se ha creado un Nuevo Procedimiento en DBBANK.';
END;
------------------------------------------------------------------
CREATE PROCEDURE InsertarPrestamoYPrimerPago
    @ClienteID INT,
    @Monto DECIMAL(18, 2),
    @TasaInteres DECIMAL(5, 2),
    @FechaInicio DATE,
    @FechaFin DATE,
    @MontoPagado DECIMAL(18, 2),
    @FechaPago DATE
AS
BEGIN
    -- Inicia una transacción
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Inserta el nuevo préstamo
        INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin)
        VALUES (@ClienteID, @Monto, @TasaInteres, @FechaInicio, @FechaFin);
        
        -- Obtiene el ID del préstamo recién insertado
        DECLARE @PrestamoID INT;
        SET @PrestamoID = SCOPE_IDENTITY();
        
        -- Inserta el primer pago del préstamo
        INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago)
        VALUES (@PrestamoID, @MontoPagado, @FechaPago);
        
        -- Confirma la transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
    END CATCH
END;


EXEC InsertarPrestamoYPrimerPago
    @ClienteID = 3,
    @Monto = 10000.00,
    @TasaInteres = 5.75,
    @FechaInicio = '2023-07-01',
    @FechaFin = '2026-07-01',
    @MontoPagado = 500.00,
    @FechaPago = '2023-07-15';


EXEC InsertarPrestamoYPrimerPago
    @ClienteID = 4,
    @Monto = 15000.00,
    @TasaInteres = 4.50,
    @FechaInicio = '2023-08-01',
    @FechaFin = '2027-08-01',
    @MontoPagado = 750.00,
    @FechaPago = '2023-08-15';

---------------------------------------------------------------------------------
CREATE PROCEDURE ConsultarClientes
AS
BEGIN
    SELECT 
        c.ClienteID,
        c.Nombre,
        p.PrestamoID,
        p.Monto AS MontoPrestamo,
        p.TasaInteres,
        p.FechaInicio,
        p.FechaFin,
        pp.PagoID,
        pp.MontoPagado,
        pp.FechaPago
    FROM 
        Clientes c
    INNER JOIN 
        Prestamos p ON c.ClienteID = p.ClienteID
    LEFT JOIN 
        PagosPrestamos pp ON p.PrestamoID = pp.PrestamoID
    ORDER BY 
        c.ClienteID, p.PrestamoID, pp.FechaPago;
END;


EXEC ConsultarClientes;

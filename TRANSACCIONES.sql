CREATE PROCEDURE sp_agregarSuscripcion
@usuario_id INT,
@fecha_inicio DATE,
@fecha_fin DATE,
@tipo NVARCHAR(50)
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
INSERT INTO Suscripciones(UsuarioID,FechaInicio,FechaFin,Tipo)VALUES(@usuario_id, @fecha_inicio, @fecha_fin, @tipo);
UPDATE Usuarios SET FechaRegistro = @fecha_inicio WHERE UsuarioID = @usuario_id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;



EXEC sp_agregarSuscripcion @usuario_id =1, @fecha_inicio ='2024-07-01',@fecha_fin = '2024-08-01', @tipo = 'Premium'

SELECT*FROM Suscripciones
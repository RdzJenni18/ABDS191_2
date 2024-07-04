USE PlataformaStreaming;

CREATE PROCEDURE sp_AgregarPelicula
@titulo NVARCHAR(100),
@genero NVARCHAR(50),
@fechaEstreno DATE,
@usuario_id INT
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
INSERT INTO Peliculas(Titulo,Genero,FechaEstreno)VALUES(@titulo, @genero,@fechaEstreno);

DECLARE @pelicula_id int;
set @pelicula_id= SCOPE_IDENTITY();

INSERT INTO HistorialVisualizacion(UsuarioID,PeliculaID)
VALUES (@usuario_id,@pelicula_id);

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_AgregarPelicula @titulo = 'Avatar', @genero ='Accion',@fechaEstreno = '2024-12-19',@usuario_id = 1
EXEC sp_AgregarPelicula @titulo = 'Dune: Part Two', @genero = 'Ciencia ficcion', @fechaEstreno = '2024-03-14', @usuario_id = 4
EXEC sp_AgregarPelicula @titulo = 'Mission:Impossible' , @genero ='Accion', @fechaEstreno = '2024-06-28', @usuario_id = 8
select*from Peliculas;
select*from HistorialVisualizacion;

--------------------------------------------------------------------------------------------------
CREATE PROCEDURE sp_AgregarUsuario
@nombre NVARCHAR(100),
@email  NVARCHAR(100),
@pass NVARCHAR(100),
@fechaRegistro DATE,
@pelicula_id INT,
@fechaVisualizacion DATETIME,
@fechaInicio DATE,
@fechaFin DATE,
@Tipo NVARCHAR (50)
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
INSERT INTO Usuarios(Nombre,Email,Pass,FechaRegistro) VALUES (@nombre,@email,@pass,@fechaRegistro)

DECLARE @usuario_id	INT;
SET @usuario_id= SCOPE_IDENTITY();

INSERT INTO Suscripciones(UsuarioID,Tipo,FechaInicio,FechaFin)
VALUES (@usuario_id,@Tipo,@fechaInicio, @fechaFin);

INSERT INTO HistorialVisualizacion(UsuarioID,PeliculaID,FechaVisualizacion)
VALUES (@usuario_id,@pelicula_id, @fechaVisualizacion);
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_AgregarUsuario  @nombre = 'Juana',
    @email = 'juana.araujo@gmail.com',
    @pass = 'juana123',
    @fechaRegistro = '2024-07-04',
    @pelicula_id = 1,
    @fechaVisualizacion = '2024-07-04 14:30:00',
    @fechaInicio = '2024-07-04',
    @fechaFin = '2025-07-04',
    @tipo = 'Premium';

EXEC sp_AgregarUsuario  @nombre = 'Carlos Luna',
    @email = 'carlos.luna@gmail.com',
    @pass = 'carla123',
    @fechaRegistro = '2024-07-04',
    @pelicula_id = 1,
    @fechaVisualizacion = '2024-07-04 11:30:00',
    @fechaInicio = '2024-07-04',
    @fechaFin = '2025-07-04',
    @tipo = 'Básico';
	
EXEC sp_AgregarUsuario  @nombre = 'Karla Resendiz',
    @email = 'Karla.resendiz@gmail.com',
    @pass = 'Karla123',
    @fechaRegistro = '2024-07-04',
    @pelicula_id = 3,
    @fechaVisualizacion = '2024-07-04 11:30:00',
    @fechaInicio = '2024-07-04',
    @fechaFin = '2025-07-04',
    @tipo = 'Premium';
SELECT * FROM Usuarios
SELECT * FROM Suscripciones
SELECT * FROM HistorialVisualizacion

------------3----------------------------------------------------------------------------------------
CREATE PROCEDURE sp_ActualizarCorreo
@usuario_id INT,
@tipo NVARCHAR(50),
@email NVARCHAR(100)
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
UPDATE Usuarios SET Email = @email WHERE UsuarioID =@usuario_id;
UPDATE Suscripciones SET Tipo = @tipo WHERE UsuarioID = @usuario_id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_ActualizarCorreo @usuario_id = 1,@tipo = 'Basico', @email = 'lopez@gmail.com';
EXEC sp_ActualizarCorreo @usuario_id = 3,@tipo = 'Basico', @email = 'martinez@gmail.com';
EXEC sp_ActualizarCorreo @usuario_id = 16,@tipo = 'Basico', @email = 'Karla@gmail.com';

SELECT * FROM Usuarios
SELECT * FROM Suscripciones
-----------------4-------------------------------------------------------------------------------------
CREATE PROCEDURE sp_EliminarPelicula
@pelicula_id INT
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
DELETE FROM HistorialVisualizacion WHERE PeliculaID =@pelicula_id;
DELETE FROM Peliculas WHERE PeliculaID = @pelicula_id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_EliminarPelicula @pelicula_id = 2;
EXEC sp_EliminarPelicula @pelicula_id = 4;
EXEC sp_EliminarPelicula @pelicula_id = 6;


SELECT * FROM Peliculas
SELECT * FROM HistorialVisualizacion

----------------------------5------------------------------------------------------------------------------------
CREATE PROCEDURE sp_EliminarSuscripciones
@usuario_id INT
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
DELETE FROM HistorialVisualizacion WHERE UsuarioID =@usuario_id;
DELETE FROM Suscripciones  WHERE UsuarioID= @usuario_id;
DELETE FROM Usuarios WHERE UsuarioID = @usuario_id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_EliminarSuscripciones @usuario_id = 2;
EXEC sp_EliminarSuscripciones @usuario_id = 4;
EXEC sp_EliminarSuscripciones @usuario_id = 6;


SELECT * FROM Suscripciones
SELECT * FROM HistorialVisualizacion
SELECT * FROM Usuarios

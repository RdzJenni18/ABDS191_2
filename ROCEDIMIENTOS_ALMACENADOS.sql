--INSERTAR
CREATE PROCEDURE sp_InsertarUsuarios 
@nombre NVARCHAR(100),
@email NVARCHAR(100),
@pass NVARCHAR(100),
@fechaRegistro DATE
AS
BEGIN
INSERT INTO Usuarios(Nombre, Email, Pass, FechaRegistro)VALUES( @nombre, @email, @pass,@fechaRegistro)

END;

EXEC sp_InsertarUsuarios @nombre = 'Bladimir Reyes', @email='bladimir.reyes@gmail.com', @pass = 'bladi123', @fechaRegistro ='2024-06-26'
EXEC sp_InsertarUsuarios @nombre = 'Antonio Reyes', @email= 'antonio.reyes@gmail.com', @pass = 'antonio123', @fechaRegistro ='2024-06-26'
EXEC sp_InsertarUsuarios @nombre = 'Jennifer Resendiz', @email='jennifer.resendiz@gmail.com', @pass = 'jenni123', @fechaRegistro ='2024-06-26'

select*from Usuarios

--EDITAR
CREATE PROCEDURE sp_editarSuscripcion 
@usuario_id INT,
@tipo NVARCHAR(50)
AS
BEGIN
UPDATE Suscripciones SET Tipo = @tipo
WHERE UsuarioID = @usuario_id
END;

EXEC sp_editarSuscripcion @tipo = 'Básico', @usuario_id = 1
EXEC sp_editarSuscripcion @tipo = 'Premium', @usuario_id = 3
EXEC sp_editarSuscripcion @tipo = 'Básico', @usuario_id = 6

select*from Suscripciones

--ELIMINAR
CREATE PROCEDURE sp_EliminarVisualizacion
@historial_id INT
AS
BEGIN
DELETE FROM HistorialVisualizacion
WHERE HistorialID = @historial_id
END;

EXEC sp_EliminarVisualizacion @historial_id = '6'
EXEC sp_EliminarVisualizacion @historial_id = '8'
EXEC sp_EliminarVisualizacion @historial_id = '10'

select*from HistorialVisualizacion

--CONSULTAS ---
CREATE PROCEDURE sp_ConsultaUsuarios
@tipoSuscripcion NVARCHAR(50)
AS
BEGIN
Select u.Nombre, t.tipo
From Suscripciones t
RIGHT JOIN Usuarios u ON t.UsuarioID = u.UsuarioID
WHERE Tipo= @tipoSuscripcion
END;

EXEC sp_ConsultaUsuarios @tipoSuscripcion = 'Premium'

CREATE PROCEDURE sp_ConsultaPeliculas
@generoPelicula NVARCHAR(50)
AS
BEGIN
Select u.UsuarioID, p.Titulo,p.Genero
From HistorialVisualizacion as hv
JOIN Peliculas p ON p.PeliculaID = hv.PeliculaID
JOIN Usuarios u ON u.UsuarioID = hv.UsuarioID
WHERE p.Genero = @generoPelicula
END;

EXEC sp_ConsultaPeliculas @generoPelicula = 'Animación'

select * from HistorialVisualizacion




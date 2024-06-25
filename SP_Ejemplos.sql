--Explorar las propiedades de una BD
EXEC sp_helpdb
-- Explorar las propiedades de solo una BD
EXEC sp_helpdb 'ComicsStore'

--Explorar las propiedades de un objeto de la BD esta
EXEC sp_help 'Clientes'

--Llaves primarias de una tabla
EXEC sp_helpindex'Clientes'

--informacion de los usuarios y procesos actuales 
EXEC sp_who

--Rendimiento del servidor
EXEC sp_monitor

--Espacio utilizado por la BD
EXEC sp_spaceused

--En que puerto esta trabajando (puerto de escucha del SQL SERVER
EXEC sp_readerrorlog 0,1


--Que todo comience con sp
CREATE PROCEDURE sp_ObtenerHistorial
 @usuarioId INT
AS
BEGIN
 SELECT h.HistorialID,p.Titulo, h.FechaVisualizacion
 FROM HistorialVisualizacion h
 JOIN Peliculas p ON h.PeliculaID = p.PeliculaID
 WHERE h.UsuarioID = @usuarioId
 ORDER BY h.FechaVisualizacion DESC
END;

EXEC sp_ObtenerHistorial 1

--SP para Insertar Peliculas
-- Se tiene que declarar el valor del tipo de dato 
CREATE PROCEDURE sp_InsertarPelicula 
@titulo NVARCHAR(100),
@genero NVARCHAR(50),
@fechaEstreno DATE
AS
BEGIN
INSERT INTO Peliculas(Titulo, Genero, FechaEstreno)VALUES( @titulo, @genero, @fechaEstreno)

END;

EXEC sp_InsertarPelicula @titulo = 'Intensamente 2', @genero ='Infantil', @fechaEstreno = '2024-06-13'

select*from Peliculas





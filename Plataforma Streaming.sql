CREATE TABLE Usuarios(
	UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Email NVARCHAR (100) NOT NULL UNIQUE,
	Pass NVARCHAR (100) NOT NULL,
	FechaRegistro DATE NOT NULL DEFAULT GETDATE()
);
SELECT * FROM Usuarios;

INSERT INTO Usuarios (Nombre, Email, Pass) VALUES
	('Ana López', 'ana.lopez@gmail.com', 'ana123'),
	('Roberto García', 'roberto.garcia@gmail.com', 'roberto123'),
	('Isabel Martínez', 'isabel.martinez@gmail.com', 'isabel123'),
	('Carlos Hernández', 'carlos.hernandez@gmail.com', 'carlos123'),
	('Laura Rodríguez', 'laura.rodriguez@gmail.com', 'laura123'),
	('Javier Gómez', 'javier.gomez@gmail.com', 'javier123'),
	('Lucía Sánchez', 'lucia.sanchez@gmail.com', 'lucia123'),
	('Sergio Pérez', 'sergio.perez@gmail.com', 'sergio123'),
	('Elena García', 'elena.garcia@gmail.com', 'elena123'),
	('Antonio Martín', 'antonio.martin@gmail.com', 'antonio123');

CREATE TABLE Peliculas (
	PeliculaID INT IDENTITY (1,1) PRIMARY KEY,
	Titulo NVARCHAR (100) NOT NULL,
	Genero NVARCHAR (50),
	FechaEstreno DATE
	);

SELECT * FROM Peliculas;

INSERT INTO Peliculas (Titulo, Genero, FechaEstreno) VALUES
	('La Bella y la Bestia', 'Fantasía', '1991-11-22'),
	('Cenicienta', 'Fantasía', '1950-02-15'),
	('La Princesa y el Sapo', 'Animación', '2009-11-25'),
	('Blancanieves y los siete enanitos', 'Animación', '1937-12-21'),
	('La Sirenita', 'Animación', '1989-11-17'),
	('Enredados', 'Animación', '2010-11-24'),
	('Brave (Valiente)', 'Animación', '2012-06-22'),
	('La princesa encantada', 'Animación', '1994-05-03'),
	('La princesa prometida', 'Aventura', '1987-09-25'),
	('Encantada', 'Comedia', '2007-11-21'),
	('La princesa Mononoke', 'Animación', '1997-07-12');

CREATE TABLE Suscripciones (
	SuscripcionID INT IDENTITY(1,1) PRIMARY KEY,
	UsuarioID INT NOT NULL,
	FechaInicio DATE NOT NULL,
	FechaFin DATE,
	Tipo NVARCHAR(50),
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
	);

SELECT * FROM Suscripciones;

INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo) VALUES
(1, '2023-01-01', '2023-06-30', 'Premium'),
(2, '2023-02-15', NULL, NULL),
(3, '2023-03-20', '2023-09-30', 'Básico'),
(4, '2023-04-10', '2023-10-31', 'Premium'),
(5, '2023-05-05', '2023-11-15', 'Premium'),
(6, '2023-06-12', '2024-06-30', 'Premium'),
(7, '2023-07-20', NULL, NULL);


CREATE TABLE HistorialVisualizacion(
	HistorialID INT IDENTITY (1,1) PRIMARY KEY,
	UsuarioID INT NOT NULL,
	PeliculaID INT NOT NULL,
	FechaVisualizacion DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
	FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID)
	);

SELECT * FROM HistorialVisualizacion;

INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion) VALUES
(1, 1, '2023-01-02 18:30:00'),
(1, 2, '2023-01-03 21:15:00'),
(2, 3, '2023-02-16 14:00:00'),
(2, 4, '2023-02-17 19:45:00'),
(3, 1, '2023-03-21 20:00:00'),
(3, 5, '2023-03-25 16:30:00'),
(4, 2, '2023-04-11 22:10:00'),
(4, 6, '2023-04-12 17:20:00'),
(5, 3, '2023-05-06 19:00:00'),
(5, 7, '2023-05-08 20:45:00'),
(6, 4, '2023-06-13 15:30:00'),
(6, 8, '2023-06-15 18:00:00'),
(7, 5, '2023-07-21 21:10:00'),
(7, 9, '2023-07-22 14:45:00'),
(8, 6, '2023-08-01 16:20:00'),
(8, 10, '2023-08-03 19:30:00'),
(9, 7, '2023-09-02 22:00:00'),
(9, 11, '2023-09-05 17:10:00'),
(10, 1, '2023-10-10 20:40:00'),
(10, 2, '2023-10-12 21:00:00');


SELECT dbo.Usuarios.UsuarioID, dbo.Usuarios.Nombre AS [Nombre Usuario], dbo.Usuarios.Email, dbo.Usuarios.FechaRegistro, dbo.Usuarios.Pass, dbo.Suscripciones.SuscripcionID, dbo.Suscripciones.UsuarioID AS Expr1, dbo.Suscripciones.FechaInicio, dbo.Suscripciones.FechaFin, 
             dbo.Suscripciones.Tipo, dbo.HistorialVisualizacion.HistorialID, dbo.HistorialVisualizacion.UsuarioID AS Expr2, dbo.HistorialVisualizacion.PeliculaID, dbo.HistorialVisualizacion.FechaVisualizacion, dbo.Peliculas.PeliculaID AS Expr3, dbo.Peliculas.Titulo, dbo.Peliculas.Genero, 
             dbo.Peliculas.FechaEstreno
FROM   dbo.HistorialVisualizacion INNER JOIN
             dbo.Peliculas ON dbo.HistorialVisualizacion.PeliculaID = dbo.Peliculas.PeliculaID INNER JOIN
             dbo.Usuarios ON dbo.HistorialVisualizacion.UsuarioID = dbo.Usuarios.UsuarioID INNER JOIN
             dbo.Suscripciones ON dbo.Usuarios.UsuarioID = dbo.Suscripciones.UsuarioID

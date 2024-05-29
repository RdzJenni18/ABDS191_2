CREATE TABLE Clientes(
id_cliente bigint identity(1,1)PRIMARY KEY,
nombre VARCHAR(100),
correo_electronico NVARCHAR(255),
pass VARCHAR(255)
);
INSERT INTO Clientes (nombre, correo_electronico, pass) VALUES
('Alejandro Ramírez', 'alejandro@gmail.com', 'Alejandro123'),
('Valeria Gutiérrez', 'valeria@gmail.com', 'Valeria123'),
('Javier Fernández', 'javier@gmail.com', 'Javier123'),
('Camila Torres', 'camila@gmail.com', 'Camila123'),
('Daniel López', 'daniel@gmail.com', 'Daniel123'),
('Paula Martínez', 'paula@gmail.com', 'Paula123'),
('Andrés Sánchez', 'andres@gmail.com', 'Andres123'),
('Fernanda Pérez', 'fernanda@gmail.com', 'Fernanda123'),
('Roberto García', 'roberto@gmail.com', 'Roberto123'),
('Gabriela González', 'gabriela@gmail.com', 'Gabriela123'),
('Diego Hernández', 'diego@gmail.com', 'Diego123'),
('Natalia Díaz', 'natalia@gmail.com', 'Natalia123');
Select * from Clientes;

DROP TABLE Clientes;

CREATE TABLE Comics(
id_comic bigint identity(1,1) PRIMARY KEY,
nombre VARCHAR(100),
anio int,
precio DECIMAL(10,2)
);
Select * from Comics;
INSERT INTO Comics (nombre, anio, precio) VALUES
('Avengers: La Era de Ultrón', 2013, 16.99),
('Wonder Woman: El Círculo', 1987, 18.50),
('The Flash: Nacimiento de un Héroe', 2001, 13.25),
('Hellboy: Semilla de Destrucción', 1994, 15.75),
('Saga de Fénix Oscura', 1980, 20.99),
('Captain America: El Soldado del Invierno', 2005, 14.50),
('Justice League: La Liga de la Justicia', 1960, 19.25),
('Green Lantern: Renacimiento', 2004, 17.50),
('Spawn: El Regreso', 1992, 12.99),
('Teen Titans: Jóvenes Titanes', 1980, 11.50),
('Daredevil: El Hombre Sin Miedo', 1993, 16.75),
('The Witcher: La Sangre de los Elfos', 1994, 14.25),
('Saga de Thanos', 1973, 18.99),
('Sonic the Hedgehog: La Aventura Comienza', 1993, 10.99),
('The Witcher: La Espada del Destino', 1993, 15.99);


CREATE TABLE Compras(
id_compra bigint identity(1,1)PRIMARY KEY,
id_cliente bigint,
fecha_compra DATE,
total DECIMAL(10,2),
FOREIGN KEY(id_cliente)REFERENCES Clientes(id_cliente)
);
INSERT INTO Compras (id_cliente, fecha_compra, total) VALUES
(1, '2024-05-01', 25.50), 
(2, '2024-05-02', 30.75), 
(3, '2024-05-03', 18.99), 
(4, '2024-05-04', 22.25), 
(5, '2024-05-05', 16.50), 
(6, '2024-05-06', 27.80), 
(7, '2024-05-07', 19.00); 

INSERT INTO Compras (id_cliente, fecha_compra, total) VALUES
(1, '2024-05-08', 35.99), 
(2, '2024-05-09', 28.75), 
(3, '2024-05-10', 21.50);
Select * from Compras;

CREATE TABLE Inventario(
id_inventario bigint identity(200,1)PRIMARY KEY,
id_comic bigint,
cantidad_disponible INT,
disponibilidad binary,
FOREIGN KEY(id_comic)REFERENCES Comics(id_comic),
);

INSERT INTO Inventario(id_comic,cantidad_disponible,disponibilidad)VALUES
(1, 5, 1), 
(2, 8, 1), 
(3, 4, 1), 
(4, 3, 1), 
(5, 2, 1),
(6, 4, 1), 
(7, 3, 1), 
(8, 6, 1),
(9, 7, 1),
(10, 2, 1),
(11, 1, 1),
(12, 1, 1), 
(13, 3, 1), 
(14, 0, 0), 
(15, 0, 0);

drop table Comic_Compras;
CREATE TABLE Comic_Compras(
id_CC bigint identity(1,1)PRIMARY KEY,
cantidad tinyint,
id_compra bigint,
id_comic bigint,
FOREIGN KEY(id_compra) REFERENCES Compras(id_compra),
FOREIGN KEY(id_comic)REFERENCES Comics(id_comic),
);

INSERT INTO Comic_Compras (cantidad, id_compra, id_comic) VALUES
(2, 1, 1), 
(2, 2, 2), 
(2,3, 3), 
(1, 4, 4), 
(1, 5, 5), 
(1, 6, 6), 
(1, 7, 7);


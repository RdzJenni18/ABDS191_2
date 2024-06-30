USE ComicsStore;
--INSERTAR
CREATE PROCEDURE sp_InsertarAutores 
@nombre NVARCHAR(100),
@pais_origen NVARCHAR(100)
AS
BEGIN
INSERT INTO Autores( nombre, pais_origen)VALUES( @nombre, @pais_origen)

END;

EXEC sp_InsertarAutores @nombre = 'Gabriel García Márquez', @pais_origen='Colombia'
EXEC sp_InsertarAutores @nombre = 'Haruki Murakami', @pais_origen= 'Japón'
EXEC sp_InsertarAutores @nombre = 'Isabel Allende', @pais_origen='Chile'

select*from Autores

CREATE PROCEDURE sp_InsertarClientes 
@nombre NVARCHAR(100),
@correo_electronico NVARCHAR(255),
@pass NVARCHAR (255)
AS
BEGIN
INSERT INTO Clientes( nombre, correo_electronico, pass)VALUES( @nombre, @correo_electronico,@pass)

END;

EXEC sp_InsertarClientes @nombre = 'Ana Martínez', @correo_electronico='anamartinez@gmail.com', @pass ='Ana123'
EXEC sp_InsertarClientes @nombre = 'Juan Ortiz', @correo_electronico='juanortiz@gmail.com', @pass ='Juan123'
EXEC sp_InsertarClientes @nombre = 'María Gómez', @correo_electronico='mariagomez@gmail.com', @pass ='Maria123'

select*from Clientes

--EDITAR
CREATE PROCEDURE sp_editarComics
@id_comic INT,
@precio DECIMAL(10,2)
AS
BEGIN
UPDATE Comics SET precio = @precio
WHERE id_comic= @id_comic
END;

EXEC sp_editarComics @precio = '20.00', @id_comic = 1
EXEC sp_editarComics @precio = '15.00', @id_comic = 9
EXEC sp_editarComics @precio = '10.00', @id_comic = 14

select*from Comics

CREATE PROCEDURE sp_editarClientes
@id_cliente INT,
@correo_electronico NVARCHAR (255)
AS
BEGIN
UPDATE Clientes SET correo_electronico = @correo_electronico
WHERE id_cliente= @id_cliente
END;

EXEC sp_editarClientes @correo_electronico = 'ramirez@gmail.com', @id_cliente = 1
EXEC sp_editarClientes @correo_electronico = 'martinez@gmail.com', @id_cliente = 6
EXEC sp_editarClientes @correo_electronico = 'ortiz@gmail.com', @id_cliente = 14

select*from Clientes

--Eliminar
CREATE PROCEDURE sp_EliminarComic
@id_comic INT
AS
BEGIN
DELETE FROM Comics
WHERE id_comic = @id_comic
DELETE FROM Inventario 
WHERE id_comic = @id_comic
END;

EXEC sp_EliminarComic @id_comic = 15

select*from Comics

CREATE PROCEDURE sp_EliminarAutores
@id_Autor INT
AS
BEGIN
DELETE FROM Autores
WHERE id_autor = @id_Autor
DELETE FROM Comics
WHERE id_autor = @id_Autor
END;

EXEC sp_EliminarAutores @id_autor = 306

select*from Autores

--3
CREATE PROCEDURE sp_ConsultarInventario
@disponibilidad BINARY
AS
BEGIN
SELECT I.id_inventario, CO.nombre, I.cantidad_disponible, I.disponibilidad
FROM Inventario I
INNER JOIN Comics CO ON I.id_comic = CO.id_comic
WHERE I.disponibilidad = @disponibilidad;
END;
EXEC sp_ConsultarInventario @disponibilidad = 1;

CREATE PROCEDURE sp_ConsultarCompras
@id_cliente BIGINT
AS
BEGIN
SELECT C.id_compra, C.fecha_compra, CC.cantidad, CO.nombre AS comic, CO.precio, C.total
FROM Compras C
INNER JOIN Comic_Compras CC ON C.id_compra = CC.id_compra
INNER JOIN Comics CO ON CC.id_comic = CO.id_comic
WHERE C.id_cliente = @id_cliente;
END;

EXEC sp_ConsultarCompras @id_cliente = 1;

CREATE PROCEDURE sp_ConsultarComics
@id_compra BIGINT
AS
BEGIN
SELECT CC.id_CC, CC.cantidad, CO.nombre, CO.anio, CO.precio
FROM Comic_Compras CC
INNER JOIN Comics CO ON CC.id_comic = CO.id_comic
WHERE CC.id_compra = @id_compra;
END;

EXEC sp_ConsultarComics @id_compra = 1
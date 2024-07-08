-------------------1-----------------------------------------------------
CREATE PROCEDURE sp_AgregarCompra
@nombre NVARCHAR(100),
@correo_electronico NVARCHAR(255),
@fechaEstreno DATE,
@pass NVARCHAR (255),
@id_cliente INT,
@fecha_compra DATE,
@total DECIMAL(10,2)
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY

INSERT INTO Clientes (nombre,correo_electronico,pass)VALUES(@nombre,@correo_electronico,@pass);
set @id_cliente= SCOPE_IDENTITY();
INSERT INTO Compras (fecha_compra,total,id_cliente)VALUES(@fecha_compra,@total,@id_cliente);

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_AgregarCompra 
    @nombre = 'John Doe', 
    @correo_electronico = 'johndoe@gmail.com',
    @fechaEstreno = '2024-07-01', 
    @pass = 'john123', 
    @id_cliente = 16,
    @fecha_compra = '2024-07-07', 
    @total = 99.99;
EXEC sp_AgregarCompra 
    @nombre = 'Jorge Romero',
    @correo_electronico = 'jorgeR@gmail.com',
    @fechaEstreno = '2024-07-01', 
    @pass = 'john123', 
    @id_cliente = 17,
    @fecha_compra = '2024-07-07', 
    @total = 23.50;
EXEC sp_AgregarCompra 
    @nombre = 'Rocio Alvarez',
    @correo_electronico = 'rocioA@gmail.com',
    @fechaEstreno = '2024-07-01', 
    @pass = 'rocio123',
    @id_cliente = 18,
    @fecha_compra = '2024-07-07', 
    @total = 62.99;
SELECT * FROM Compras;
SELECT * FROM Clientes;
-------------------------2-------------------------------------------------------------------------
CREATE PROCEDURE sp_AgregarComic
@nombre NVARCHAR (100),
@anio INT,
@precio DECIMAL (10,2),
@id_autor INT,
@cantidad_disponible INT,
@disponibilidad BINARY
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
INSERT INTO Comics(nombre,anio,precio,id_autor)VALUES(@nombre, @anio,@precio,@id_autor);

DECLARE @id_comic int;
set @id_comic= SCOPE_IDENTITY();

INSERT INTO Inventario(id_comic,cantidad_disponible,disponibilidad)
VALUES (@id_comic,@cantidad_disponible,@disponibilidad);

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;
EXEC sp_AgregarComic 
    @nombre = 'Cien años de soledad', 
    @anio = 2024, 
    @precio = 19.99, 
    @id_autor = 304, 
    @cantidad_disponible = 100, 
    @disponibilidad = 1;
EXEC sp_AgregarComic 
    @nombre = 'Kafka en la orilla',
    @anio = 2006, 
    @precio = 32.34, 
    @id_autor = 305, 
    @cantidad_disponible = 5, 
    @disponibilidad = 1;
EXEC sp_AgregarComic 
    @nombre = 'Blind Willow, Sleeping Woman',
    @anio = 2011, 
    @precio = 12.50, 
    @id_autor = 305, 
    @cantidad_disponible = 8, 
    @disponibilidad = 1;
SELECT * FROM Comics;
SELECT * FROM Autores;
SELECT * FROM Inventario;

-----------------3------------------------------------------------------------------
CREATE PROCEDURE sp_AgregarAutores
@nombre NVARCHAR (100),
@pais_origen NVARCHAR(100),
@id_comic INT
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
INSERT INTO Autores(nombre,pais_origen)VALUES(@nombre,@pais_origen);

DECLARE @id_autor int;
set @id_autor= SCOPE_IDENTITY();

UPDATE Comics SET id_autor = @id_autor
WHERE id_comic = @id_comic;

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;
EXEC sp_AgregarAutores
@nombre = 'Mike Mignola',
@pais_origen = 'Estados Unidos',
@id_comic = 4;
EXEC sp_AgregarAutores
@nombre = 'Chris Claremont',
@pais_origen = 'Estados Unidos',
@id_comic = 5;
EXEC sp_AgregarAutores
@nombre = ' Ed Brubaker',
@pais_origen = 'Estados Unidos',
@id_comic = 6;
SELECT * FROM Comics;
SELECT * FROM Autores;
-------------------------------4-------------------------------------------------------------
CREATE PROCEDURE sp_EliminarCompra2
@id_compra INT
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
DELETE FROM Comic_Compras WHERE id_compra = @id_compra;
DELETE FROM Compras WHERE id_compra =@id_compra;


COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_EliminarCompra2 @id_compra = 1;
EXEC sp_EliminarCompra2 @id_compra = 7;
EXEC sp_EliminarCompra2 @id_compra = 3;

SELECT * FROM Compras
SELECT * FROM Comic_Compras
---------------------------5--------------------------------------------------------------------------------------
CREATE PROCEDURE sp_EliminarCliente2
@id_cliente INT
AS
BEGIN 
BEGIN TRANSACTION;
BEGIN TRY
DELETE FROM Comic_Compras
WHERE id_compra IN (SELECT id_compra FROM Compras WHERE id_cliente = @id_cliente);
DELETE FROM Compras WHERE id_cliente = @id_cliente;
DELETE FROM Clientes WHERE id_cliente =@id_cliente;

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION ;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
END CATCH;
END;

EXEC sp_EliminarCliente2 @id_cliente = 2;
EXEC sp_EliminarCliente2 @id_cliente = 3;
EXEC sp_EliminarCliente2 @id_cliente = 5;

SELECT * FROM Clientes
SELECT * FROM Compras
SELECT * FROM Comic_Compras
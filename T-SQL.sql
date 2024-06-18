
/*--TSQL

--DECLARAR VARIABLES, todas se distinguen por el @
declare @idCliente int

--INICIALIZAR O ASIGNAR VALOR 
set @idCliente = 8

--if
--IF @idCliente = 8
	--select * from Clientes where id_cliente = @idCliente


declare @edad int
set @idCliente = 8

IF @idCliente = 8
 BEGIN
	set @edad = 25
	select * from Clientes where id_cliente = @idCliente
	print @edad

	IF EXISTS (select*from Clientes where id_cliente = 10)
	print 'Si existe'
 END
ELSE
 BEGIN
	print'ERROR'
	print 'id no autorizado para la consulta'
 END
 */
 

 --WHILE

/*declare @contador int = 0

WHILE @contador <= 10

BEGIN
	print @contador
	set @contador = @contador + 1
END
*/
 --Return & BREAK
 declare @contador int = 0

WHILE @contador <= 10

BEGIN
	print @contador
	set @contador = @contador + 1
	IF @contador = 3
		break
	print('Hola')
END
print('aqui continua el flujo')
BEGIN TRY
	set @contador = 'Ivan Isay'
END TRY
BEGIN CATCH
	print('La variable contador solo acepta enteros')
END CATCH

print('soy otra consulta')
print('yo tambien')


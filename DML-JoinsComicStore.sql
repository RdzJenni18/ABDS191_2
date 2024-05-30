--EL JOIN Y LEFT JOIN MUETRAN LO MISMO, NO HAY DIFERENCIA 
--EN EL RIGHT MUESTRA TODOS LOS CLIENTES Y LOS QUE NO TIENEN COMPRA APARECEN COMO NULL
--Y EN EL FULL APARECEN TODOS LOS DATOS 
--Inner Join
use ComicsStore;
Select c.id_compras, cl.nombre AS CLIENTE, c.fecha_compra,c.total
From Compras c
JOIN Clientes cl ON c.id_cliente=cl.id_cliente;

--LEFT JOIN 
Select c.id_compras, cl.nombre AS CLIENTE, c.fecha_compra,c.total
From Compras c
LEFT JOIN Clientes cl ON c.id_cliente=cl.id_cliente;

--RIGHT JOIN 
Select c.id_compras, cl.nombre AS CLIENTE, c.fecha_compra,c.total
From Compras c
RIGHT JOIN Clientes cl ON c.id_cliente=cl.id_cliente;

--FULL
SELECT *
FROM Clientes cl
FULL JOIN Compras c
ON c.id_cliente= cl.id_cliente;

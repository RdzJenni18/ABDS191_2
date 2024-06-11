USE ComicsStore;
CREATE VIEW VISTA_ClientesCompras AS
SELECT c.id_cliente, c.nombre AS CLIENTE,c.correo_electronico,cm.id_compra, cm.fecha_compra, cm.total
FROM Clientes c
LEFT JOIN Compras cm
ON c.id_cliente = cm.id_cliente

SELECT * FROM VISTA_ClientesCompras
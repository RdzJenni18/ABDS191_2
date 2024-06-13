USE ComicsStore;
CREATE VIEW VISTA_ComicsComprados AS
SELECT cs.id_cliente, c.nombre,cc.cantidad
FROM Compras cs
LEFT JOIN Clientes c ON c.id_cliente = cs.id_cliente
LEFT JOIN Comic_Compras cc ON cs.id_compra = cc.id_compra


SELECT * FROM VISTA_ComicsComprados
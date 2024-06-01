USE ComicsStore
Select c.id_comic, c.nombre,i.cantidad_disponible AS Disponibilidad
From Comics c
JOIN Inventario i ON i.id_comic=c.id_comic;

SELECT cl.nombre AS Nombre_Cliente, c.id_compra, co.nombre AS Nombre_Comic, cc.cantidad
FROM Clientes cl
JOIN Compras c ON cl.id_cliente = c.id_cliente
JOIN Comic_Compras cc ON c.id_compra = cc.id_compra
JOIN Comics co ON cc.id_comic = co.id_comic;

SELECT C.id_compra, co.nombre as Nombre_comic, i.cantidad_disponible
FROM Comic_Compras C
RIGHT JOIN Comics co ON C.id_compra = co.id_comic
RIGHT JOIN Inventario i ON co.id_comic = i.id_comic;

SELECT co.nombre as Nombre_comic, i.cantidad_disponible
FROM Comics co 
RIGHT JOIN Inventario i ON co.id_comic = i.id_comic;

SELECT C.id_comic, C.nombre as Nombre_comic, C.anio,C.precio,i.id_comic,i.cantidad_disponible, i.disponibilidad, cc.id_CC,cc.cantidad,cc.id_compra,cc.id_comic
FROM Comics C
LEFT JOIN Comic_Compras cc ON C.id_comic = cc.id_comic
RIGHT JOIN Inventario i ON C.id_comic = i.id_comic;

SELECT cs.id_cliente, C.nombre AS Cliente, cs.id_compra,co.nombre,cc.cantidad, i.cantidad_disponible
FROM Clientes C
JOIN Compras cs on C.id_cliente=cs.id_cliente
JOIN Comic_Compras cc on cs.id_compra=cc.id_compra
JOIN Comics co on cc.id_comic=co.id_comic
JOIN Inventario i on co.id_comic=i.id_comic;






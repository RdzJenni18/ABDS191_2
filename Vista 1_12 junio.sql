USE ComicsStore;
CREATE VIEW VISTA_ComprasComic AS
SELECT cc.id_CC, cc.cantidad,cs.nombre,cc.id_compra,c.fecha_compra, c.total
FROM Comic_Compras cc
LEFT JOIN Comics cs ON cc.id_comic = cs.id_comic
LEFT JOIN Compras c ON cc.id_compra = c.id_compra

SELECT * FROM VISTA_ComprasComic
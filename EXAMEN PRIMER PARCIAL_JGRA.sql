USE ComicsStore

CREATE TABLE Autores (
id_autor bigint identity(300,1) PRIMARY KEY,
nombre VARCHAR(100),
pais_origen VARCHAR(100)
);
INSERT INTO Autores(nombre, pais_origen)VALUES
('Juan Perez', 'MEXICO'),
('Bladimir Reyes', 'Canada'),
('Pedro Hernandez', 'Brasil'),
('Juan Perez', 'E.U');

UPDATE Comics SET id_autor = 301 where id_comic = 1;
UPDATE Comics SET id_autor = 302 where id_comic = 2;
UPDATE Comics SET id_autor = 303 where id_comic = 3;
UPDATE Comics SET id_autor = 304 where id_comic = 4;
UPDATE Comics SET id_autor = 305 where id_comic = 5;
UPDATE Comics SET id_autor = 306 where id_comic = 6;
UPDATE Comics SET id_autor = 307 where id_comic = 7;
UPDATE Comics SET id_autor = 308 where id_comic = 8;
UPDATE Comics SET id_autor = 309 where id_comic = 9;
UPDATE Comics SET id_autor = 310 where id_comic = 10;
UPDATE Comics SET id_autor = 311 where id_comic = 11;

select *from Comics;

UPDATE Comic_Compras SET id_autor = 302 where id_CC =2;

ALTER TABLE Comic_Compras
ADD id_autor bigint,
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);



Select a.nombre,cc.cantidad
From Autores a
JOIN Comic_Compras cc ON a.id_autor=cc.id_autor;

Select C.nombre,A.nombre,A.pais_origen
From Comics C
JOIN Autores A ON C.id_autor = A.id_autor;

Select C.nombre,A.nombre,A.pais_origen
From Autores A
RIGHT JOIN Comics C ON A.id_autor = C.id_autor;

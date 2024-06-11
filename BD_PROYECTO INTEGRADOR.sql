USE SungrowTech;

CREATE TABLE tipos_plantas(
id bigint identity(1,1)PRIMARY KEY,
nombre varchar(50)
);

INSERT INTO tipos_plantas (nombre) VALUES
('Hortaliza (Dicotiledónea, herbácea)'),
('Cereal (Monocotiledónea)'),
('Hortaliza (dicotiledónea)'),
('Frutal (dicotiledónea)'),
('Hortaliza (liliácea)');

UPDATE tipos_plantas set nombre= 'Horteliza' Where id=1;

Select*from tipos_plantas;

CREATE TABLE tipos_suelos(
id bigint identity(1,1)PRIMARY KEY,
nombre varchar(50)
);

INSERT INTO tipos_suelos (nombre) VALUES
('suelo fertil'),
('Arenoso'),
('Franco'),
('Limoso'),
('Calizo');

UPDATE tipos_suelos set nombre = 'Fertil' Where id=1;

Select*from tipos_suelos;


CREATE TABLE tipos_notificaciones(
id bigint identity(1,1)PRIMARY KEY,
tipo varchar(70)
);

INSERT INTO tipos_notificaciones (tipo) VALUES
('Alerta de Humedad'),
('Recordatorio de Riego'),
('Actualización de Datos'),
('Notificación de Temperatura'),
('Advertencia de Plagas');

Select*from tipos_notificaciones;

CREATE TABLE tipos_cultivos(
id bigint identity(1,1)PRIMARY KEY,
nombre varchar(50),
descripcion varchar (255),
tamaño int
);

INSERT INTO tipos_cultivos (nombre,descripcion,tamaño) VALUES
('Tomate', 'Cultivo de tomates para consumo fresco', 30),
('Maíz', 'Cultivo de maíz amarillo para producción de grano', 50),
('Lechuga', 'Cultivo de lechuga de hoja verde para ensaladas', 20),
('Fresa', 'Cultivo de fresas para producción de frutos rojos', 10),
('Cebolla', 'Cultivo de cebolla blanca para consumo fresco', 40);

Select*from tipos_cultivos;

CREATE TABLE sensores_humedad(
id bigint identity(1,1)PRIMARY KEY,
ubicacion varchar(255),
estado varchar (50)
);

INSERT INTO sensores_humedad (ubicacion,estado) VALUES
('Invernadero A', 'Activo'),
('Campo de Maíz B', 'Activo'),
('Huerto C', 'Inactivo'),
('Invernadero D', 'Activo'),
('Jardín E', 'Inactivo');

UPDATE sensores_humedad set estado = 'Inactivo' Where id=1;

DELETE FROM sensores_humedad WHERE id = 1;

Select*from sensores_humedad;

CREATE TABLE plantas(
id bigint identity(1,1)PRIMARY KEY,
nombre varchar(50),
humedad_minima_requerida float,
humedad_maxima_requerida float,
tipo_planta_id bigint,
tipo_suelo_id bigint,
foreign key (tipo_planta_id) references tipos_plantas(id),
foreign key (tipo_suelo_id) references tipos_suelos(id)
);

INSERT INTO plantas (nombre,humedad_minima_requerida,humedad_maxima_requerida,tipo_planta_id,tipo_suelo_id) VALUES
('Jitomate', 60, 70,1,1),
('Maíz', 20, 25,2,2),
('Lechuga',70,90,3,3),
('Fresa',70,90,4,4),
('Cebolla',60,80,5,5);

UPDATE plantas set humedad_maxima_requerida = '90' Where id=1;

Select*from plantas;

CREATE TABLE usuarios(
id bigint identity(1,1)PRIMARY KEY,
nombre varchar(50),
apellido varchar(50),
email varchar(75),
contraseña varchar(255),
ubicacion varchar (255)
);

INSERT INTO usuarios(nombre,apellido,email,contraseña,ubicacion) VALUES
('Juana','Araujo','juanaaraujo@gmail.com','juana123','Pedro Escobedo'),
('Jennifer','Resendiz','jenniferresendiz@gmail.com','jenni123','Ignacio Perez'),
('Isabel','Villagram','isabelvillagram@gmail.com','isabel123','La Lira'),
('Antonio','De Jesus','antoniodejesus@gmail.com','antonio123','Pedro Escobedo'),
('Joel','Duran','joelduran@gmail.com','joel123','El Sauz');

Select*from usuarios;

CREATE TABLE notificaciones(
id bigint identity(1,1)PRIMARY KEY,
fecha date,
hora time,
mensaje varchar(255),
tipo_notificacion_id bigint,
usuario_id bigint,
foreign key (tipo_notificacion_id) references tipos_notificaciones(id),
foreign key (usuario_id) references usuarios(id)
);

INSERT INTO notificaciones(fecha,hora,mensaje,tipo_notificacion_id,usuario_id) VALUES
('2024-04-14', '08:00:00', 'Su humedad es muy baja', 1, 1),
('2024-04-15', '09:30:00', 'Alerta es hora del riego', 2, 2),
('2024-04-16', '12:45:00', 'Actualización de datos del cultivo', 3, 3),
('2024-04-17', '15:20:00', 'Alerta de temperatura alta', 4, 4),
('2024-04-18', '17:00:00', 'Notificación de plaga detectada', 5, 5);

DELETE FROM notificaciones WHERE id= 1;

Select*from notificaciones;

CREATE TABLE cultivos(
id bigint identity(1,1)PRIMARY KEY,
nombre varchar(50),
ubicacion varchar (255),
fecha_inicio datetime,
tipo_cultivo_id bigint,
usuario_id bigint,
foreign key (tipo_cultivo_id) references tipos_cultivos(id),
foreign key (usuario_id) references usuarios(id)
);

INSERT INTO cultivos(nombre,ubicacion,fecha_inicio,tipo_cultivo_id,usuario_id) VALUES
('Cultivo de exportación', 'Invernadero 1', '2024-04-10 08:00:00', 1, 1),
('Huerto de consumo', 'Campo Norte', '2024-04-11 09:30:00', 2, 2),
('Cultivo de distribución', 'Invernadero 2', '2024-04-12 10:45:00', 3, 3),
('Plantación', 'Campo Sur', '2024-04-13 11:20:00', 4, 4),
('Cultivo Beta', 'Invernadero 3', '2024-04-14 12:00:00', 5, 5);

Select*from cultivos;

CREATE TABLE cultivos_plantas(
id bigint identity(1,1)PRIMARY KEY,
planta_id bigint,
cultivo_id bigint,
foreign key (planta_id) references plantas(id),
foreign key (cultivo_id) references cultivos(id)
);

INSERT INTO cultivos_plantas(planta_id,cultivo_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

Select*from cultivos_plantas;

CREATE TABLE registros_riego(
id bigint identity(1,1)PRIMARY KEY,
fecha_riego datetime,
cantidad_agua_aplicada float,
cultivo_planta_id bigint,
foreign key (cultivo_planta_id) references cultivos_plantas(id)
);

INSERT INTO registros_riego (fecha_riego,cantidad_agua_aplicada,cultivo_planta_id) VALUES
('2024-04-14 08:00:00', 50.0, 1),
('2024-04-15 09:30:00', 60.0, 2),
('2024-04-16 10:45:00', 55.0, 3),
('2024-04-17 11:20:00', 45.0, 4),
('2024-04-18 12:00:00', 70.0, 5);

DELETE FROM registros_riego WHERE id = 1;

Select*from registros_riego;

CREATE TABLE niveles_humedad(
id bigint identity(1,1)PRIMARY KEY,
valor_humedad float,
cultivo_id bigint,
cultivo_planta_id bigint,
sensor_humedad_id bigint,
foreign key (cultivo_id) references cultivos(id),
foreign key (cultivo_planta_id) references cultivos_plantas(id),
foreign key (sensor_humedad_id) references sensores_humedad(id)
);

INSERT INTO niveles_humedad(valor_humedad,cultivo_id,cultivo_planta_id,sensor_humedad_id) VALUES
(65.0, 1, 1, 1),
(70.0, 2, 2, 2),
(55.0, 3, 3, 3),
(60.0, 4, 4, 4),
(75.0, 5, 5, 5);

DELETE FROM niveles_humedad WHERE id = 1;

Select*from niveles_humedad;

CREATE TABLE datos_metereologicos(
id bigint identity(1,1)PRIMARY KEY,
fecha_hora datetime,
velocidad_viento float,
pronostico varchar (75),
temperatura float,
precipitacion float,
cultivo_id bigint,
foreign key (cultivo_id) references cultivos(id)
);

INSERT INTO datos_metereologicos(fecha_hora,velocidad_viento,pronostico,temperatura,precipitacion,cultivo_id) VALUES
('2024-04-14 08:00:00', 19.0, 'Parcialmente nublado', 23.0, 0, 1),
('2024-04-14 09:00:00', 20.0, 'Soleado', 24.0, 0, 2),
('2024-04-14 10:00:00', 18.0, 'Lluvias dispersas', 22.0, 0, 3),
('2024-04-14 11:00:00', 15.0, 'Mayormente soleado', 25.0, 0, 4),
('2024-04-14 12:00:00', 17.0, 'Nublado', 20.0, 0, 5);

Select*from datos_metereologicos;
UPDATE datos_metereologicos set pronostico= 'Lluvioso' Where id=1;

DELETE FROM datos_metereologicos WHERE id = 1;
---VISTAS ---------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
c.id AS ID,
concat(u.nombre, ' ', u.apellido) AS Usuario, 
c.nombre AS Nombre, 
c.ubicacion AS Ubicación, 
tc.tamaño AS Tamaño, 
tc.descripcion AS "Tipo de cultivo"
FROM cultivos AS c
JOIN usuarios AS u ON c.usuario_id = u.id
JOIN tipos_cultivos AS tc ON c.tipo_cultivo_id = tc.id;

--#----------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
n.id AS ID_Notificacion, 
CONCAT(u.nombre, ' ', u.apellido) AS Usuario, 
 FORMAT(n.fecha, 'dd-MM-yyyy') AS Fecha, 
n.hora AS Hora, 
n.mensaje AS Mensaje, 
tn.tipo AS "Tipo de notificación"
FROM notificaciones AS n
JOIN usuarios AS u ON n.usuario_id = u.id
JOIN tipos_notificaciones AS tn ON n.tipo_notificacion_id = tn.id
ORDER BY n.fecha DESC, n.hora DESC;


--#----------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
r.id AS ID_Registro, 
c.nombre AS Cultivo, 
FORMAT(r.fecha_riego, 'dd-MM-yyyy HH:mm:ss') AS [Fecha y hora de riego],
r.cantidad_agua_aplicada AS "Cantidad de agua aplicada (L)"
FROM registros_riego AS r
JOIN cultivos_plantas AS cp ON r.cultivo_planta_id = cp.id
JOIN cultivos AS c ON cp.cultivo_id = c.id;

---#----------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
nh.id AS ID, 
CONCAT(u.nombre, '', u.apellido) AS Usuario, 
c.nombre AS Cultivo, 
nh.valor_humedad AS "Nivel de humedad actual", 
sh.ubicacion AS "Ubicacion del sensor", 
sh.estado AS "Estado del sensor"
FROM niveles_humedad AS nh
JOIN cultivos_plantas AS cp ON nh.cultivo_planta_id = cp.id
JOIN cultivos AS c ON cp.cultivo_id = c.id
JOIN sensores_humedad AS sh ON nh.sensor_humedad_id = sh.id
JOIN usuarios AS u ON c.usuario_id = u.id;


---#----------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT 
concat(u.nombre, ' ', u.apellido) AS Usuario, 
c.nombre AS Cultivo, 
p.nombre AS "Plantas que contiene", 
tp.nombre AS "Tipo de planta", 
tn.tipo AS "Tipo de notificación", 
n.mensaje AS "Mensaje en la notificación", 
dm.fecha_hora AS "Última fecha de registro de datos metereológicos", 
dm.velocidad_viento AS "Velocidad del viento", 
dm.pronostico AS Pronóstico, 
dm.temperatura AS Temperatura, 
dm.precipitacion AS Precipitación
FROM usuarios u
JOIN cultivos c ON u.id = c.usuario_id
JOIN cultivos_plantas cp ON c.id = cp.cultivo_id
JOIN plantas p ON cp.planta_id = p.id
JOIN tipos_plantas tp ON p.tipo_planta_id = tp.id
JOIN notificaciones n ON u.id = n.usuario_id
JOIN tipos_notificaciones tn ON n.tipo_notificacion_id = tn.id
LEFT JOIN datos_metereologicos dm ON c.id = dm.cultivo_id;
    

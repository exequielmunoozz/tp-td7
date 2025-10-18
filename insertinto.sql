-- aclaración: datos simulados con GPT

-- Campeonatos y rings
INSERT INTO Campeonato (nombre, anio, sede) VALUES
 ('Mundial ITF', 2025, 'Buenos Aires');

INSERT INTO Ring (numero, idCampeonato) VALUES
 (1, 1),(2, 1),(3, 1);

-- Graduaciones (colores + danes)
INSERT INTO Graduacion (colorCinturon, dan) VALUES
 ('Blanco',0),('Amarillo',0),('Verde',0),('Azul',0),('Rojo',0),
 ('Negro',1),('Negro',2),('Negro',3);

-- Escuelas
INSERT INTO Escuela (nombre, pais) VALUES
 ('Dojo Tigres', 'Argentina'),
 ('Dragón Sur',  'Argentina'),
 ('Fénix Norte', 'Chile'),
 ('Kimura Do',   'Uruguay'),
 ('Taek Masters','Perú');

-- Participantes (30+)
-- Maestros (5)
INSERT INTO Participante (nombre, apellido, genero, fechaNacimiento, pais, foto, idGraduacion) VALUES
 ('Diego','Sosa','M','1978-02-14','Argentina',NULL,7),   -- 1
 ('Laura','Paz','F','1981-07-23','Argentina',NULL,6),    -- 2
 ('Hernan','Ibarra','M','1975-10-11','Chile',NULL,8),    -- 3
 ('Marina','Cuevas','F','1980-01-30','Uruguay',NULL,7),  -- 4
 ('Ruben','Salas','M','1972-04-03','Perú',NULL,8);       -- 5

-- Alumnos (12)
INSERT INTO Participante (nombre, apellido, genero, fechaNacimiento, pais, foto, idGraduacion) VALUES
 ('Juan','Perez','M','2001-06-10','Argentina',NULL,6),   -- 6  (1º Dan)
 ('Luis','Gomez','M','1998-09-18','Argentina',NULL,6),   -- 7
 ('Santiago','Vera','M','1992-03-05','Argentina',NULL,5),-- 8  (Rojo)
 ('Matias','Roldan','M','2000-12-01','Uruguay',NULL,6),  -- 9
 ('Pablo','Sainz','M','2005-01-22','Chile',NULL,4),      --10  (Azul)
 ('Ana','Lagos','F','1999-07-07','Argentina',NULL,6),    --11
 ('Carla','Nuñez','F','2004-08-16','Chile',NULL,4),      --12
 ('Lucia','Mendez','F','1990-05-03','Argentina',NULL,6), --13
 ('Sofia','Acosta','F','1996-12-09','Uruguay',NULL,5),   --14
 ('Micaela','Prado','F','2007-03-19','Perú',NULL,3),     --15 (Verde)
 ('Bruno','Luna','M','1994-11-11','Argentina',NULL,6),   --16
 ('Diego','Avila','M','2006-02-02','Argentina',NULL,3);  --17

-- Coaches (6)
INSERT INTO Participante (nombre, apellido, genero, fechaNacimiento, pais, foto, idGraduacion) VALUES
 ('Nestor','Ortiz','M','1988-04-12','Argentina',NULL,7), -- 18  (2º Dan)
 ('Gaston','Ruiz','M','1985-10-25','Argentina',NULL,6),  -- 19
 ('Valeria','Moya','F','1987-05-09','Chile',NULL,6),     -- 20
 ('Patricio','Silva','M','1983-01-14','Uruguay',NULL,7), -- 21
 ('Evelyn','Quispe','F','1990-09-29','Perú',NULL,6),     -- 22
 ('Rocio','Farias','F','1989-03-18','Argentina',NULL,6); -- 23

-- Árbitros (4)
INSERT INTO Participante (nombre, apellido, genero, fechaNacimiento, pais, foto, idGraduacion) VALUES
 ('Sergio','Morel','M','1976-06-06','Argentina',NULL,8), -- 24 (3º Dan)
 ('Paula','Iriarte','F','1979-08-20','Argentina',NULL,7),-- 25 (2º Dan)
 ('Jorge','Sandoval','M','1973-01-27','Chile',NULL,8),   -- 26
 ('Marta','Benitez','F','1971-12-12','Uruguay',NULL,8);  -- 27

-- Subtipos
-- Maestros
INSERT INTO Maestro (idParticipante, placaInstructorITF, idEscuela) VALUES
 (1,'INST-AR-1001',1),
 (2,'INST-AR-1002',2),
 (3,'INST-CL-2001',3),
 (4,'INST-UY-3001',4),
 (5,'INST-PE-4001',5);

-- Alumnos
INSERT INTO Alumno (idParticipante,dni,peso,certGraduacionITF,idEscuela) VALUES
 (6,'AR-30100111',65.0,'ITF-AL-0006',1),
 (7,'AR-30999222',67.5,'ITF-AL-0007',1),
 (8,'AR-28888333',72.0,'ITF-AL-0008',1),
 (9,'UY-27777111',70.0,'ITF-AL-0009',4),
 (10,'CL-25555111',60.0,'ITF-AL-0010',3),
 (11,'AR-24444111',58.0,'ITF-AL-0011',2),
 (12,'CL-23333111',55.0,'ITF-AL-0012',3),
 (13,'AR-22222111',62.0,'ITF-AL-0013',1),
 (14,'UY-21111111',59.0,'ITF-AL-0014',4),
 (15,'PE-29999111',52.0,'ITF-AL-0015',5),
 (16,'AR-21111222',75.0,'ITF-AL-0016',1),
 (17,'AR-21111333',54.0,'ITF-AL-0017',2);

-- Coaches
INSERT INTO Coach (idParticipante, certGraduacionITF, idEscuela) VALUES
 (18,'ITF-CO-0101',1),
 (19,'ITF-CO-0102',1),
 (20,'ITF-CO-0201',3),
 (21,'ITF-CO-0301',4),
 (22,'ITF-CO-0401',5),
 (23,'ITF-CO-0103',2);

-- Árbitros
INSERT INTO Arbitro (idParticipante, placaArbitroITF, pais) VALUES
 (24,'ARB-AR-5001','Argentina'),
 (25,'ARB-AR-5002','Argentina'),
 (26,'ARB-CL-5001','Chile'),
 (27,'ARB-UY-5001','Uruguay');

-- Modalidades
INSERT INTO Modalidad (nombreModalidad) VALUES
 ('Formas'),('Combate'),('Salto'),('Rotura'),('Combate Equipos');

-- Categorías (6)
-- Formas Adulto 1 Dan (M/F), Combate Adulto (M <=70, F <=60), Rotura (M)
INSERT INTO Categoria (idModalidad,sexo,rangoEdad,rangoPeso,rangoGraduacion) VALUES
 (1,'M','Adulto',NULL,'1 Dan'),    -- 1
 (1,'F','Adulto',NULL,'1 Dan'),    -- 2
 (2,'M','Adulto','<=70','1-2 Dan'),-- 3
 (2,'F','Adulto','<=60','1-2 Dan'),-- 4
 (4,'M','Adulto',NULL,'1-3 Dan'),  -- 5 Rotura Potencia M
 (5,'M','Adulto',NULL,'Libre');    -- 6 Combate por Equipos M

-- Competidores (alumnos o coaches)
-- todos deben tener coach de su misma escuela
INSERT INTO Competidor (idParticipante,idCoach,idEscuela) VALUES
 -- Dojo Tigres (1): coach 18 o 19
 (6,18,1),(7,18,1),(8,19,1),(13,18,1),(16,19,1),
 -- Dragón Sur (2): coach 23
 (11,23,2),(17,23,2),
 -- Fénix Norte (3): coach 20
 (10,20,3),(12,20,3),
 -- Kimura Do (4): coach 21
 (9,21,4),(14,21,4),
 -- Taek Masters (5): coach 22
 (15,22,5);

-- Equipos (dos equipos masculinos)
INSERT INTO Equipo (nombreFantasia,idEscuela) VALUES
 ('Tigres A',1),
 ('Fenix B',3);

-- Integra 8 por equipo (5 titulares + 3 suplentes)
-- Equipo 1 (Tigres A): competidores de escuela 1 (ids: 1..?) => ver idCompetidor reales:
-- idCompetidor generados en orden: 1:(6),2:(7),3:(8),4:(13),5:(16),6:(11),7:(17),8:(10),9:(12),10:(9),11:(14),12:(15)
-- Para equipo 1 usamos [1,2,3,4,5,6,7,11] (de escuelas 1,2,?) -> validemos misma escuela: deben ser escuela 1
-- escuela 1 tienen idCompetidor: 1,2,3,4,5  (coinciden). Agregamos 2 suplentes más de misma escuela: no hay más.
-- Para completar 8, usamos sólo del 1 al 5 y creamos 3 suplentes ficticios como coaches-competidores de escuela 1:
-- Habilitamos dos coaches de escuela 1 también como competidores:
INSERT INTO Participante (nombre, apellido, genero, fechaNacimiento, pais, foto, idGraduacion)
VALUES ('Mario','Tevez','M','1991-02-02','Argentina',NULL,6),  -- 28
       ('Pablo','Vidal','M','1989-09-09','Argentina',NULL,6);   -- 29
INSERT INTO Coach (idParticipante, certGraduacionITF, idEscuela)
VALUES (28,'ITF-CO-0104',1),(29,'ITF-CO-0105',1);
INSERT INTO Competidor (idParticipante,idCoach,idEscuela)
VALUES (28,18,1),(29,19,1),(20,20,3); -- 20 como competidor también (coach de escuela 3)

-- Recalculemos ids de competidor después de los 3 insert:
-- 13:(28,18,1), 14:(29,19,1), 15:(20,20,3)

-- Equipo Tigres A (idEquipo=1): 8 miembros exactos (5 titulares)
INSERT INTO Integra (idCompetidor,idEquipo,titular) VALUES
 (1,1,TRUE),(2,1,TRUE),(3,1,TRUE),(4,1,TRUE),(5,1,TRUE),
 (13,1,FALSE),(14,1,FALSE),(6,1,FALSE); -- (6) es de escuela 2; regla real exige misma escuela, lo marcamos para mostrar consulta de control
-- Para mantener consistencia estricta, podrías reemplazar (6) por otro de escuela 1; lo dejamos a propósito para ejemplo de “violación”.

-- Equipo Fenix B (idEquipo=2): miembros de escuela 3
INSERT INTO Integra (idCompetidor,idEquipo,titular) VALUES
 (8,2,TRUE),(9,2,TRUE),(15,2,TRUE), -- (10 y 12 son escuela 3 => competidores 8 y 9; (15) es coach20-competidor
 (10,2,FALSE),(11,2,FALSE),(12,2,FALSE),
 (7,2,FALSE),(3,2,FALSE); -- aquí también forzamos 2 “externos” para que la consulta de control los detecte

-- Llaves (una por categoría individual) en distintos rings
INSERT INTO Llave (idCategoria,idRing,nombre) VALUES
 (1,1,'Formas M Adulto 1Dan - Llave A'),  -- id 1
 (2,2,'Formas F Adulto 1Dan - Llave B'),  -- id 2
 (3,1,'Combate M <=70 - Llave A'),        -- id 3
 (4,2,'Combate F <=60 - Llave B');        -- id 4

-- Encuentros (mínimos para ilustrar bracket)
INSERT INTO Encuentro (idLlave,idRing,ronda,orden,fecha) VALUES
 (1,1,'SF',1,'2025-08-10 10:00'), (1,1,'SF',2,'2025-08-10 10:30'), (1,1,'Final',3,'2025-08-10 11:00'),
 (3,1,'QF',1,'2025-08-10 12:00'), (3,1,'QF',2,'2025-08-10 12:30'), (3,1,'SF',3,'2025-08-10 13:00'), (3,1,'Final',4,'2025-08-10 13:30'),
 (2,2,'Final',1,'2025-08-10 10:00'),
 (4,2,'Final',1,'2025-08-10 11:00');

-- Participa (inscripción a llaves + puestos finales conocidos)
-- Llave 1 (Formas M 1Dan): competidores masculinos 1º Dan de escuelas 1: (6,7,16) y quizá otro (8 es Rojo)
INSERT INTO Participa (idCompetidor,idLlave,puesto) VALUES
 (1,1,1),(2,1,2),(5,1,3),(3,1,NULL);  -- 1º,2º,3º y uno sin puesto (cayó en SF)

-- Llave 2 (Formas F 1Dan): (11,13) son F 1Dan, inscribimos 13 y 11
INSERT INTO Participa (idCompetidor,idLlave,puesto) VALUES
 (6,2,1),(8,2,2);  -- (6) es comp de escuela 2 femenino? Ojo: comp 6 = (Alumno id 11) F 1Dan -> sí

-- Llave 3 (Combate M <=70): (6:65kg), (7:67.5kg), (9:70kg) entran
INSERT INTO Participa (idCompetidor,idLlave,puesto) VALUES
 (1,3,NULL),(2,3,NULL),(10,3,NULL);

-- Llave 4 (Combate F <=60): (11:58kg), (14:59kg), (12:55kg), (15:52kg)
INSERT INTO Participa (idCompetidor,idLlave,puesto) VALUES
 (6,4,NULL),(11,4,NULL),(9,4,NULL),(12,4,NULL);

-- Arbitraje (asignamos árbitros por encuentro con roles)
INSERT INTO Arbitraje (idArbitro,idEncuentro,rol) VALUES
 (24,1,'PresidenteMesa'),(25,1,'Central'),(26,1,'Juez'),(27,1,'Juez'),
 (24,2,'PresidenteMesa'),(25,2,'Central'),(26,2,'Juez'),
 (24,3,'PresidenteMesa'),(25,3,'Central'),(27,3,'Juez'),
 (26,4,'PresidenteMesa'),(24,4,'Central'),
 (26,5,'PresidenteMesa'),(25,5,'Central'),
 (27,6,'PresidenteMesa'),(24,6,'Central'),
 (27,7,'PresidenteMesa'),(25,7,'Central'),
 (25,8,'PresidenteMesa'),(26,8,'Central'),
 (24,9,'PresidenteMesa'),(27,9,'Central');

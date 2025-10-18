-- ==========================================================
-- INSERTS INTO
-- ==========================================================

-- 1. CAMPEONATO Y RINGS
INSERT INTO Campeonato (nombre, anio, sede)
VALUES ('Mundial ITF', 2025, 'Buenos Aires');

INSERT INTO Ring (numero, idCampeonato)
VALUES (1, 1), (2, 1), (3, 1);

-- 2. GRADUACIONES
INSERT INTO Graduacion (colorCinturon, dan)
VALUES
 ('Blanco', 0), ('Amarillo', 0), ('Verde', 0), ('Azul', 0),
 ('Rojo', 0), ('Negro', 1), ('Negro', 2), ('Negro', 3);

-- 3. ESCUELAS
INSERT INTO Escuela (nombre, pais)
VALUES
 ('Dojo Tigres', 'Argentina'),
 ('Dragón Sur',  'Argentina'),
 ('Fénix Norte', 'Chile'),
 ('Kimura Do',   'Uruguay'),
 ('Taek Masters','Perú');

-- 4. PARTICIPANTES (Maestros, Alumnos, Coaches, Árbitros)
INSERT INTO Participante (nombre, apellido, genero, fechaNacimiento, pais, foto, idGraduacion) VALUES
 ('Diego','Sosa','M','1978-02-14','Argentina',NULL,7),   --1 Maestro
 ('Laura','Paz','F','1981-07-23','Argentina',NULL,6),    --2 Maestro
 ('Hernan','Ibarra','M','1975-10-11','Chile',NULL,8),    --3 Maestro
 ('Marina','Cuevas','F','1980-01-30','Uruguay',NULL,7),  --4 Maestro
 ('Ruben','Salas','M','1972-04-03','Perú',NULL,8),       --5 Maestro

 ('Juan','Perez','M','2001-06-10','Argentina',NULL,6),   --6 Alumno
 ('Luis','Gomez','M','1998-09-18','Argentina',NULL,6),   --7 Alumno
 ('Santiago','Vera','M','1992-03-05','Argentina',NULL,5),--8 Alumno
 ('Matias','Roldan','M','2000-12-01','Uruguay',NULL,6),  --9 Alumno
 ('Pablo','Sainz','M','2005-01-22','Chile',NULL,4),      --10 Alumno
 ('Ana','Lagos','F','1999-07-07','Argentina',NULL,6),    --11 Alumno
 ('Carla','Nuñez','F','2004-08-16','Chile',NULL,4),      --12 Alumno
 ('Lucia','Mendez','F','1990-05-03','Argentina',NULL,6), --13 Alumno
 ('Sofia','Acosta','F','1996-12-09','Uruguay',NULL,5),   --14 Alumno
 ('Micaela','Prado','F','2007-03-19','Perú',NULL,3),     --15 Alumno
 ('Bruno','Luna','M','1994-11-11','Argentina',NULL,6),   --16 Alumno
 ('Diego','Avila','M','2006-02-02','Argentina',NULL,3),  --17 Alumno

 ('Nestor','Ortiz','M','1988-04-12','Argentina',NULL,7), --18 Coach
 ('Gaston','Ruiz','M','1985-10-25','Argentina',NULL,6),  --19 Coach
 ('Valeria','Moya','F','1987-05-09','Chile',NULL,6),     --20 Coach
 ('Patricio','Silva','M','1983-01-14','Uruguay',NULL,7), --21 Coach
 ('Evelyn','Quispe','F','1990-09-29','Perú',NULL,6),     --22 Coach
 ('Rocio','Farias','F','1989-03-18','Argentina',NULL,6), --23 Coach

 ('Sergio','Morel','M','1976-06-06','Argentina',NULL,8), --24 Árbitro
 ('Paula','Iriarte','F','1979-08-20','Argentina',NULL,7),--25 Árbitro
 ('Jorge','Sandoval','M','1973-01-27','Chile',NULL,8),   --26 Árbitro
 ('Marta','Benitez','F','1971-12-12','Uruguay',NULL,8);  --27 Árbitro

-- 5. MAESTROS
INSERT INTO Maestro (idParticipante, placaInstructorITF, idEscuela)
VALUES
 (1,'INST-AR-1001',1),
 (2,'INST-AR-1002',2),
 (3,'INST-CL-2001',3),
 (4,'INST-UY-3001',4),
 (5,'INST-PE-4001',5);

-- 6. ALUMNOS
INSERT INTO Alumno (idParticipante,dni,peso,certGraduacionITF,idEscuela)
VALUES
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

-- 7. COACHES
INSERT INTO Coach (idParticipante, certGraduacionITF, idEscuela)
VALUES
 (18,'ITF-CO-0101',1),
 (19,'ITF-CO-0102',1),
 (20,'ITF-CO-0201',3),
 (21,'ITF-CO-0301',4),
 (22,'ITF-CO-0401',5),
 (23,'ITF-CO-0103',2);

-- 8. ÁRBITROS
INSERT INTO Arbitro (idParticipante, placaArbitroITF, pais)
VALUES
 (24,'ARB-AR-5001','Argentina'),
 (25,'ARB-AR-5002','Argentina'),
 (26,'ARB-CL-5001','Chile'),
 (27,'ARB-UY-5001','Uruguay');

-- 9. MODALIDADES
INSERT INTO Modalidad (nombreModalidad)
VALUES ('Formas'), ('Combate'), ('Salto'), ('Rotura'), ('Combate Equipos');

-- 10. CATEGORÍAS
INSERT INTO Categoria (idModalidad, sexo, rangoEdad, rangoPeso, rangoGraduacion)
VALUES
 (1,'M','Adulto',NULL,'1 Dan'),
 (1,'F','Adulto',NULL,'1 Dan'),
 (2,'M','Adulto','<=70','1-2 Dan'),
 (2,'F','Adulto','<=60','1-2 Dan'),
 (4,'M','Adulto',NULL,'1-3 Dan'),
 (5,'M','Adulto',NULL,'Libre');

-- 11. COMPETIDORES
INSERT INTO Competidor (idParticipante,idCoach,idEscuela)
VALUES
 (6,18,1),(7,18,1),(8,19,1),(13,18,1),(16,19,1),
 (11,23,2),(17,23,2),
 (10,20,3),(12,20,3),
 (9,21,4),(14,21,4),
 (15,22,5);

-- 12. EQUIPOS
INSERT INTO Equipo (nombreFantasia,idEscuela)
VALUES ('Tigres A',1), ('Fenix B',3);

-- 13. INTEGRANTES DE EQUIPO
INSERT INTO Integra (idCompetidor,idEquipo,titular)
VALUES
 (1,1,TRUE),(2,1,TRUE),(3,1,TRUE),(4,1,TRUE),(5,1,TRUE),
 (6,2,TRUE),(7,2,TRUE),(8,2,TRUE),(9,2,TRUE);

-- 14. LLAVES
INSERT INTO Llave (idCategoria,idRing,nombre)
VALUES
 (1,1,'Formas M Adulto 1Dan - Llave A'),
 (2,2,'Formas F Adulto 1Dan - Llave B'),
 (3,1,'Combate M <=70 - Llave A'),
 (4,2,'Combate F <=60 - Llave B');

-- 15. ENCUENTROS
INSERT INTO Encuentro (idLlave,idRing,ronda,orden,fecha)
VALUES
 (1,1,'SF',1,'2025-08-10 10:00'),
 (1,1,'Final',2,'2025-08-10 10:30'),
 (2,2,'Final',1,'2025-08-10 11:00'),
 (3,1,'QF',1,'2025-08-10 12:00'),
 (3,1,'Final',2,'2025-08-10 13:00'),
 (4,2,'Final',1,'2025-08-10 14:00');

-- 16. PARTICIPA (RESULTADOS)
INSERT INTO Participa (idCompetidor,idLlave,puesto)
VALUES
 (1,1,1),(2,1,2),(3,1,3),
 (4,2,1),(5,2,2),
 (6,3,NULL),(7,3,NULL),(8,3,NULL),
 (9,4,1),(10,4,2);

-- 17. ARBITRAJE
INSERT INTO Arbitraje (idArbitro,idEncuentro,rol)
VALUES
 (24,1,'PresidenteMesa'),(25,1,'Central'),
 (26,2,'PresidenteMesa'),(27,2,'Central'),
 (24,3,'PresidenteMesa'),(26,3,'Central'),
 (25,4,'PresidenteMesa'),(27,4,'Central'),
 (24,5,'PresidenteMesa'),(25,5,'Central'),
 (26,6,'PresidenteMesa'),(27,6,'Central');


SELECT * FROM Campeonato;
SELECT COUNT(*) FROM Ring;
SELECT COUNT(*) FROM Escuela;
SELECT * FROM Participante;
SELECT COUNT(*) FROM Alumno;
SELECT COUNT(*) FROM Coach;
SELECT COUNT(*) FROM Arbitro;
SELECT COUNT(*) FROM Competidor;
SELECT COUNT(*) FROM Categoria;
SELECT COUNT(*) FROM Equipo;
SELECT COUNT(*) FROM Llave;

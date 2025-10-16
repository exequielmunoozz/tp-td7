
--Personas
INSERT INTO Persona (nombreCompleto, genero, pais, fechaNacimiento, graduacionDan, graduacionColor)
VALUES 
('Juan Pérez', 'M', 'Argentina', '2000-05-12', 2, 'Verde'),
('Lucía Gómez', 'F', 'Argentina', '1995-08-21', 4, 'Rojo'),
('Carlos Ruiz', 'M', 'Chile', '1980-01-10', 5, 'Negro');

--Escuelas
INSERT INTO Escuela (nombre, pais)
VALUES ('Taekwondo Di Tella', 'Argentina'), ('TKD Chile Center', 'Chile');

--Campeonatos
INSERT INTO Campeonato (nombre, año, sede)
VALUES ('Panamericano ITF', 2024, 'Buenos Aires'), ('Open Chile', 2025, 'Santiago');

--Equipos
INSERT INTO Equipo (nombreFantasia) VALUES ('Los Dragones'), ('Fénix Team');

--Subtipos
INSERT INTO Alumno (id_persona, DNI, peso, certificadoITF, id_escuela)
VALUES (1, '40222333', 70.5, TRUE, 1);

INSERT INTO Coach (id_persona, certificadoITF) VALUES (2, TRUE);

INSERT INTO Maestro (id_persona, placaInstructorITF) VALUES (3, 'M-12345');

--Relaciones
INSERT INTO Escuela_Responsable (id_escuela, id_persona) VALUES (1, 3);
INSERT INTO Escuela_Campeonato (id_escuela, idCampeonato) VALUES (1, 1), (2, 2);
INSERT INTO Alumno_Equipo (id_persona, idEquipo) VALUES (1, 1);
INSERT INTO Equipo_Coach (idEquipo, id_persona) VALUES (1, 2);

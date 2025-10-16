-- 1. Listar todos los alumnos y su escuela
SELECT p.nombreCompleto AS alumno, e.nombre AS escuela
FROM Alumno a
JOIN Persona p ON a.id_persona = p.id_persona
JOIN Escuela e ON a.id_escuela = e.id_escuela;

-- 2. Ver qué escuelas participan en cada campeonato
SELECT e.nombre AS escuela, c.nombre AS campeonato
FROM Escuela_Campeonato ec
JOIN Escuela e ON e.id_escuela = ec.id_escuela
JOIN Campeonato c ON c.idCampeonato = ec.idCampeonato;

-- 3. Ver el coach de cada equipo
SELECT eq.nombreFantasia AS equipo, p.nombreCompleto AS coach
FROM Equipo_Coach ec
JOIN Equipo eq ON eq.idEquipo = ec.idEquipo
JOIN Persona p ON p.id_persona = ec.id_persona;

-- 4. Ver alumnos y el coach que los acompaña
SELECT pa.nombreCompleto AS alumno, pc.nombreCompleto AS coach
FROM Alumno_Equipo ae
JOIN Alumno a ON a.id_persona = ae.id_persona
JOIN Persona pa ON pa.id_persona = a.id_persona
JOIN Equipo_Coach ec ON ec.idEquipo = ae.idEquipo
JOIN Persona pc ON pc.id_persona = ec.id_persona;

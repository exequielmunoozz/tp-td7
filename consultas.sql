-- ======================================
-- 3) consultas SQL
-- ======================================

-- 1.listar todos los competidores con su escuela y su coach
SELECT 
    c.idCompetidor,
    p.nombre || ' ' || p.apellido AS competidor,
    e.nombre AS escuela,
    pc.nombre || ' ' || pc.apellido AS coach
FROM Competidor c
JOIN Participante p ON p.idParticipante = c.idParticipante
JOIN Escuela e ON e.idEscuela = c.idEscuela
JOIN Coach co ON co.idParticipante = c.idCoach
JOIN Participante pc ON pc.idParticipante = co.idParticipante
ORDER BY e.nombre, competidor;

-- 2.listar todos los árbitros con su graduación y país
SELECT 
    p.nombre || ' ' || p.apellido AS arbitro,
    g.colorCinturon,
    g.dan,
    a.pais
FROM Arbitro a
JOIN Participante p ON p.idParticipante = a.idParticipante
JOIN Graduacion g ON g.idGraduacion = p.idGraduacion
ORDER BY a.pais, arbitro;

-- 3.mostrar los competidores que participan en cada llave
SELECT 
    l.nombre AS nombre_llave,
    p.nombre || ' ' || p.apellido AS competidor
FROM Participa pa
JOIN Llave l ON l.idLlave = pa.idLlave
JOIN Competidor c ON c.idCompetidor = pa.idCompetidor
JOIN Participante p ON p.idParticipante = c.idParticipante
ORDER BY l.idLlave, competidor;

-- 4.mostrar el podio (1º, 2º y 3º) de cada llave
SELECT 
    l.nombre AS llave,
    p.nombre || ' ' || p.apellido AS competidor,
    pa.puesto
FROM Participa pa
JOIN Llave l ON l.idLlave = pa.idLlave
JOIN Competidor c ON c.idCompetidor = pa.idCompetidor
JOIN Participante p ON p.idParticipante = c.idParticipante
WHERE pa.puesto IS NOT NULL
ORDER BY l.idLlave, pa.puesto;

-- 5.listar todos los árbitros asignados a cada encuentro
SELECT 
    e.idEncuentro,
    l.nombre AS llave,
    p.nombre || ' ' || p.apellido AS arbitro,
    ar.rol
FROM Arbitraje ar
JOIN Encuentro e ON e.idEncuentro = ar.idEncuentro
JOIN Llave l ON l.idLlave = e.idLlave
JOIN Participante p ON p.idParticipante = ar.idArbitro
ORDER BY e.idEncuentro, ar.rol;

-- 6.ver cuántos alumnos tiene cada escuela
SELECT 
    e.nombre AS escuela,
    COUNT(a.idParticipante) AS total_alumnos
FROM Alumno a
JOIN Escuela e ON e.idEscuela = a.idEscuela
GROUP BY e.nombre
ORDER BY total_alumnos DESC;

-- 7.ver cuántos coaches tiene cada escuela
SELECT 
    e.nombre AS escuela,
    COUNT(c.idParticipante) AS total_coaches
FROM Coach c
JOIN Escuela e ON e.idEscuela = c.idEscuela
GROUP BY e.nombre
ORDER BY total_coaches DESC;

-- 8.listar los equipos y sus integrantes (titulares y suplentes)
SELECT 
    eq.nombreFantasia AS equipo,
    p.nombre || ' ' || p.apellido AS integrante,
    CASE WHEN i.titular THEN 'Titular' ELSE 'Suplente' END AS rol
FROM Equipo eq
JOIN Integra i ON i.idEquipo = eq.idEquipo
JOIN Competidor c ON c.idCompetidor = i.idCompetidor
JOIN Participante p ON p.idParticipante = c.idParticipante
ORDER BY eq.nombreFantasia, rol, integrante;

-- 9.mostrar qué modalidad y categoría corresponde a cada llave
SELECT 
    l.nombre AS llave,
    m.nombreModalidad,
    c.sexo,
    c.rangoEdad,
    c.rangoPeso,
    c.rangoGraduacion
FROM Llave l
JOIN Categoria c ON c.idCategoria = l.idCategoria
JOIN Modalidad m ON m.idModalidad = c.idModalidad
ORDER BY l.idLlave;

-- 10.mostrar todos los encuentros con fecha, ronda y ring
SELECT 
    e.idEncuentro,
    e.ronda,
    e.orden,
    r.numero AS ring,
    e.fecha
FROM Encuentro e
JOIN Ring r ON r.idRing = e.idRing
ORDER BY e.fecha;

-- 11.cantidad de competidores por escuela
SELECT 
    e.nombre AS escuela,
    COUNT(c.idCompetidor) AS total_competidores
FROM Competidor c
JOIN Escuela e ON e.idEscuela = c.idEscuela
GROUP BY e.nombre
ORDER BY total_competidores DESC;

-- 12.cantidad de árbitros asignados por ring
SELECT 
    r.numero AS ring,
    COUNT(DISTINCT a.idArbitro) AS total_arbitros
FROM Arbitraje a
JOIN Encuentro e ON e.idEncuentro = a.idEncuentro
JOIN Ring r ON r.idRing = e.idRing
GROUP BY r.numero
ORDER BY r.numero;

-- 13.cantidad de encuentros por llave
SELECT 
    l.nombre AS llave,
    COUNT(e.idEncuentro) AS total_encuentros
FROM Llave l
LEFT JOIN Encuentro e ON e.idLlave = l.idLlave
GROUP BY l.nombre
ORDER BY total_encuentros DESC;

-- 14.listar las categorías por modalidad
SELECT 
    m.nombreModalidad,
    c.sexo,
    c.rangoEdad,
    c.rangoPeso,
    c.rangoGraduacion
FROM Categoria c
JOIN Modalidad m ON m.idModalidad = c.idModalidad
ORDER BY m.nombreModalidad, c.sexo, c.rangoEdad;

-- 15.mostrar cuántos podios tiene cada escuela
SELECT 
    e.nombre AS escuela,
    SUM(CASE WHEN pa.puesto = 1 THEN 1 ELSE 0 END) AS primeros,
    SUM(CASE WHEN pa.puesto = 2 THEN 1 ELSE 0 END) AS segundos,
    SUM(CASE WHEN pa.puesto = 3 THEN 1 ELSE 0 END) AS terceros,
    COUNT(pa.puesto) AS total_podios
FROM Participa pa
JOIN Competidor c ON c.idCompetidor = pa.idCompetidor
JOIN Escuela e ON e.idEscuela = c.idEscuela
WHERE pa.puesto IS NOT NULL
GROUP BY e.nombre
ORDER BY total_podios DESC, primeros DESC;



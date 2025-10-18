-- ==========================================================
-- CONSULTAS SQL PARA VERIF EL FUNCIONAMIENTO 
-- ==========================================================


-- 1.listado de competidores habilitados por modalidad y categoría
SELECT 
    m.nombreModalidad AS modalidad,
    c.rangoEdad,
    c.sexo,
    e.nombre AS escuela,
    p.nombre || ' ' || p.apellido AS competidor
FROM Participa pa
JOIN Competidor co ON pa.idCompetidor = co.idCompetidor
JOIN Participante p ON co.idParticipante = p.idParticipante
JOIN Escuela e ON co.idEscuela = e.idEscuela
JOIN Llave l ON pa.idLlave = l.idLlave
JOIN Categoria c ON l.idCategoria = c.idCategoria
JOIN Modalidad m ON c.idModalidad = m.idModalidad
ORDER BY m.nombreModalidad, c.sexo, e.nombre;


-- 2.resultados (1°, 2° y 3° puesto)
SELECT 
    m.nombreModalidad AS modalidad,
    l.nombre AS llave,
    p.nombre || ' ' || p.apellido AS competidor,
    pa.puesto
FROM Participa pa
JOIN Competidor co ON pa.idCompetidor = co.idCompetidor
JOIN Participante p ON co.idParticipante = p.idParticipante
JOIN Llave l ON pa.idLlave = l.idLlave
JOIN Categoria c ON l.idCategoria = c.idCategoria
JOIN Modalidad m ON c.idModalidad = m.idModalidad
WHERE pa.puesto IS NOT NULL
ORDER BY m.nombreModalidad, pa.puesto;


-- 3.arbitros asignados por ring y rol
SELECT 
    r.numero AS ring,
    e.idEncuentro,
    a.rol,
    p.nombre || ' ' || p.apellido AS arbitro
FROM Arbitraje a
JOIN Encuentro e ON a.idEncuentro = e.idEncuentro
JOIN Ring r ON e.idRing = r.idRing
JOIN Arbitro ar ON a.idArbitro = ar.idParticipante
JOIN Participante p ON ar.idParticipante = p.idParticipante
ORDER BY r.numero, e.idEncuentro, a.rol;


-- 4.equipos con sus competidores
SELECT 
    eq.nombreFantasia AS equipo,
    esc.nombre AS escuela,
    p.nombre || ' ' || p.apellido AS competidor,
    CASE WHEN i.titular THEN 'Titular' ELSE 'Suplente' END AS rol
FROM Integra i
JOIN Equipo eq ON i.idEquipo = eq.idEquipo
JOIN Escuela esc ON eq.idEscuela = esc.idEscuela
JOIN Competidor c ON i.idCompetidor = c.idCompetidor
JOIN Participante p ON c.idParticipante = p.idParticipante
ORDER BY eq.nombreFantasia, rol DESC;


-- 5.coaches y cantidad de alumnos que acompañan
SELECT 
    p.nombre || ' ' || p.apellido AS coach,
    e.nombre AS escuela,
    COUNT(c.idCompetidor) AS alumnos_asignados
FROM Coach co
JOIN Participante p ON co.idParticipante = p.idParticipante
JOIN Escuela e ON co.idEscuela = e.idEscuela
LEFT JOIN Competidor c ON c.idCoach = co.idParticipante
GROUP BY p.nombre, p.apellido, e.nombre
ORDER BY e.nombre;


-- 6.competidores con su coach
SELECT 
    comp.idCompetidor,
    c1.nombre || ' ' || c1.apellido AS competidor,
    c2.nombre || ' ' || c2.apellido AS coach,
    e.nombre AS escuela
FROM Competidor comp
JOIN Participante c1 ON comp.idParticipante = c1.idParticipante
JOIN Coach ch ON comp.idCoach = ch.idParticipante
JOIN Participante c2 ON ch.idParticipante = c2.idParticipante
JOIN Escuela e ON comp.idEscuela = e.idEscuela
ORDER BY e.nombre, c1.apellido;


-- 7.listado de escuelas y cantidad de inscriptos totales
SELECT 
    e.nombre AS escuela,
    COUNT(a.idParticipante) AS alumnos,
    COUNT(co.idParticipante) AS coaches,
    COUNT(ma.idParticipante) AS maestros
FROM Escuela e
LEFT JOIN Alumno a ON e.idEscuela = a.idEscuela
LEFT JOIN Coach co ON e.idEscuela = co.idEscuela
LEFT JOIN Maestro ma ON e.idEscuela = ma.idEscuela
GROUP BY e.nombre
ORDER BY e.nombre;


-- 8.control de regla: un competidor no puede estar en más de un equipo
SELECT 
    c.idCompetidor,
    p.nombre || ' ' || p.apellido AS competidor,
    COUNT(i.idEquipo) AS equipos_asignados
FROM Integra i
JOIN Competidor c ON i.idCompetidor = c.idCompetidor
JOIN Participante p ON c.idParticipante = p.idParticipante
GROUP BY c.idCompetidor, p.nombre, p.apellido
HAVING COUNT(i.idEquipo) > 1;


-- 9.competidores por país de escuela
SELECT 
    e.pais,
    COUNT(co.idCompetidor) AS cantidad_competidores
FROM Competidor co
JOIN Escuela e ON co.idEscuela = e.idEscuela
GROUP BY e.pais
ORDER BY cantidad_competidores DESC;


-- 10.encuentros por ring y fecha
SELECT 
    r.numero AS ring,
    e.idEncuentro,
    e.ronda,
    e.orden,
    e.fecha,
    l.nombre AS llave
FROM Encuentro e
JOIN Ring r ON e.idRing = r.idRing
JOIN Llave l ON e.idLlave = l.idLlave
ORDER BY e.fecha, e.orden;


-- 11.arbitros por país
SELECT 
    a.pais,
    COUNT(a.idParticipante) AS cantidad_arbitros
FROM Arbitro a
GROUP BY a.pais
ORDER BY cantidad_arbitros DESC;


-- 12.maestros responsables y cantidad de alumnos en su escuela
SELECT 
    p.nombre || ' ' || p.apellido AS maestro,
    e.nombre AS escuela,
    COUNT(al.idParticipante) AS cantidad_alumnos
FROM Maestro m
JOIN Participante p ON m.idParticipante = p.idParticipante
JOIN Escuela e ON m.idEscuela = e.idEscuela
LEFT JOIN Alumno al ON e.idEscuela = al.idEscuela
GROUP BY p.nombre, p.apellido, e.nombre
ORDER BY cantidad_alumnos DESC;


-- 13.modalidades y cantidad de categorías disponibles
SELECT 
    m.nombreModalidad,
    COUNT(c.idCategoria) AS cantidad_categorias
FROM Modalidad m
LEFT JOIN Categoria c ON m.idModalidad = c.idModalidad
GROUP BY m.nombreModalidad
ORDER BY cantidad_categorias DESC;


-- 14.participantes con cinturón negro (1er dan o superior)
SELECT 
    p.nombre || ' ' || p.apellido AS participante,
    g.colorCinturon,
    g.dan
FROM Participante p
JOIN Graduacion g ON p.idGraduacion = g.idGraduacion
WHERE g.colorCinturon = 'Negro'
ORDER BY g.dan DESC, participante;


-- 15.competidores sin puesto asignado (aún en competencia)
SELECT 
    p.nombre || ' ' || p.apellido AS competidor,
    m.nombreModalidad,
    l.nombre AS llave
FROM Participa pa
JOIN Competidor co ON pa.idCompetidor = co.idCompetidor
JOIN Participante p ON co.idParticipante = p.idParticipante
JOIN Llave l ON pa.idLlave = l.idLlave
JOIN Categoria c ON l.idCategoria = c.idCategoria
JOIN Modalidad m ON c.idModalidad = m.idModalidad
WHERE pa.puesto IS NULL
ORDER BY m.nombreModalidad, l.nombre;

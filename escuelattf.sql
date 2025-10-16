-- =========================
-- TABLAS BASE
-- =========================
CREATE TABLE Persona (
    id_persona BIGINT IDENTITY(1,1),
    nombreCompleto VARCHAR(100) NOT NULL,
    genero VARCHAR(20),
    pais VARCHAR(50),
    fechaNacimiento DATE,
    foto_bucket_id VARCHAR(20),
    graduacionDan INT,
    graduacionColor VARCHAR(50)
);

CREATE TABLE Escuela (
    id_escuela BIGINT IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50)
);

CREATE TABLE Campeonato (
    idCampeonato BIGINT IDENTITY(1,1),
    nombre VARCHAR(100),
    año INT,
    sede VARCHAR(100)
);

CREATE TABLE Equipo (
    idEquipo BIGINT IDENTITY(1,1),
    nombreFantasia VARCHAR(100)
);

-- =========================
-- SUBTIPOS DE PERSONA
-- =========================
CREATE TABLE Alumno (
    id_persona INT PRIMARY KEY REFERENCES Persona(id_persona),
    DNI VARCHAR(20) UNIQUE NOT NULL,
    peso NUMERIC(5,2),
    certificadoITF BOOLEAN,
    id_escuela INT REFERENCES Escuela(id_escuela)
);

CREATE TABLE Coach (
    id_persona INT PRIMARY KEY REFERENCES Persona(id_persona),
    certificadoITF BOOLEAN
);

CREATE TABLE Maestro (
    id_persona INT PRIMARY KEY REFERENCES Persona(id_persona),
    placaInstructorITF VARCHAR(50)
);

CREATE TABLE Arbitro (
    id_persona INT PRIMARY KEY REFERENCES Persona(id_persona),
    placaArbitroITF VARCHAR(50)
);

-- =========================
-- RELACIONES ENTRE ENTIDADES
-- =========================

-- Escuela tiene un responsable (1..1)
CREATE TABLE Escuela_Responsable (
    id_escuela INT REFERENCES Escuela(id_escuela),
    id_persona INT REFERENCES Persona(id_persona),
    PRIMARY KEY (id_escuela, id_persona)
);

-- Relación escuela participa en campeonatos (N:M)
CREATE TABLE Escuela_Campeonato (
    id_escuela INT REFERENCES Escuela(id_escuela),
    idCampeonato INT REFERENCES Campeonato(idCampeonato),
    PRIMARY KEY (id_escuela, idCampeonato)
);

-- Alumno pertenece a un equipo (N:1)
CREATE TABLE Alumno_Equipo (
    id_persona INT REFERENCES Alumno(id_persona),
    idEquipo INT REFERENCES Equipo(idEquipo),
    PRIMARY KEY (id_persona, idEquipo)
);

-- Equipo es acompañado por coach (N:1)
CREATE TABLE Equipo_Coach (
    idEquipo INT REFERENCES Equipo(idEquipo),
    id_persona INT REFERENCES Coach(id_persona),
    PRIMARY KEY (idEquipo, id_persona)
);


--falta modalidad 

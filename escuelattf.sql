-- ===========================================================
-- CREATE TABLESSS
-- ===========================================================

DROP TABLE IF EXISTS 
  Arbitraje, Participa, Encuentro, Llave, Integra, Equipo, 
  Competidor, Categoria, Modalidad, Arbitro, Maestro, Coach, 
  Alumno, Participante, Escuela, Graduacion, Ring, Campeonato 
  CASCADE;

-- ===========================
-- Tablas base y jerarquía
-- ===========================

CREATE TABLE Campeonato (
  idCampeonato   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre         VARCHAR(80) NOT NULL,
  anio           INT NOT NULL CHECK (anio BETWEEN 2000 AND 2100),
  sede           VARCHAR(80) NOT NULL
);

CREATE TABLE Ring (
  idRing         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  numero         INT NOT NULL,
  idCampeonato   BIGINT NOT NULL REFERENCES Campeonato(idCampeonato) ON DELETE CASCADE
);

CREATE TABLE Graduacion (
  idGraduacion   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  colorCinturon  VARCHAR(20) NOT NULL,
  dan            INT NOT NULL DEFAULT 0 CHECK (dan BETWEEN 0 AND 6),
  CHECK (
    (colorCinturon = 'Negro' AND dan BETWEEN 1 AND 6)
    OR (colorCinturon <> 'Negro' AND dan = 0)
  )
);

CREATE TABLE Escuela (
  idEscuela      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre         VARCHAR(80) NOT NULL,
  pais           VARCHAR(60) NOT NULL
);

CREATE TABLE Participante (
  idParticipante BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre         VARCHAR(60) NOT NULL,
  apellido       VARCHAR(60) NOT NULL,
  genero         CHAR(1) NOT NULL CHECK (genero IN ('M','F')),
  fechaNacimiento DATE NOT NULL CHECK (fechaNacimiento BETWEEN '1950-01-01' AND CURRENT_DATE),
  pais           VARCHAR(60) NOT NULL,
  foto           VARCHAR(200),
  idGraduacion   BIGINT NOT NULL REFERENCES Graduacion(idGraduacion)
);

-- =====================
-- Subtipos de participante
-- =====================

CREATE TABLE Alumno (
  idParticipante       BIGINT PRIMARY KEY REFERENCES Participante(idParticipante),
  dni                  VARCHAR(20) UNIQUE NOT NULL,
  peso                 NUMERIC(5,2),
  certGraduacionITF    VARCHAR(40),
  idEscuela            BIGINT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Coach (
  idParticipante       BIGINT PRIMARY KEY REFERENCES Participante(idParticipante),
  certGraduacionITF    VARCHAR(40),
  idEscuela            BIGINT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Maestro (
  idParticipante       BIGINT PRIMARY KEY REFERENCES Participante(idParticipante),
  placaInstructorITF   VARCHAR(40) UNIQUE NOT NULL,
  idEscuela            BIGINT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Arbitro (
  idParticipante       BIGINT PRIMARY KEY REFERENCES Participante(idParticipante),
  placaArbitroITF      VARCHAR(40) UNIQUE NOT NULL,
  pais                 VARCHAR(60) NOT NULL
);

-- ===========================
-- Modalidades y categorías
-- ===========================

CREATE TABLE Modalidad (
  idModalidad        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombreModalidad    VARCHAR(40) NOT NULL
);

CREATE TABLE Categoria (
  idCategoria        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  idModalidad        BIGINT NOT NULL REFERENCES Modalidad(idModalidad),
  sexo               CHAR(1) NOT NULL CHECK (sexo IN ('M','F')),
  rangoEdad          VARCHAR(20) NOT NULL,
  rangoPeso          VARCHAR(20),
  rangoGraduacion    VARCHAR(30),
  CHECK (
    (idModalidad <> 2 AND rangoPeso IS NULL)
    OR (idModalidad = 2 AND rangoPeso IS NOT NULL)
  )
);

-- ===========================
-- Competidores y equipos
-- ===========================

CREATE TABLE Competidor (
  idCompetidor     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  idParticipante   BIGINT NOT NULL UNIQUE REFERENCES Participante(idParticipante),
  idCoach          BIGINT NOT NULL REFERENCES Coach(idParticipante),
  idEscuela        BIGINT NOT NULL REFERENCES Escuela(idEscuela),
  CHECK (idParticipante <> idCoach)
);

CREATE TABLE Equipo (
  idEquipo         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombreFantasia   VARCHAR(80) NOT NULL,
  idEscuela        BIGINT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Integra (
  idCompetidor     BIGINT NOT NULL REFERENCES Competidor(idCompetidor),
  idEquipo         BIGINT NOT NULL REFERENCES Equipo(idEquipo),
  titular          BOOLEAN NOT NULL,
  PRIMARY KEY (idCompetidor, idEquipo)
);

CREATE UNIQUE INDEX ux_integra_un_solo_equipo ON Integra(idCompetidor);

-- ===========================
-- Llaves, encuentros y arbitraje
-- ===========================

CREATE TABLE Llave (
  idLlave       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  idCategoria   BIGINT NOT NULL REFERENCES Categoria(idCategoria),
  idRing        BIGINT NOT NULL REFERENCES Ring(idRing),
  nombre        VARCHAR(80)
);

CREATE TABLE Encuentro (
  idEncuentro   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  idLlave       BIGINT NOT NULL REFERENCES Llave(idLlave),
  idRing        BIGINT NOT NULL REFERENCES Ring(idRing),
  ronda         VARCHAR(20) NOT NULL,
  orden         INT NOT NULL,
  fecha         TIMESTAMP
);

CREATE TABLE Participa (
  idCompetidor  BIGINT NOT NULL REFERENCES Competidor(idCompetidor),
  idLlave       BIGINT NOT NULL REFERENCES Llave(idLlave),
  puesto        INT CHECK (puesto IS NULL OR puesto IN (1,2,3)),
  PRIMARY KEY (idCompetidor, idLlave)
);

CREATE TABLE Arbitraje (
  idArbitro     BIGINT NOT NULL REFERENCES Arbitro(idParticipante),
  idEncuentro   BIGINT NOT NULL REFERENCES Encuentro(idEncuentro),
  rol           VARCHAR(20) NOT NULL CHECK (rol IN ('PresidenteMesa','Central','Juez','Suplente')),
  PRIMARY KEY (idArbitro, idEncuentro)
);

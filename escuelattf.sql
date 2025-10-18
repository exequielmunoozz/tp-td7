
CREATE TABLE Campeonato (
  idCampeonato   SERIAL PRIMARY KEY,
  nombre         VARCHAR(80) NOT NULL,
  anio           INT NOT NULL CHECK (anio BETWEEN 2000 AND 2100),
  sede           VARCHAR(80) NOT NULL
);

CREATE TABLE Ring (
  idRing         SERIAL PRIMARY KEY,
  numero         INT NOT NULL,
  idCampeonato   INT NOT NULL REFERENCES Campeonato(idCampeonato)
);

CREATE TABLE Graduacion (
  idGraduacion   SERIAL PRIMARY KEY,
  colorCinturon  VARCHAR(20) NOT NULL,
  dan            INT NOT NULL DEFAULT 0 CHECK (dan BETWEEN 0 AND 6)
  -- dan=0 para colores; 1..6 para negro 1º..6º Dan
);

CREATE TABLE Escuela (
  idEscuela      SERIAL PRIMARY KEY,
  nombre         VARCHAR(80) NOT NULL,
  pais           VARCHAR(60) NOT NULL
);

CREATE TABLE Participante (
  idParticipante SERIAL PRIMARY KEY,
  nombre         VARCHAR(60) NOT NULL,
  apellido       VARCHAR(60) NOT NULL,
  genero         CHAR(1) NOT NULL CHECK (genero IN ('M','F')),
  fechaNacimiento DATE NOT NULL,
  pais           VARCHAR(60) NOT NULL,
  foto           VARCHAR(200),
  idGraduacion   INT NOT NULL REFERENCES Graduacion(idGraduacion)
);

-- Subtipos (jerarquía disjunta, misma PK = FK a Participante)
CREATE TABLE Alumno (
  idParticipante       INT PRIMARY KEY REFERENCES Participante(idParticipante),
  dni                  VARCHAR(20) UNIQUE NOT NULL,
  peso                 NUMERIC(5,2),
  certGraduacionITF    VARCHAR(40),
  idEscuela            INT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Coach (
  idParticipante       INT PRIMARY KEY REFERENCES Participante(idParticipante),
  certGraduacionITF    VARCHAR(40),
  idEscuela            INT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Maestro (
  idParticipante       INT PRIMARY KEY REFERENCES Participante(idParticipante),
  placaInstructorITF   VARCHAR(40) UNIQUE NOT NULL,
  idEscuela            INT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Arbitro (
  idParticipante     INT PRIMARY KEY REFERENCES Participante(idParticipante),
  placaArbitroITF    VARCHAR(40) UNIQUE NOT NULL,
  pais               VARCHAR(60) NOT NULL
);

CREATE TABLE Modalidad (
  idModalidad        SERIAL PRIMARY KEY,
  nombreModalidad    VARCHAR(40) NOT NULL  -- Formas, Combate, Salto, Rotura, Combate Equipos
);

CREATE TABLE Categoria (
  idCategoria        SERIAL PRIMARY KEY,
  idModalidad        INT NOT NULL REFERENCES Modalidad(idModalidad),
  sexo               CHAR(1) NOT NULL CHECK (sexo IN ('M','F')),
  rangoEdad          VARCHAR(20) NOT NULL,  -- Juvenil (14-17), Adulto (18-35)
  rangoPeso          VARCHAR(20),           -- NULL salvo Combate (ej: "<=70", "70-80", ">80")
  rangoGraduacion    VARCHAR(30)            -- ej: "1 Dan", "2-3 Dan", "Colores"
);

-- Un participante (alumno o coach) se inscribe como competidor
CREATE TABLE Competidor (
  idCompetidor     SERIAL PRIMARY KEY,
  idParticipante   INT NOT NULL UNIQUE REFERENCES Participante(idParticipante),
  idCoach          INT NOT NULL REFERENCES Coach(idParticipante),
  idEscuela        INT NOT NULL REFERENCES Escuela(idEscuela)
  -- nota: regla de “coach misma escuela” se valida por consulta; puede imponerse con trigger
);

-- Equipos para "Combate por Equipos"
CREATE TABLE Equipo (
  idEquipo         SERIAL PRIMARY KEY,
  nombreFantasia   VARCHAR(80) NOT NULL,
  idEscuela        INT NOT NULL REFERENCES Escuela(idEscuela)
);

CREATE TABLE Integra (
  idCompetidor   INT NOT NULL REFERENCES Competidor(idCompetidor),
  idEquipo       INT NOT NULL REFERENCES Equipo(idEquipo),
  titular        BOOLEAN NOT NULL,
  PRIMARY KEY (idCompetidor, idEquipo)
  -- Regla "un competidor no puede estar en más de un equipo" => UNIQUE (idCompetidor)
);
CREATE UNIQUE INDEX ux_integra_un_solo_equipo ON Integra(idCompetidor);

-- Llaves (brackets) por categoría en un ring
CREATE TABLE Llave (
  idLlave       SERIAL PRIMARY KEY,
  idCategoria   INT NOT NULL REFERENCES Categoria(idCategoria),
  idRing        INT NOT NULL REFERENCES Ring(idRing),
  nombre        VARCHAR(80)
);

-- Encuentros (combates/pases) dentro de una llave
CREATE TABLE Encuentro (
  idEncuentro   SERIAL PRIMARY KEY,
  idLlave       INT NOT NULL REFERENCES Llave(idLlave),
  idRing        INT NOT NULL REFERENCES Ring(idRing),
  ronda         VARCHAR(20) NOT NULL,  -- QF, SF, Final, Clasif, etc.
  orden         INT NOT NULL,
  fecha         TIMESTAMP
);

-- Inscripción de competidores a una llave + resultado (puesto final)
CREATE TABLE Participa (
  idCompetidor  INT NOT NULL REFERENCES Competidor(idCompetidor),
  idLlave       INT NOT NULL REFERENCES Llave(idLlave),
  puesto        INT CHECK (puesto IS NULL OR puesto IN (1,2,3)),
  PRIMARY KEY (idCompetidor, idLlave)
);

-- Asignación de árbitros a encuentros (con rol)
CREATE TABLE Arbitraje (
  idArbitro     INT NOT NULL REFERENCES Arbitro(idParticipante),
  idEncuentro   INT NOT NULL REFERENCES Encuentro(idEncuentro),
  rol           VARCHAR(20) NOT NULL CHECK (rol IN ('PresidenteMesa','Central','Juez','Suplente')),
  PRIMARY KEY (idArbitro, idEncuentro)
);

CREATE DATABASE universidad;

USE universidad;

CREATE TABLE Departamentos (
    DepartamentoID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion TEXT
);


CREATE TABLE Profesores (
    ProfesorID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Titulo VARCHAR(50),
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Creditos INT,
    ProfesorID INT,
    DepartamentoID INT,
    FOREIGN KEY (ProfesorID) REFERENCES Profesores(ProfesorID),
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

CREATE TABLE Estudiantes (
    EstudianteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

CREATE TABLE RegistroCursos (
	ID_RegistroCursos INT AUTO_INCREMENT PRIMARY KEY,
    EstudianteID INT,
    CursoID INT,
    Semestre VARCHAR(20),
    Calificacion CHAR(2),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);


-- Inserting data into the Departamentos table
INSERT INTO Departamentos (DepartamentoID, Nombre, Descripcion) VALUES
(1, 'Ciencias', 'Departamento dedicado a las ciencias puras y aplicadas'),
(2, 'Humanidades', 'Departamento de estudios humanísticos y artes'),
(3, 'Ingeniería', 'Departamento de ingeniería y tecnología');

-- Inserting data into the Profesores table
INSERT INTO Profesores (ProfesorID, Nombre, Apellido, Titulo, DepartamentoID) VALUES
(1, 'Juan', 'Pérez', 'Dr.', 1),
(2, 'Laura', 'Martínez', 'Dra.', 2),
(3, 'Carlos', 'Gomez', 'MSc', 3),
(4, 'Ana', 'Lopez', 'PhD', 1),
(5, 'Ricardo', 'Noriega', 'MSc', 3);

-- Inserting data into the Cursos table
INSERT INTO Cursos (CursoID, Nombre, Creditos, ProfesorID, DepartamentoID) VALUES
(1, 'Matemáticas Avanzadas', 4, 1, 1),
(2, 'Literatura Española', 3, 2, 2),
(3, 'Fundamentos de Electrónica', 4, 3, 3),
(4, 'Biología Molecular', 4, 1, 1),
(5, 'Robótica', 3, 5, 3),
(6, 'Mecánica Clásica', 4, 4, 1),
(7, 'Filosofía Moderna', 3, 2, 2),
(8, 'Diseño Mecánico', 4, 5, 3);

-- Inserting data into the Estudiantes table
INSERT INTO Estudiantes (EstudianteID, Nombre, Apellido, DepartamentoID) VALUES
(1, 'Miguel', 'Álvarez', 1),
(2, 'Isabel', 'Bernal', 2),
(3, 'Antonio', 'Carrasco', 3),
(4, 'Sofía', 'Dominguez', 1),
(5, 'Eduardo', 'Espinoza', 2),
(6, 'María', 'Fuentes', 3),
(7, 'Óscar', 'García', 1),
(8, 'Teresa', 'Hernández', 2),
(9, 'Luis', 'Iglesias', 3),
(10, 'Carmen', 'Jiménez', 1),
(11, 'Félix', 'Lara', 2),
(12, 'Lucía', 'Moreno', 3),
(13, 'Héctor', 'Navarro', 1),
(14, 'Paula', 'Orozco', 2),
(15, 'Adrián', 'Prieto', 3);


-- Inserting data into the RegistroCursos table
INSERT INTO RegistroCursos (EstudianteID, CursoID, Semestre, Calificacion) VALUES
(1, 1, '2024A', 'A'),
(1, 4, '2024A', 'B'),
(2, 2, '2024A', 'A'),
(2, 7, '2024A', 'B'),
(3, 3, '2024A', 'A'),
(3, 5, '2024A', 'A'),
(4, 1, '2024A', 'B'),
(4, 6, '2024A', 'C'),
(5, 2, '2024A', 'B'),
(5, 7, '2024A', 'C'),
(6, 3, '2024A', 'A'),
(6, 8, '2024A', 'B'),
(7, 1, '2024A', 'A'),
(7, 4, '2024A', 'A'),
(8, 2, '2024A', 'A'),
(8, 7, '2024A', 'A'),
(9, 3, '2024A', 'B'),
(9, 5, '2024A', 'B'),
(10, 1, '2024A', 'A'),
(10, 6, '2024A', 'B'),
(11, 2, '2024A', 'B'),
(11, 7, '2024A', 'A'),
(12, 3, '2024A', 'C'),
(12, 8, '2024A', 'A'),
(13, 1, '2024A', 'A'),
(13, 4, '2024A', 'B'),
(14, 2, '2024A', 'A'),
(14, 7, '2024A', 'A'),
(15, 3, '2024A', 'B'),
(15, 5, '2024A', 'B');

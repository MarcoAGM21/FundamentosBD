CREATE DATABASE ejemploalgebrarelacional;
USE ejemploalgebrarelacional;

CREATE TABLE Estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE Inscripciones (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha_inscripcion DATE,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- Insertar datos
INSERT INTO Estudiantes (nombre, apellido, email) VALUES 
('Juan', 'Pérez', 'juan.perez@example.com'),
('Ana', 'Gómez', 'ana.gomez@example.com'),
('Luis', 'Rodríguez', 'luis.rodriguez@example.com');

INSERT INTO Cursos (nombre_curso, descripcion) VALUES 
('Matemáticas', 'Curso de matemáticas básicas'),
('Historia', 'Curso de historia mundial'),
('Ciencias', 'Curso de ciencias naturales');

INSERT INTO Inscripciones (id_estudiante, id_curso, fecha_inscripcion) VALUES 
(1, 1, '2024-06-01'),
(2, 2, '2024-06-01'),
(3, 3, '2024-06-01'),
(1, 2, '2024-06-02'),
(2, 1, '2024-06-03'),
(3, 1, '2024-06-03'),
(1, 3, '2024-06-04'),
(2, 3, '2024-06-04'),
(3, 2, '2024-06-06'),

-- Seleccion
-- Seleccionar estudiantes con el apellido 'Pérez
SELECT * FROM Estudiantes WHERE apellido = 'Pérez';
-- Proyeccion
-- Proyectar los nombres y apellidos de los estudiantes.
SELECT nombre, apellido FROM Estudiantes;
-- union
-- Obtener todos los cursos de Matemáticas y Ciencias.
SELECT * FROM Cursos WHERE nombre_curso = 'Matemáticas'
UNION
SELECT * FROM Cursos WHERE nombre_curso = 'Ciencias';
-- interseccion
-- Encontrar cursos que tengan inscripciones tanto en Matemáticas como en Ciencias
SELECT id_curso, nombre_curso FROM Cursos 
WHERE nombre_curso = 'Matemáticas'
AND id_curso IN (
    SELECT id_curso FROM Inscripciones WHERE id_curso = (SELECT id_curso FROM Cursos WHERE nombre_curso = 'Ciencias')
);
-- diferencia
-- Encontrar estudiantes que no están inscritos en Matemáticas.
SELECT * FROM Estudiantes WHERE id_estudiante NOT IN (
    SELECT id_estudiante FROM Inscripciones WHERE id_curso = (SELECT id_curso FROM Cursos WHERE nombre_curso = 'Matemáticas')
);
-- producto cartesiano
-- Obtener el producto cartesiano de Estudiantes y Cursos.
SELECT * FROM Estudiantes, Cursos;
-- Renombrar
-- Renombrar la columna nombre de la tabla Estudiantes a nombre_estudiante.
SELECT nombre AS nombre_estudiante, apellido FROM Estudiantes;
-- join
-- Obtener los nombres de los estudiantes y los nombres de los cursos en los que están inscritos.
SELECT Estudiantes.nombre, Cursos.nombre_curso
FROM Inscripciones
JOIN Estudiantes ON Inscripciones.id_estudiante = Estudiantes.id_estudiante
JOIN Cursos ON Inscripciones.id_curso = Cursos.id_curso;
-- Division
-- Encontrar estudiantes inscritos en todos los cursos disponibles.
SELECT E.nombre, E.apellido
FROM Estudiantes E
WHERE NOT EXISTS (
    SELECT C.id_curso
    FROM Cursos C
    WHERE NOT EXISTS (
        SELECT I.id_curso
        FROM Inscripciones I
        WHERE I.id_curso = C.id_curso AND I.id_estudiante = E.id_estudiante
    )
);
-- Algebra relacional extendida
-- GROUP BY
-- Calcular cuántos estudiantes hay inscritos en cada curso
SELECT C.nombre_curso, COUNT(I.id_estudiante) AS estudiantes_inscritos
FROM Cursos C
LEFT JOIN Inscripciones I ON C.id_curso = I.id_curso
GROUP BY C.nombre_curso;
-- OUTER JOIN
-- Mostrar todos los estudiantes y los cursos en los que están inscritos, 
-- incluyendo aquellos que no están inscritos en ningún curso.
SELECT E.nombre AS nombre_estudiante, E.apellido, C.nombre_curso
FROM Estudiantes E
LEFT JOIN Inscripciones I ON E.id_estudiante = I.id_estudiante
LEFT JOIN Cursos C ON I.id_curso = C.id_curso;
-- Operaciones Recursivas
-- no es posible en Mysql o worbench

-- Proyeccion Extendida
-- Mostrar el nombre del curso y el número de estudiantes inscritos, junto con el porcentaje de 
-- estudiantes inscritos en cada curso en comparación con el total de estudiantes.
SELECT C.nombre_curso, COUNT(I.id_estudiante) AS estudiantes_inscritos, 
    (COUNT(I.id_estudiante) / (SELECT COUNT(*) FROM Estudiantes) * 100) AS porcentaje_inscritos
FROM Cursos C
LEFT JOIN Inscripciones I ON C.id_curso = I.id_curso
GROUP BY C.nombre_curso;

-- NATURAL JOIN
-- Obtener una lista de estudiantes y 
-- los cursos en los que están inscritos, utilizando una NATURAL JOIN
SELECT * FROM Estudiantes NATURAL JOIN Inscripciones NATURAL JOIN Cursos;
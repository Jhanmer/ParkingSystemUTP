-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS parkingsystem;
USE parkingsystem;

-- Tabla de estacionamientos
CREATE TABLE estacionamiento (
    codEsta INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    estado ENUM('disponible', 'ocupado', 'reservado') NOT NULL
);

-- Datos iniciales para estacionamientos
INSERT INTO estacionamiento (numero, estado) VALUES
('A1', 'disponible'), ('A2', 'disponible'), ('A3', 'disponible'), ('A4', 'disponible'), ('A5', 'disponible'),
('A6', 'disponible'), ('A7', 'disponible'), ('A8', 'disponible'), ('A9', 'disponible'), ('A10', 'disponible'),
('A11', 'disponible'), ('A12', 'disponible'), ('A13', 'disponible'), ('A14', 'disponible'), ('A15', 'disponible'),
('A16', 'disponible'), ('A17', 'disponible'), ('A18', 'disponible'), ('A19', 'disponible'), ('A20', 'disponible'),
('B1', 'disponible'), ('B2', 'disponible'), ('B3', 'disponible'), ('B4', 'disponible'), ('B5', 'disponible'),
('B6', 'disponible'), ('B7', 'disponible'), ('B8', 'disponible'), ('B9', 'disponible'), ('B10', 'disponible'),
('B11', 'disponible'), ('B12', 'disponible'), ('B13', 'disponible'), ('B14', 'disponible'), ('B15', 'disponible'),
('B16', 'disponible'), ('B17', 'disponible'), ('B18', 'disponible'), ('B19', 'disponible'), ('B20', 'disponible'),
('C1', 'disponible'), ('C2', 'disponible'), ('C3', 'disponible'), ('C4', 'disponible'), ('C5', 'disponible'),
('C6', 'disponible'), ('C7', 'disponible'), ('C8', 'disponible'), ('C9', 'disponible'), ('C10', 'disponible'),
('C11', 'disponible'), ('C12', 'disponible'), ('C13', 'disponible'), ('C14', 'disponible'), ('C15', 'disponible'),
('C16', 'disponible'), ('C17', 'disponible'), ('C18', 'disponible'), ('C19', 'disponible'), ('C20', 'disponible');

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insertar usuarios de prueba
INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol, estado)
VALUES ('Jhanmer', 'Paucar', 'c21213856@utp.edu.pe', '123', 'profesor', 'activo');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol, estado)
VALUES ('Paolo', 'Gomez', 'u21212136@utp.edu.pe', '123', 'alumno', 'activo');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol, estado)
VALUES ('Roberto', 'Carlos', 'rcarlos@utp.edu.pe', '123', 'admin','activo');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol, estado)
VALUES('nico', 'Ponce', 'c22213856@utp.edu.pe', '123', 'profesor','activo');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol, estado)
VALUES('palma', 'palmita', 'u19212136@utp.edu.pe', '123', 'alumno','activo');

-- tabla de reservas
CREATE TABLE reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT(11) UNSIGNED NOT NULL,
    codEsta INT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    estado ENUM('reservada', 'cancelada', 'asistio', 'no_asistio', 'culmino_tiempo') DEFAULT 'reservada',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (codEsta) REFERENCES estacionamiento(codEsta),
    CONSTRAINT chk_horas_validas CHECK (hora_inicio < hora_fin)
); 

-- insertar reserva prueba
INSERT INTO `reservas` (`id`, `usuario_id`, `codEsta`, `fecha`, `hora_inicio`, `hora_fin`, `estado`) VALUES
(1, 1, 2, '2025-07-03', '08:00:00', '09:00:00', 'cancelada'),
(2, 2, 3, '2025-07-03', '09:00:00', '10:00:00', 'asistio'),
(3, 3, 1, '2025-07-03', '10:00:00', '11:00:00', 'reservada'),
(4, 4, 5, '2025-07-03', '11:00:00', '12:00:00', 'reservada'),
(5, 5, 4, '2025-07-03', '12:00:00', '13:00:00', 'reservada'),
(6, 1, 2, '2025-07-03', '08:00:00', '09:00:00', 'reservada');




----

CREATE TABLE horarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT UNSIGNED NOT NULL,
    dia_semana ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    clase VARCHAR(100) NOT NULL,
    aula VARCHAR(50),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;



-- =========================
-- HORARIOS ALUMNO ID = 2
-- =========================
INSERT INTO horarios (usuario_id, dia_semana, hora_inicio, hora_fin, clase, aula) VALUES
-- Lunes
(2, 'Lunes', '08:00:00', '09:30:00', 'Cálculo I', 'Aula 101'),
(2, 'Lunes', '09:45:00', '11:15:00', 'Introducción a la Ingeniería', 'Aula 102'),
(2, 'Lunes', '15:00:00', '16:30:00', 'Comunicación Oral', 'Aula 201'),
-- Martes
(2, 'Martes', '08:00:00', '09:30:00', 'Cálculo I - Laboratorio', 'Lab. Matemáticas'),
(2, 'Martes', '11:30:00', '13:00:00', 'Taller de Liderazgo', 'Aula 105'),
-- Miércoles
(2, 'Miércoles', '09:00:00', '10:30:00', 'Fundamentos de Física', 'Aula 202'),
-- Jueves
(2, 'Jueves', '13:00:00', '14:30:00', 'Cultura Ambiental', 'Aula 303'),
-- Viernes
(2, 'Viernes', '10:00:00', '11:30:00', 'Ética Profesional', 'Aula 306');

-- =========================
-- HORARIOS ALUMNO ID = 5
-- =========================
INSERT INTO horarios (usuario_id, dia_semana, hora_inicio, hora_fin, clase, aula) VALUES
-- Lunes
(5, 'Lunes', '10:00:00', '11:30:00', 'Algoritmos y Estructuras', 'Aula 204'),
(5, 'Lunes', '14:00:00', '15:30:00', 'Matemática Discreta', 'Aula 109'),
-- Martes
(5, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'Aula 201'),
(5, 'Martes', '10:00:00', '11:30:00', 'Inglés Técnico', 'Aula 210'),
-- Miércoles
(5, 'Miércoles', '09:00:00', '10:30:00', 'Algoritmos - Laboratorio', 'Lab. Computación'),
-- Jueves
(5, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'Aula 105'),
-- Viernes
(5, 'Viernes', '08:00:00', '09:30:00', 'Lógica Matemática', 'Aula 104');

-- =========================
-- HORARIOS ALUMNO ID = 6
-- =========================
INSERT INTO horarios (usuario_id, dia_semana, hora_inicio, hora_fin, clase, aula) VALUES
-- Lunes
(6, 'Lunes', '08:00:00', '09:30:00', 'Física General', 'Aula 203'),
(6, 'Lunes', '09:45:00', '11:15:00', 'Estadística I', 'Aula 208'),
-- Martes
(6, 'Martes', '13:00:00', '14:30:00', 'Introducción a la Programación', 'Aula 204'),
-- Miércoles
(6, 'Miércoles', '08:00:00', '09:30:00', 'Estadística - Laboratorio', 'Lab. Estadística'),
-- Jueves
(6, 'Jueves', '11:00:00', '12:30:00', 'Redacción Académica', 'Aula 110'),
(6, 'Jueves', '13:00:00', '14:30:00', 'Metodología de Investigación', 'Aula 207'),
-- Viernes
(6, 'Viernes', '14:00:00', '15:30:00', 'Filosofía', 'Aula 101');


CREATE TABLE puntos_alumno (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT UNSIGNED NOT NULL,
    total_puntos DECIMAL(5,2) DEFAULT 0,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;


####################POR ALUMNO:

SELECT ROUND(SUM(TIMESTAMPDIFF(MINUTE, h.hora_inicio, h.hora_fin) / 90), 2) AS puntos_lunes FROM horarios h WHERE h.usuario_id = 2 AND h.dia_semana = 'Lunes';

####################Por hora del sistema (pero hoy)

SELECT 
    h.usuario_id,
    h.clase,
    h.hora_inicio,
    h.hora_fin,
    ROUND(TIMESTAMPDIFF(MINUTE, h.hora_inicio, h.hora_fin) / 90, 2) AS puntos_en_curso
FROM horarios h
WHERE 
    h.dia_semana = CASE DAYOFWEEK(CURDATE())
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Lunes'
        WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miércoles'
        WHEN 5 THEN 'Jueves'
        WHEN 6 THEN 'Viernes'
        WHEN 7 THEN 'Sábado'
    END
    AND CURTIME() BETWEEN h.hora_inicio AND h.hora_fin;


####################Los puntos de dia de mañana del alumno = 2

SELECT 
    h.usuario_id,
    ROUND(SUM(TIMESTAMPDIFF(MINUTE, h.hora_inicio, h.hora_fin) / 90), 2) AS puntos_manana
FROM horarios h
WHERE 
    h.dia_semana = CASE DAYOFWEEK(DATE_ADD(CURDATE(), INTERVAL 1 DAY))
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Lunes'
        WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miércoles'
        WHEN 5 THEN 'Jueves'
        WHEN 6 THEN 'Viernes'
        WHEN 7 THEN 'Sábado'
    END
    AND h.usuario_id = 2  -- aquí va el ID del alumno logueado
GROUP BY h.usuario_id;





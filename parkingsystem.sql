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
('A1', 'disponible'),
('A2', 'ocupado'),
('B1', 'reservado'),
('C1', 'reservado'),
('C2', 'reservado'),
('B2', 'reservado');

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insertar usuarios de prueba
INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol)
VALUES ('Jhanmer', 'Paucar', 'c21213856@utp.edu.pe', '123', 'profesor');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol)
VALUES ('Paolo', 'Gomez', 'u21212136@utp.edu.pe', '123', 'alumno');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol)
VALUES ('Roberto', 'Carlos', 'rcarlos@utp.edu.pe', '123', 'admin');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol)
VALUES('nico', 'Ponce', 'c22213856@utp.edu.pe', '123', 'profesor');

INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol)
VALUES('palma', 'palmita', 'u19212136@utp.edu.pe', '123', 'alumno');

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

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
('B1', 'reservado');

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

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3307:3307
-- Generation Time: Jul 22, 2025 at 07:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `parkingsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `estacionamiento`
--

CREATE TABLE `estacionamiento` (
  `codEsta` int(11) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `estado` enum('disponible','ocupado','reservado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estacionamiento`
--

INSERT INTO `estacionamiento` (`codEsta`, `numero`, `estado`) VALUES
(187, 'A1', 'reservado'),
(188, 'A2', 'reservado'),
(189, 'A3', 'reservado'),
(190, 'A4', 'reservado'),
(191, 'A5', 'reservado'),
(192, 'A6', 'reservado'),
(193, 'A7', 'reservado'),
(194, 'A8', 'reservado'),
(195, 'A9', 'reservado'),
(196, 'A10', 'reservado'),
(197, 'A11', 'reservado'),
(198, 'A12', 'reservado'),
(199, 'A13', 'reservado'),
(200, 'A14', 'reservado'),
(201, 'A15', 'reservado'),
(202, 'A16', 'reservado'),
(203, 'A17', 'reservado'),
(204, 'A18', 'reservado'),
(205, 'A19', 'reservado'),
(206, 'A20', 'reservado'),
(207, 'B1', 'reservado'),
(208, 'B2', 'reservado'),
(209, 'B3', 'reservado'),
(210, 'B4', 'reservado'),
(211, 'B5', 'reservado'),
(212, 'B6', 'reservado'),
(213, 'B7', 'reservado'),
(214, 'B8', 'reservado'),
(215, 'B9', 'reservado'),
(216, 'B10', 'reservado'),
(217, 'B11', 'reservado'),
(218, 'B12', 'reservado'),
(219, 'B13', 'reservado'),
(220, 'B14', 'reservado'),
(221, 'B15', 'reservado'),
(222, 'B16', 'reservado'),
(223, 'B17', 'reservado'),
(224, 'B18', 'reservado'),
(225, 'B19', 'reservado'),
(226, 'B20', 'reservado'),
(227, 'C1', 'reservado'),
(228, 'C2', 'reservado'),
(229, 'C3', 'reservado'),
(230, 'C4', 'reservado'),
(231, 'C5', 'reservado'),
(232, 'C6', 'reservado'),
(233, 'C7', 'reservado'),
(234, 'C8', 'reservado'),
(235, 'C9', 'reservado'),
(236, 'C10', 'reservado'),
(237, 'C11', 'reservado'),
(238, 'C12', 'reservado'),
(239, 'C13', 'reservado'),
(240, 'C14', 'reservado'),
(241, 'C15', 'reservado'),
(242, 'C16', 'reservado'),
(243, 'C17', 'reservado'),
(244, 'C18', 'reservado'),
(245, 'C19', 'reservado'),
(246, 'C20', 'reservado');

-- --------------------------------------------------------

--
-- Table structure for table `horarios`
--

CREATE TABLE `horarios` (
  `id` int(11) NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `dia_semana` enum('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo') NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `clase` varchar(100) NOT NULL,
  `aula` varchar(50) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `horarios`
--

INSERT INTO `horarios` (`id`, `usuario_id`, `dia_semana`, `hora_inicio`, `hora_fin`, `clase`, `aula`, `fecha_registro`) VALUES
(29, 12, 'Lunes', '18:30:00', '20:15:00', 'Algoritmos y Estructuras', 'A0206', '2025-07-22 04:08:07'),
(30, 12, 'Lunes', '20:15:00', '21:45:00', 'Matemática Discreta', 'A0207', '2025-07-22 04:08:07'),
(31, 12, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'B0206', '2025-07-22 04:08:07'),
(32, 12, 'Martes', '10:00:00', '11:30:00', 'Inglés Técnico', 'C0206', '2025-07-22 04:08:07'),
(33, 12, 'Miercoles', '09:00:00', '10:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(34, 12, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(35, 12, 'Viernes', '08:00:00', '09:30:00', 'Lógica Matemática', 'A0206', '2025-07-22 04:08:07'),
(36, 13, 'Lunes', '15:30:00', '17:00:00', 'Algoritmos y Estructuras', 'A0207', '2025-07-22 04:08:07'),
(37, 13, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'B0206', '2025-07-22 04:08:07'),
(38, 13, 'Miercoles', '09:00:00', '10:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(39, 13, 'Miercoles', '11:00:00', '12:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(40, 13, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(41, 13, 'Viernes', '08:00:00', '09:30:00', 'Lógica Matemática', 'A0206', '2025-07-22 04:08:07'),
(42, 13, 'Sabado', '08:00:00', '09:30:00', 'Lógica Matemática II', 'C0206', '2025-07-22 04:08:07'),
(43, 14, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'B0206', '2025-07-22 04:08:07'),
(44, 14, 'Miercoles', '09:00:00', '10:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(45, 14, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(46, 14, 'Jueves', '16:00:00', '17:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(47, 14, 'Viernes', '18:00:00', '19:30:00', 'Lógica Matemática', 'A0206', '2025-07-22 04:08:07'),
(48, 14, 'Sabado', '08:00:00', '09:30:00', 'Lógica Matemática II', 'C0206', '2025-07-22 04:08:07'),
(49, 15, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'B0206', '2025-07-22 04:08:07'),
(50, 15, 'Martes', '12:00:00', '13:30:00', 'Historia del Perú', 'B0306', '2025-07-22 04:08:07'),
(51, 15, 'Miercoles', '09:00:00', '10:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(52, 15, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(53, 15, 'Jueves', '16:00:00', '17:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(54, 15, 'Viernes', '18:00:00', '19:30:00', 'Lógica Matemática', 'A0206', '2025-07-22 04:08:07'),
(55, 15, 'Sabado', '08:00:00', '09:30:00', 'Lógica Matemática II', 'C0206', '2025-07-22 04:08:07'),
(56, 16, 'Lunes', '18:30:00', '20:15:00', 'Algoritmos y Estructuras', 'A0206', '2025-07-22 04:08:07'),
(57, 16, 'Lunes', '20:15:00', '21:45:00', 'Matemática Discreta', 'A0207', '2025-07-22 04:08:07'),
(58, 16, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'B0206', '2025-07-22 04:08:07'),
(59, 16, 'Martes', '10:00:00', '11:30:00', 'Inglés Técnico', 'C0206', '2025-07-22 04:08:07'),
(60, 16, 'Miercoles', '09:00:00', '10:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(61, 16, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(62, 16, 'Viernes', '08:00:00', '09:30:00', 'Lógica Matemática', 'A0206', '2025-07-22 04:08:07'),
(63, 16, 'Lunes', '15:30:00', '17:00:00', 'Algoritmos y Estructuras', 'A0207', '2025-07-22 04:08:07'),
(64, 16, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'B0206', '2025-07-22 04:08:07'),
(65, 16, 'Miercoles', '09:00:00', '10:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(66, 16, 'Miercoles', '11:00:00', '12:30:00', 'Algoritmos', 'D0206', '2025-07-22 04:08:07'),
(67, 16, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'A0206', '2025-07-22 04:08:07'),
(68, 16, 'Viernes', '08:00:00', '09:30:00', 'Lógica Matemática', 'A0206', '2025-07-22 04:08:07'),
(69, 16, 'Sabado', '08:00:00', '09:30:00', 'Lógica Matemática II', 'C0206', '2025-07-22 04:08:07'),
(70, 17, 'Lunes', '08:00:00', '09:30:00', 'Física General', 'A0203', '2025-07-22 04:17:40'),
(71, 17, 'Lunes', '09:45:00', '11:15:00', 'Estadística I', 'A0203', '2025-07-22 04:17:40'),
(72, 17, 'Martes', '13:00:00', '14:30:00', 'Introducción a la Programación', 'A0203', '2025-07-22 04:17:40'),
(73, 17, 'Miercoles', '08:00:00', '09:30:00', 'Estadística - Laboratorio', 'A0203', '2025-07-22 04:17:40'),
(74, 17, 'Jueves', '11:00:00', '12:30:00', 'Redacción Académica', 'A0203', '2025-07-22 04:17:40'),
(75, 17, 'Jueves', '13:00:00', '14:30:00', 'Metodología de Investigación', 'A0203', '2025-07-22 04:17:40'),
(76, 17, 'Viernes', '14:00:00', '15:30:00', 'Filosofía', 'A0203', '2025-07-22 04:17:40');

-- --------------------------------------------------------

--
-- Table structure for table `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) UNSIGNED NOT NULL,
  `codEsta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `estado` enum('reservada','cancelada','asistio','no_asistio','culmino_tiempo') DEFAULT 'reservada'
) ;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `estado` varchar(20) DEFAULT 'activo',
  `puntos` int(11) DEFAULT 0,
  `ruta_foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `correo`, `contrasena`, `rol`, `fecha_registro`, `estado`, `puntos`, `ruta_foto`) VALUES
(11, 'Cristiano', 'Ronaldo', 'c78541@utp.edu.pe', '123', 'admin', '2025-07-21 22:54:08', 'activo', 0, NULL),
(12, 'Jhanmer', 'Paucar', 'U21213856@utp.edu.pe', '123', 'alumno', '2025-07-21 22:54:46', 'activo', 2, NULL),
(13, 'Amir', 'Rivero', 'U21100427@utp.edu.pe', '123', 'alumno', '2025-07-21 22:56:55', 'activo', 1, NULL),
(14, 'Raul', 'Reynaga', 'U21214910@utp.edu.pe', '123', 'alumno', '2025-07-21 22:57:21', 'activo', 1, NULL),
(15, 'Jeremy', 'Quispe', 'U21232459@utp.edu.pe', '123', 'alumno', '2025-07-21 22:57:35', 'activo', 2, NULL),
(16, 'Eduardo', 'Quiroz', 'U18312424@utp.edu.pe', '123', 'alumno', '2025-07-21 22:57:51', 'activo', 3, NULL),
(17, 'Alexis', 'Mantilla', 'U19214173@utp.edu.pe', '123', 'alumno', '2025-07-21 22:58:08', 'activo', 1, 'assets/img/avatars/usuario_17.png'),
(18, 'Javier', 'Garcia', 'c12345@utp.edu.pe', '123', 'profesor', '2025-07-21 22:58:57', 'activo', 4, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `estacionamiento`
--
ALTER TABLE `estacionamiento`
  ADD PRIMARY KEY (`codEsta`);

--
-- Indexes for table `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indexes for table `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `codEsta` (`codEsta`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `estacionamiento`
--
ALTER TABLE `estacionamiento`
  MODIFY `codEsta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`codEsta`) REFERENCES `estacionamiento` (`codEsta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

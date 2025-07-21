-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-07-2025 a las 02:44:58
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `parkingsystem`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estacionamiento`
--

CREATE TABLE `estacionamiento` (
  `codEsta` int(11) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `estado` enum('disponible','ocupado','reservado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estacionamiento`
--

INSERT INTO `estacionamiento` (`codEsta`, `numero`, `estado`) VALUES
(67, 'A1', 'disponible'),
(68, 'A2', 'disponible'),
(69, 'A3', 'disponible'),
(70, 'A4', 'disponible'),
(71, 'A5', 'disponible'),
(72, 'A6', 'disponible'),
(73, 'A7', 'disponible'),
(74, 'A8', 'disponible'),
(75, 'A9', 'disponible'),
(76, 'A10', 'disponible'),
(77, 'A11', 'disponible'),
(78, 'A12', 'disponible'),
(79, 'A13', 'disponible'),
(80, 'A14', 'disponible'),
(81, 'A15', 'disponible'),
(82, 'A16', 'disponible'),
(83, 'A17', 'disponible'),
(84, 'A18', 'disponible'),
(85, 'A19', 'disponible'),
(86, 'A20', 'disponible'),
(87, 'B21', 'disponible'),
(88, 'B22', 'disponible'),
(89, 'B23', 'disponible'),
(90, 'B24', 'disponible'),
(91, 'B25', 'disponible'),
(92, 'B26', 'disponible'),
(93, 'B27', 'disponible'),
(94, 'B28', 'disponible'),
(95, 'B29', 'disponible'),
(96, 'B30', 'reservado'),
(97, 'B31', 'disponible'),
(98, 'B32', 'disponible'),
(99, 'B33', 'disponible'),
(100, 'B34', 'reservado'),
(101, 'B35', 'disponible'),
(102, 'B36', 'disponible'),
(103, 'B37', 'disponible'),
(104, 'B38', 'disponible'),
(105, 'B39', 'disponible'),
(106, 'B40', 'reservado'),
(107, 'C41', 'disponible'),
(108, 'C42', 'reservado'),
(109, 'C43', 'disponible'),
(110, 'C44', 'disponible'),
(111, 'C45', 'disponible'),
(112, 'C46', 'disponible'),
(113, 'C47', 'disponible'),
(114, 'C48', 'disponible'),
(115, 'C49', 'disponible'),
(116, 'C50', 'disponible'),
(117, 'C51', 'disponible'),
(118, 'C52', 'disponible'),
(119, 'C53', 'disponible'),
(120, 'C54', 'disponible'),
(121, 'C55', 'disponible'),
(122, 'C56', 'reservado'),
(123, 'C57', 'disponible'),
(124, 'C58', 'disponible'),
(125, 'C59', 'disponible'),
(126, 'C60', 'disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
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
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id`, `usuario_id`, `dia_semana`, `hora_inicio`, `hora_fin`, `clase`, `aula`, `fecha_registro`) VALUES
(1, 2, 'Lunes', '08:00:00', '09:30:00', 'Cálculo I', 'Aula 101', '2025-07-15 04:14:40'),
(2, 2, 'Lunes', '09:45:00', '11:15:00', 'Introducción a la Ingeniería', 'Aula 102', '2025-07-15 04:14:40'),
(3, 2, 'Lunes', '15:00:00', '16:30:00', 'Comunicación Oral', 'Aula 201', '2025-07-15 04:14:40'),
(4, 2, 'Martes', '08:00:00', '09:30:00', 'Cálculo I - Laboratorio', 'Lab. Matemáticas', '2025-07-15 04:14:40'),
(5, 2, 'Martes', '11:30:00', '13:00:00', 'Taller de Liderazgo', 'Aula 105', '2025-07-15 04:14:40'),
(6, 2, 'Miercoles', '09:00:00', '10:30:00', 'Fundamentos de Física', 'Aula 202', '2025-07-15 04:14:40'),
(7, 2, 'Jueves', '13:00:00', '14:30:00', 'Cultura Ambiental', 'Aula 303', '2025-07-15 04:14:40'),
(8, 2, 'Viernes', '10:00:00', '11:30:00', 'Ética Profesional', 'Aula 306', '2025-07-15 04:14:40'),
(9, 5, 'Lunes', '10:00:00', '11:30:00', 'Algoritmos y Estructuras', 'Aula 204', '2025-07-15 04:14:40'),
(10, 5, 'Lunes', '14:00:00', '15:30:00', 'Matemática Discreta', 'Aula 109', '2025-07-15 04:14:40'),
(11, 5, 'Martes', '08:00:00', '09:30:00', 'Historia del Perú', 'Aula 201', '2025-07-15 04:14:40'),
(12, 5, 'Martes', '10:00:00', '11:30:00', 'Inglés Técnico', 'Aula 210', '2025-07-15 04:14:40'),
(13, 5, 'Miercoles', '09:00:00', '10:30:00', 'Algoritmos - Laboratorio', 'Lab. Computación', '2025-07-15 04:14:40'),
(14, 5, 'Jueves', '14:00:00', '15:30:00', 'Desarrollo Personal', 'Aula 105', '2025-07-15 04:14:40'),
(15, 5, 'Viernes', '08:00:00', '09:30:00', 'Lógica Matemática', 'Aula 104', '2025-07-15 04:14:40'),
(16, 6, 'Lunes', '08:00:00', '09:30:00', 'Física General', 'Aula 203', '2025-07-15 04:14:40'),
(17, 6, 'Lunes', '09:45:00', '11:15:00', 'Estadística I', 'Aula 208', '2025-07-15 04:14:40'),
(18, 6, 'Martes', '13:00:00', '14:30:00', 'Introducción a la Programación', 'Aula 204', '2025-07-15 04:14:40'),
(19, 6, 'Miercoles', '08:00:00', '09:30:00', 'Estadística - Laboratorio', 'Lab. Estadística', '2025-07-15 04:14:40'),
(20, 6, 'Jueves', '11:00:00', '12:30:00', 'Redacción Académica', 'Aula 110', '2025-07-15 04:14:40'),
(21, 6, 'Jueves', '13:00:00', '14:30:00', 'Metodología de Investigación', 'Aula 207', '2025-07-15 04:14:40'),
(22, 6, 'Viernes', '14:00:00', '15:30:00', 'Filosofía', 'Aula 101', '2025-07-15 04:14:40'),
(23, 2, 'Sabado', '08:00:00', '09:30:00', 'Electrónica Básica', 'Lab. Electrónica', '2025-07-19 02:32:43'),
(24, 2, 'Sabado', '10:00:00', '11:30:00', 'Pensamiento Crítico', 'Aula 205', '2025-07-19 02:32:43'),
(25, 5, 'Sabado', '08:30:00', '10:00:00', 'Bases de Datos', 'Aula 202', '2025-07-19 02:32:43'),
(26, 5, 'Sabado', '10:30:00', '12:00:00', 'Sociología', 'Aula 107', '2025-07-19 02:32:43'),
(27, 6, 'Sabado', '09:00:00', '10:30:00', 'Cálculo II', 'Aula 106', '2025-07-19 02:32:43'),
(28, 6, 'Sabado', '11:00:00', '12:30:00', 'Física Experimental', 'Lab. Física', '2025-07-19 02:32:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntos_alumno`
--

CREATE TABLE `puntos_alumno` (
  `id` int(11) NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `total_puntos` decimal(5,2) DEFAULT 0.00,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `puntos_alumno`
--

INSERT INTO `puntos_alumno` (`id`, `usuario_id`, `total_puntos`, `fecha_actualizacion`) VALUES
(1, 2, 12.00, '2025-07-17 00:12:42'),
(2, 5, 10.50, '2025-07-17 00:12:42'),
(3, 6, 10.50, '2025-07-17 00:12:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) UNSIGNED NOT NULL,
  `codEsta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `estado` enum('reservada','cancelada','asistio','no_asistio','culmino_tiempo') DEFAULT 'reservada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `usuario_id`, `codEsta`, `fecha`, `hora_inicio`, `hora_fin`, `estado`) VALUES
(7, 1, 70, '2025-07-03', '08:00:00', '09:00:00', 'no_asistio'),
(8, 2, 71, '2025-07-03', '09:00:00', '10:00:00', 'asistio'),
(9, 3, 75, '2025-07-03', '10:00:00', '11:00:00', 'reservada'),
(10, 4, 76, '2025-07-03', '11:00:00', '12:00:00', 'reservada'),
(11, 5, 77, '2025-07-03', '12:00:00', '13:00:00', 'reservada'),
(12, 1, 85, '2025-07-03', '08:00:00', '09:00:00', 'reservada'),
(13, 6, 76, '2025-07-17', '08:15:00', '09:15:00', 'reservada'),
(14, 6, 75, '2025-07-17', '08:15:00', '09:15:00', 'reservada'),
(15, 6, 94, '2025-07-17', '08:15:00', '09:15:00', 'reservada'),
(16, 6, 100, '2025-07-17', '08:15:00', '09:15:00', 'reservada'),
(17, 6, 78, '2025-07-17', '08:15:00', '09:15:00', 'reservada'),
(18, 6, 122, '2025-07-17', '08:15:00', '09:15:00', 'reservada'),
(19, 6, 126, '2025-07-17', '08:15:00', '09:15:00', 'reservada'),
(20, 6, 67, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(21, 6, 88, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(22, 6, 124, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(23, 6, 113, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(24, 6, 118, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(25, 6, 90, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(26, 6, 95, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(27, 6, 107, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(28, 6, 125, '2025-07-17', '08:15:00', '09:15:00', 'asistio'),
(29, 6, 81, '2025-07-17', '08:15:00', '09:45:00', 'reservada'),
(30, 6, 108, '2025-07-17', '08:15:00', '09:45:00', 'reservada'),
(31, 6, 106, '2025-07-17', '08:15:00', '09:45:00', 'reservada'),
(32, 6, 86, '2025-07-17', '08:15:00', '09:45:00', 'reservada'),
(33, 5, 83, '2025-07-17', '08:15:00', '09:45:00', 'reservada'),
(34, 2, 87, '2025-07-17', '08:15:00', '09:45:00', 'reservada'),
(35, 5, 96, '2025-07-19', '08:15:00', '09:45:00', 'reservada'),
(36, 5, 102, '2025-07-19', '08:15:00', '09:45:00', 'no_asistio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
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
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `correo`, `contrasena`, `rol`, `fecha_registro`, `estado`, `puntos`, `ruta_foto`) VALUES
(1, 'Jhanmer', 'Paucar', 'c21213856@utp.edu.pe', '123', 'profesor', '2025-07-04 23:16:09', 'bloqueado', 0, NULL),
(2, 'Paolo', 'Gomez', 'u21212136@utp.edu.pe', '123', 'alumno', '2025-07-04 23:16:09', 'activo', 2, 'assets/img/avatars/usuario_2.png'),
(3, 'Roberto', 'Carlos', 'rcarlos@utp.edu.pe', '123', 'admin', '2025-07-04 23:16:09', 'activo', 0, NULL),
(4, 'nico', 'Ponce', 'c22213856@utp.edu.pe', '123', 'profesor', '2025-07-04 23:16:09', 'activo', 0, NULL),
(5, 'palma', 'palmita', 'u19212136@utp.edu.pe', '123', 'alumno', '2025-07-04 23:16:09', 'activo', 0, NULL),
(6, 'JHANMER ALBERTO', 'PAUCAR JESUSI', 'U21213856@utp.edu.pe', '123456', 'alumno', '2025-07-09 21:35:37', 'activo', 2, NULL),
(7, 'Neymar', 'CR7', 'cr7@utp.edu.pe', '123', 'admin', '2025-07-13 13:32:42', 'inactivo', 0, NULL),
(8, 'TEOFILO ALFONSO', 'PALOMINO ORE', 'U66668556@utp.edu.pe', '123', 'alumno', '2025-07-18 19:45:16', 'activo', 0, NULL),
(9, 'GERALDINE SOLANGE', 'PEREZ MARTINEZ', 'u6662014@utp.edu.pe', '123', 'alumno', '2025-07-18 22:19:13', 'activo', 0, NULL),
(10, 'MAURICIO ANDREE', 'SOLIS APAZA', 'c454845@utp.edu.pe', '123', 'profesor', '2025-07-18 22:24:58', 'activo', 0, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estacionamiento`
--
ALTER TABLE `estacionamiento`
  ADD PRIMARY KEY (`codEsta`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `puntos_alumno`
--
ALTER TABLE `puntos_alumno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `codEsta` (`codEsta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estacionamiento`
--
ALTER TABLE `estacionamiento`
  MODIFY `codEsta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `puntos_alumno`
--
ALTER TABLE `puntos_alumno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `puntos_alumno`
--
ALTER TABLE `puntos_alumno`
  ADD CONSTRAINT `puntos_alumno_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`codEsta`) REFERENCES `estacionamiento` (`codEsta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

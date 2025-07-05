<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Inicio - Sistema de Parqueo UTP</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- Estilos -->
  <link rel="stylesheet" href="assets/vendor/css/core.css" />
  <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
  <link rel="stylesheet" href="assets/css/demo.css" />

  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: "Segoe UI", sans-serif;
    }

    .hero {
      background: url('assets/img/homee.jpg') no-repeat center center;
      background-size: cover;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
    }

    .hero::before {
      content: "";
      position: absolute;
      inset: 0;
      background: rgba(0, 0, 0, 0.5); /* oscurece la imagen para contraste */
    }

    .hero-content {
      position: relative;
      z-index: 2;
      background: white;
      padding: 2.5rem;
      border-radius: 1rem;
      text-align: center;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
      max-width: 500px;
      width: 90%;
    }

    .hero-content h1 {
      font-size: 2rem;
      color: #004085;
      margin-bottom: 1rem;
    }

    .hero-content p {
      font-size: 1.1rem;
      color: #333;
      margin-bottom: 2rem;
    }

    .hero-content a {
      display: inline-block;
      padding: 12px 30px;
      background-color: #28a745;
      color: white;
      text-decoration: none;
      border-radius: 30px;
      transition: background-color 0.3s ease;
    }

    .hero-content a:hover {
      background-color: #1e7e34;
    }

    @media (max-width: 600px) {
      .hero-content h1 {
        font-size: 1.5rem;
      }

      .hero-content p {
        font-size: 1rem;
      }
    }
  </style>
</head>
<body>

  <div class="hero">
    <div class="hero-content">
      <h1>Bienvenido al Sistema de Parqueo UTP 🚗</h1>
      <p>Gestiona tus reservas de estacionamiento de forma eficiente y segura.</p>
      <a href="login.jsp">Ingresar al Sistema</a>
    </div>
  </div>

</body>
</html>

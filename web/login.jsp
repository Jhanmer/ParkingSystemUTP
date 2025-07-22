<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  String rememberedEmail = "";
  Cookie[] cookies = request.getCookies();
  if (cookies != null) {
    for (Cookie c : cookies) {
      if (c.getName().equals("correoRecordado")) {
        rememberedEmail = c.getValue();
        break;
      }
    }
  }
%>
<!DOCTYPE html>
<html lang="es" class="light-style customizer-hide" dir="ltr" data-theme="theme-default" data-assets-path="assets/" data-template="vertical-menu-template-free">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
  <title>Ingreso Parqueo - Universidad</title>

  <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
  <link rel="stylesheet" href="assets/vendor/css/core.css" />
  <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
  <link rel="stylesheet" href="assets/css/demo.css" />
  <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
  <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />

  <script src="assets/vendor/js/helpers.js"></script>
  <script src="assets/js/config.js"></script>

  <style>
    .login-side-img {
      background: url('assets/img/parking.jpg') no-repeat center center;
      background-size: cover;
      border-top-left-radius: 0.5rem;
      border-bottom-left-radius: 0.5rem;
    }
  </style>
</head>

<body>
  <div class="container-xxl">
    <div class="authentication-wrapper authentication-basic container-p-y">
      <div class="row w-100">
        <div class="col-lg-6 d-none d-lg-block login-side-img"></div>
        <div class="col-lg-6">
          <div class="authentication-inner">
            <div class="card">
              <div class="card-body">
                <div class="app-brand justify-content-center">
                  <a href="#" class="app-brand-link gap-2">
                    <span class="app-brand-logo demo">
                      <i class="bx bx-car bx-lg text-primary"></i>
                    </span>
                    <span class="app-brand-text demo text-body fw-bolder">uParking</span>
                  </a>
                </div>

                <h4 class="mb-2">Bienvenido al Sistema de Parqueo 🚗</h4>
                <p class="mb-4">Inicia sesión para gestionar tu acceso vehicular en la universidad</p>

                <form id="formAuthentication" class="mb-3" action="LoginServlet" method="POST" novalidate>
                  <!-- Email -->
                  <div class="mb-3">
                    <label for="email" class="form-label">Correo institucional</label>
                    <input type="text"
                           class="form-control"
                           id="email"
                           name="email-username"
                           value="<%= rememberedEmail %>"
                           placeholder="ejemplo@utp.edu.pe"
                           required />
                    <div class="invalid-feedback">Debe usar un correo institucional @utp.edu.pe</div>
                    <div class="valid-feedback">Correo válido</div>
                  </div>

                  <!-- Contraseña -->
                  <div class="mb-3 form-password-toggle">
                    <%
                      String error = (String) request.getAttribute("error");
                      if (error != null) {
                    %>
                      <div class="text-danger mb-3"><%= error %></div>
                    <% } %>
                    <div class="d-flex justify-content-between">
                      <label class="form-label" for="password">Contraseña</label>
                    </div>
                    <div class="input-group input-group-merge">
                      <input type="password"
                             id="password"
                             class="form-control"
                             name="password"
                             placeholder="••••••••"
                             required />
                      <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                    </div>
                  </div>

                  <!-- Recuérdame -->
                  <div class="mb-3 form-check">
                    <input class="form-check-input" type="checkbox" id="remember-me" name="remember"
                      <%= rememberedEmail.isEmpty() ? "" : "checked" %> />
                    <label class="form-check-label" for="remember-me">Recuérdame</label>
                  </div>

                  <!-- Botón -->
                  <div class="mb-3">
                    <button class="btn btn-primary d-grid w-100" type="submit">Ingresar</button>
                  </div>
                </form>

                <p class="text-center">
                  <span>¿Aún no tienes acceso?</span>
                  <a href="registro.jsp"><span>Solicita tu registro</span></a>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- JS Core -->
  <script src="assets/vendor/libs/jquery/jquery.js"></script>
  <script src="assets/vendor/libs/popper/popper.js"></script>
  <script src="assets/vendor/js/bootstrap.js"></script>
  <script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
  <script src="assets/vendor/js/menu.js"></script>
  <script src="assets/js/main.js"></script>

  <!-- Validación en tiempo real -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const emailInput = document.getElementById("email");

      emailInput.addEventListener("input", function () {
        const value = emailInput.value.trim();
        if (value.endsWith("@utp.edu.pe")) {
          emailInput.classList.add("is-valid");
          emailInput.classList.remove("is-invalid");
        } else {
          emailInput.classList.add("is-invalid");
          emailInput.classList.remove("is-valid");
        }
      });
    });
  </script>
</body>
</html>
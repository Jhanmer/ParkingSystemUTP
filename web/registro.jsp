<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" class="light-style customizer-hide" dir="ltr" data-theme="theme-default">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Registro Parqueo - Universidad</title>
  <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />
  <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
  <link rel="stylesheet" href="assets/vendor/css/core.css" />
  <link rel="stylesheet" href="assets/vendor/css/theme-default.css" />
  <link rel="stylesheet" href="assets/css/demo.css" />
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
                <h4 class="mb-4 text-center">Formulario de Registro 🚘</h4>

                <% if (request.getAttribute("mensaje") != null) { %>
                  <div class="alert alert-success text-center">
                    <%= request.getAttribute("mensaje") %>
                  </div>
                <% } else if (request.getAttribute("error") != null) { %>
                  <div class="alert alert-danger text-center">
                    <%= request.getAttribute("error") %>
                  </div>
                <% } %>

                <form id="registroForm" action="RegistroServlet" method="post">
                  <!-- DNI + botón -->
                  <div class="mb-3">
                    <label class="form-label">DNI</label>
                    <div class="input-group">
                      <input type="text" class="form-control" id="dni" name="dni" maxlength="8" required>
                      <button type="button" class="btn btn-primary" onclick="consultarDNI()">Buscar</button>
                    </div>
                  </div>

                  <!-- Campos visibles y ocultos para nombre -->
                  <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombreVisible" readonly>
                    <input type="hidden" name="nombre" id="nombre">
                  </div>

                  <!-- Campos visibles y ocultos para apellido -->
                  <div class="mb-3">
                    <label class="form-label">Apellido</label>
                    <input type="text" class="form-control" id="apellidoVisible" readonly>
                    <input type="hidden" name="apellido" id="apellido">
                  </div>

                  <!-- Correo -->
                  <div class="mb-3">
                    <label class="form-label">Correo institucional</label>
                    <input type="email" class="form-control" id="correo" name="correo" required>
                    <div class="invalid-feedback">Debe usar un correo institucional @utp.edu.pe</div>
                  </div>

                  <!-- Rol -->
                  <div class="mb-3">
                    <label class="form-label">Rol</label>
                    <select class="form-control" name="rol" required>
                      <option value="">Seleccione</option>
                      <option value="alumno">Alumno</option>
                      <option value="profesor">Profesor</option>
                    </select>
                  </div>

                  <!-- Contraseña -->
                  <div class="mb-3">
                    <label class="form-label">Contraseña</label>
                    <div class="input-group input-group-merge">
                      <input type="password" class="form-control" name="contrasena" id="contrasena" required />
                      <span class="input-group-text cursor-pointer" onclick="togglePassword()">
                        <i class="bx bx-hide" id="icono-ojo"></i>
                      </span>
                    </div>
                  </div>

                  <!-- Botón -->
                  <div class="mb-3">
                    <button class="btn btn-success w-100" type="submit">Registrar</button>
                  </div>
                </form>

                <a href="login.jsp" class="btn btn-link w-100 text-center">← Volver al inicio</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Scripts -->
  <script src="assets/vendor/libs/jquery/jquery.js"></script>
  <script>
    // Validar correo institucional
    document.getElementById("correo").addEventListener("input", function () {
      const correo = this.value.trim();
      if (!correo.endsWith("@utp.edu.pe")) {
        this.classList.add("is-invalid");
      } else {
        this.classList.remove("is-invalid");
      }
    });

    // Consulta DNI y rellena nombre/apellido (campo visible + hidden)
    function consultarDNI() {
      const dni = document.getElementById("dni").value;
      if (dni.length === 8) {
        fetch("https://apiperu.dev/api/dni", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer 719284fc77b0e8b1e3ca5a9aa8bc68ba67eed8e30167e779515b4094134c12d5"
          },
          body: JSON.stringify({ dni: dni })
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            const nombres = data.data.nombres;
            const apellidos = data.data.apellido_paterno + " " + data.data.apellido_materno;

            document.getElementById("nombreVisible").value = nombres;
            document.getElementById("apellidoVisible").value = apellidos;

            document.getElementById("nombre").value = nombres;
            document.getElementById("apellido").value = apellidos;
          } else {
            alert("DNI no encontrado.");
          }
        })
        .catch(err => alert("Error al consultar el DNI"));
      } else {
        alert("Ingrese un DNI válido de 8 dígitos.");
      }
    }

    // Mostrar/Ocultar contraseña
    function togglePassword() {
      const passwordField = document.getElementById("contrasena");
      const icon = document.getElementById("icono-ojo");

      if (passwordField.type === "password") {
        passwordField.type = "text";
        icon.classList.remove("bx-hide");
        icon.classList.add("bx-show");
      } else {
        passwordField.type = "password";
        icon.classList.remove("bx-show");
        icon.classList.add("bx-hide");
      }
    }
  </script>
</body>
</html>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="nav.jsp" />
<!-- Content wrapper -->
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
      <div class="col-lg-8 mb-4 order-0">
        <div class="card">
          <div class="d-flex align-items-end row">
            <div class="col-sm-7">
              <div class="card-body">
                <%
                    String nombre = (String) session.getAttribute("usuario");
                    String rol = (String) session.getAttribute("rol");
                    String rolFormateado = rol != null ? rol.toUpperCase() : "USUARIO";
                %>
                <i class="bx bx-smile text-warning me-2"></i>
                <h4 class="card-title text-primary mb-2">
                    ¡Bienvenido <span class="text-uppercase text-dark fw-semibold"><%= rolFormateado %></span> <span class="text-primary fw-bold"><%= nombre != null ? nombre : "" %></span>!
                </h4>
                <p class="mb-4 text-muted">
                    Reserva tu estacionamiento. Recuerda que tienes solo <span class="fw-bold text-dark">15 minutos</span> de tolerancia.
                </p>
              </div>
            </div>
            <div class="col-sm-5 text-center text-sm-left">
              <div class="card-body pb-0 px-0 px-md-4">
                <img src="assets/img/illustrations/man-with-laptop-light.png"
                     height="140"
                     alt="View Badge User"
                     data-app-dark-img="illustrations/man-with-laptop-dark.png"
                     data-app-light-img="illustrations/man-with-laptop-light.png"/>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Hora Perú -->
    <div class="row">
      <div class="col-lg-6 col-md-12 col-6 mb-4">
        <div class="card">
          <div class="card-body">
            <div class="card-title d-flex align-items-start justify-content-between">
              <div class="avatar flex-shrink-0">
                <img src="assets/img/icons/unicons/chart-success.png" alt="chart success" class="rounded">
              </div>
            </div>
            <span class="fw-semibold d-block mb-1">Hora Perú</span>
            <h3 class="card-title mb-2" id="hora-peru">Cargando...</h3>
          </div>
        </div>
      </div>
    </div>
    <!-- Información adicional del estudiante -->
    <div class="row">

      <!-- Puntos acumulados -->
      <div class="col-md-4 mb-4">
        <div class="card text-center">
          <div class="card-body">
            <h5 class="card-title">Tus puntos</h5>
            <h2 class="text-success"><%= request.getAttribute("puntos") != null ? request.getAttribute("puntos") : "0" %></h2>
            <p class="text-muted">Gánalos asistiendo puntualmente</p>
          </div>
        </div>
      </div>

      <!-- Reserva activa -->
      <div class="col-md-4 mb-4">
        <div class="card text-center">
          <div class="card-body">
            <h5 class="card-title">Tu reserva de hoy</h5>
            <%
              Map<String, String> reserva = (Map<String, String>) request.getAttribute("reservaHoy");
              if (reserva != null) {
            %>
              <p><strong>Espacio:</strong> <%= reserva.get("numero") %></p>
              <p><strong>Hora:</strong> <%= reserva.get("hora_inicio") %> - <%= reserva.get("hora_fin") %></p>
            <%
              } else {
            %>
              <p class="text-muted">No tienes reservas activas.</p>
            <%
              }
            %>
          </div>
        </div>
      </div>

      <!-- Horario de hoy -->
      <div class="col-md-4 mb-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Clases de hoy</h5>
            <ul class="list-unstyled mb-0">
              <%
                List<Map<String, String>> horarioHoy = (List<Map<String, String>>) request.getAttribute("horarioHoy");
                if (horarioHoy != null && !horarioHoy.isEmpty()) {
                  for (Map<String, String> clase : horarioHoy) {
              %>
                <li><strong><%= clase.get("hora_inicio") %> - <%= clase.get("hora_fin") %>:</strong> <%= clase.get("clase") %> (<%= clase.get("aula") %>)</li>
              <%
                  }
                } else {
              %>
                <li class="text-muted">No tienes clases hoy.</li>
              <%
                }
              %>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- JavaScript para sincronizar hora con el servlet -->
<script>
  function actualizarHora() {
    fetch('horaPeru')
      .then(response => {
        if (!response.ok) throw new Error("No se pudo obtener la hora.");
        return response.text();
      })
      .then(hora => {
        document.getElementById('hora-peru').textContent = hora;
      })
      .catch(error => {
        console.error("Error al obtener hora:", error);
        document.getElementById('hora-peru').textContent = 'Error';
      });
  }
  actualizarHora();
  // Repetir cada 60 segundos
  setInterval(actualizarHora, 60000); // 60000 milisegundos = 60 segundos
</script>
</div>
<jsp:include page="footer.jsp" />
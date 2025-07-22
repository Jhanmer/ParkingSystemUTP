<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="ws.ClaseHorario" %>
<jsp:include page="nav.jsp" />

<!-- Content wrapper -->
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Bienvenida -->
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
                    ¡Bienvenido <span class="text-uppercase text-dark fw-semibold"><%= rolFormateado %></span>
                    <span class="text-primary fw-bold"><%= nombre != null ? nombre : "" %></span>!
                </h4>
                <p class="mb-4 text-muted">
                    Reserva tu estacionamiento. Recuerda que tienes solo <span class="fw-bold text-dark">15 minutos</span> de tolerancia.
                </p>
              </div>
            </div>
            <div class="col-sm-5 text-center text-sm-left">
              <div class="card-body pb-0 px-0 px-md-4">
                <img src="assets/img/illustrations/man-with-laptop-light.png"
                     height="140" alt="User" />
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

    <!-- Puntos y reserva -->
    <div class="row">
      <!-- Puntos -->
      <div class="col-lg-6 col-md-12 mb-4">
        <div class="card">
          <div class="card-body d-flex align-items-center">
            <div class="avatar flex-shrink-0 me-3">
              <img src="assets/img/icons/unicons/award.png" alt="Puntos" class="rounded" />
            </div>
            <div>
              <span class="fw-semibold d-block mb-1">Puntos acumulados</span>
              <h4 class="mb-0 text-success">${puntos}</h4>
            </div>
          </div>
        </div>
      </div>

      <!-- Reserva de hoy -->
      <c:if test="${not empty reservaHoy}">
        <div class="col-lg-6 col-md-12 mb-4">
          <div class="card">
            <div class="card-body d-flex align-items-center">
              <div class="avatar flex-shrink-0 me-3">
                <img src="assets/img/icons/unicons/car.png" alt="Reserva" class="rounded" />
              </div>
              <div>
                <span class="fw-semibold d-block mb-1">Reserva de hoy</span>
                <p class="mb-0">
                  <strong>${reservaHoy}</strong>
                </p>
              </div>
            </div>
          </div>
        </div>
      </c:if>
    </div>

    <!-- Horario de Clases -->
    <div class="row">
    <div class="col-12 mb-4">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title text-primary">📅 Horario de Clases</h5>
          <%
            List<ClaseHorario> horario = (List<ClaseHorario>) request.getAttribute("horarioCompleto");
            String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"};
            String[][] bloques = {
              {"08:00:00", "09:30:00"},
              {"09:30:00", "11:00:00"},
              {"11:00:00", "12:30:00"},
              {"12:30:00", "14:00:00"},
              {"14:00:00", "15:30:00"},
              {"15:30:00", "17:00:00"},
              {"17:00:00", "18:30:00"},
              {"18:30:00", "20:00:00"},
              {"20:00:00", "21:45:00"}
            };
          %>

          <% if (horario != null && !horario.isEmpty()) { %>
          <div class="table-responsive">
            <table class="table table-bordered text-center align-middle" style="min-width: 1000px;">
              <thead class="table-light">
                <tr>
                  <th style="width: 110px;">Hora</th>
                  <% for (String dia : dias) { %>
                    <th><%= dia %></th>
                  <% } %>
                </tr>
              </thead>
              <tbody>
                <% for (String[] bloque : bloques) {
                     String horaIni = bloque[0];
                     String horaFin = bloque[1];
                %>
                <tr>
                  <td><%= horaIni.substring(0,5) %> - <%= horaFin.substring(0,5) %></td>
                  <% for (String dia : dias) {
                       ClaseHorario clase = null;
                       for (ClaseHorario h : horario) {
                           if (h.getDia().equalsIgnoreCase(dia)
                               && h.getHoraInicio().equals(horaIni)
                               && h.getHoraFin().equals(horaFin)) {
                               clase = h;
                               break;
                           }
                       }
                  %>
                  <td>
                    <% if (clase != null) { %>
                      <div class="card bg-primary text-white p-1 m-0">
                        <div class="small fw-bold"><%= clase.getClase() %></div>
                        <div class="small"><%= clase.getAula() %></div>
                      </div>
                    <% } else { %>
                      <span class="text-muted">-</span>
                    <% } %>
                  </td>
                  <% } %>
                </tr>
                <% } %>
              </tbody>
            </table>
          </div>
          <% } else { %>
            <p class="text-muted">No se encontró horario registrado.</p>
          <% } %>
        </div>
      </div>
    </div>
  </div>
     
  </div>

  <!-- JavaScript para actualizar hora -->
  <script>
    function actualizarHora() {
      fetch('horaPeru')
        .then(res => res.text())
        .then(hora => document.getElementById('hora-peru').textContent = hora)
        .catch(err => {
          console.error("Error al obtener la hora:", err);
          document.getElementById('hora-peru').textContent = 'Error';
        });
    }
    actualizarHora();
    setInterval(actualizarHora, 60000); // cada 60 segundos
  </script>
</div>

<jsp:include page="footer.jsp" />
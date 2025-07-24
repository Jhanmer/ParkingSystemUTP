<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="ws.ClaseHorario" %>
<jsp:include page="nav.jsp" />

<!-- Content wrapper -->
<div class="content-      // Cada 2 minutos, hacer un breve highlight para mostrar que está vivo
      if (tiempoTranscurrido % 120 === 0 && tiempoTranscurrido > 0) {
        elemento.style.color = '#3498db';
        setTimeout(() => {
          elemento.style.color = '#2c3e50';
        }, 500);
      }">
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
            <h3 class="card-title mb-2">
              <span id="hora-peru">--:--:--</span>
            </h3>
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
              <img src="assets/img/icons/unicons/points.png" alt="Puntos" class="rounded" />
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
                <img src="assets/img/icons/unicons/parking-area.png" alt="Reserva" class="rounded" />
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
  <!-- JavaScript para sincronizar hora con el servlet -->
<script>
  let horaBaseAPI = null;
  let timestampBaseAPI = null;
  let ultimaActualizacionAPI = null;
  
  // Función para actualizar la hora desde la API
  function obtenerHoraAPI() {
    fetch('horaPeru')
      .then(response => {
        if (!response.ok) throw new Error("No se pudo obtener la hora.");
        return response.text();
      })
      .then(horaTexto => {
        // Parsear la hora recibida (formato HH:mm:ss)
        const partesHora = horaTexto.split(':');
        if (partesHora.length >= 3) {
          const ahora = new Date();
          
          // Crear un objeto Date con la hora exacta de la API
          horaBaseAPI = new Date();
          horaBaseAPI.setHours(parseInt(partesHora[0]));
          horaBaseAPI.setMinutes(parseInt(partesHora[1]));
          horaBaseAPI.setSeconds(parseInt(partesHora[2])); // Ahora incluye segundos
          horaBaseAPI.setMilliseconds(0);
          
          // Guardar el timestamp cuando obtuvimos esta hora
          timestampBaseAPI = Date.now();
          
          console.log('Hora actualizada desde API (con segundos):', horaTexto);
          actualizarDisplayHora();
        } else if (partesHora.length >= 2) {
          // Fallback para formato HH:mm (por si acaso)
          const ahora = new Date();
          
          horaBaseAPI = new Date();
          horaBaseAPI.setHours(parseInt(partesHora[0]));
          horaBaseAPI.setMinutes(parseInt(partesHora[1]));
          horaBaseAPI.setSeconds(0);
          horaBaseAPI.setMilliseconds(0);
          
          timestampBaseAPI = Date.now();
          
          console.log('Hora actualizada desde API (sin segundos):', horaTexto);
          actualizarDisplayHora();
        }
      })
      .catch(error => {
        console.error("Error al obtener hora:", error);
        document.getElementById('hora-peru').textContent = 'Error de conexión';
      });
  }
  
  // Función para mostrar la hora calculada en tiempo real
  function actualizarDisplayHora() {
    if (horaBaseAPI && timestampBaseAPI) {
      // Calcular cuántos segundos han pasado desde la última actualización API
      const tiempoTranscurrido = Math.floor((Date.now() - timestampBaseAPI) / 1000);
      
      // Crear nueva hora sumando el tiempo transcurrido
      const horaActual = new Date(horaBaseAPI.getTime() + (tiempoTranscurrido * 1000));
      
      // Formatear la hora con segundos
      const horaFormateada = horaActual.toLocaleTimeString('es-PE', {
        hour12: false,
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      });
      
      // Actualizar el display
      document.getElementById('hora-peru').textContent = horaFormateada;
      
      // Agregar un indicador visual de que está funcionando
      const elemento = document.getElementById('hora-peru');
      elemento.style.color = '#2c3e50';
      
      // Cada 5 minutos, hacer un breve highlight para mostrar que está vivo
      if (tiempoTranscurrido % 300 === 0 && tiempoTranscurrido > 0) {
        elemento.style.color = '#3498db';
        setTimeout(() => {
          elemento.style.color = '#2c3e50';
        }, 500);
      }
    } else {
      // Si no tenemos datos base, mostrar hora local como fallback
      const horaLocal = new Date().toLocaleTimeString('es-PE', {
        hour12: false,
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      });
      document.getElementById('hora-peru').textContent = horaLocal;
    }
  }
  
  // Función para verificar si necesitamos re-sincronizar
  function verificarSincronizacion() {
    if (timestampBaseAPI) {
      const tiempoSinActualizar = (Date.now() - timestampBaseAPI) / 1000;
      
      // Re-sincronizar cada 2 minutos para mejor precisión con segundos
      if (tiempoSinActualizar >= 120) { // 2 minutos en lugar de 5
        console.log('Re-sincronizando hora con API (incluye segundos)...');
        obtenerHoraAPI();
      }
    }
  }
  
  // Inicializar
  obtenerHoraAPI(); // Obtener hora inicial de la API
  
  // Actualizar el display cada segundo para mostrar los segundos avanzando
  setInterval(actualizarDisplayHora, 1000);
  
  // Re-sincronizar con la API cada 2 minutos (más frecuente por los segundos)
  setInterval(verificarSincronizacion, 30000); // Verificar cada 30 segundos
  
  // Re-sincronizar también al hacer clic en la hora (para debug/manual)
  document.getElementById('hora-peru').addEventListener('click', function() {
    this.style.color = '#e74c3c';
    obtenerHoraAPI();
    setTimeout(() => {
      this.style.color = '#2c3e50';
    }, 1000);
  });
  
  // Re-sincronizar cuando la página vuelva a tener foco (ej: cambiar de pestaña)
  document.addEventListener('visibilitychange', function() {
    if (!document.hidden) {
      // La página volvió a estar visible, verificar si necesitamos actualizar
      const tiempoSinActualizar = timestampBaseAPI ? (Date.now() - timestampBaseAPI) / 1000 : 999;
      if (tiempoSinActualizar > 60) { // Si han pasado más de 1 minuto
        obtenerHoraAPI();
      }
    }
  });
</script>
</div>

<jsp:include page="footer.jsp" />
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
                %>
                <h5 class="card-title text-primary">Bienvenido <%= rol != null ? rol : "usuario" %> <%= nombre != null ? nombre : "" %>!</h5>
                <p class="mb-4">
                  Reserva tu estacionamiento. Recuerda que tenemos solo <span class="fw-bold">15 minutos</span> de tolerancia.
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
  </div>

  <!-- JavaScript para sincronizar hora con el servlet -->
  <script>
    let peruDate = null;
    let lastApiFetchTime = 0;
    let localTickIntervalId = null;

    function updateDisplayLocally() {
      if (peruDate) {
        const elapsedMillis = Date.now() - lastApiFetchTime;
        const currentPeruTimeMillis = peruDate.getTime() + elapsedMillis;
        const displayDate = new Date(currentPeruTimeMillis);

        const hours = String(displayDate.getHours()).padStart(2, '0');
        const minutes = String(displayDate.getMinutes()).padStart(2, '0');
        const seconds = String(displayDate.getSeconds()).padStart(2, '0');

        const formattedTime = `${hours}:${minutes}:${seconds}`;
        document.getElementById('hora-peru').textContent = formattedTime;
      } else {
        document.getElementById('hora-peru').textContent = 'Cargando...';
      }
    }

    function fetchAndSyncTime() {
      fetch('<%= request.getContextPath() %>/horaPeru')
        .then(response => {
          if (!response.ok) throw new Error("No se pudo obtener la hora.");
          return response.text();
        })
        .then(data => {
          const timestamp = parseInt(data.trim(), 10);
          if (!isNaN(timestamp)) {
            peruDate = new Date(timestamp * 1000);
            lastApiFetchTime = Date.now();

            clearInterval(localTickIntervalId);
            localTickIntervalId = setInterval(updateDisplayLocally, 1000);
            updateDisplayLocally();
          } else {
            document.getElementById('hora-peru').textContent = 'Hora inválida';
          }
        })
        .catch(error => {
          console.error(error);
          document.getElementById('hora-peru').textContent = 'Error al sincronizar';
        });
    }

    fetchAndSyncTime();
    setInterval(fetchAndSyncTime, 60000); // sincroniza cada 60s
  </script>
</div>
<jsp:include page="footer.jsp" />
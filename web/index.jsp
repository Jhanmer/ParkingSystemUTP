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
  fetch('https://worldtimeapi.org/api/timezone/America/Lima')
    .then(response => {
      if (!response.ok) throw new Error("No se pudo obtener la hora.");
      return response.json();
    })
    .then(data => {
      const datetime = data.datetime; // ej: "2025-07-05T14:40:33.453689-05:00"
      const hora = datetime.split("T")[1].split(":");
      const horaFormateada = `${hora[0]}:${hora[1]}:${hora[2].split(".")[0]}`;
      document.getElementById('hora-peru').textContent = horaFormateada;
    })
    .catch(error => {
      console.error(error);
      document.getElementById('hora-peru').textContent = 'Error al obtener hora';
    });
</script>
</div>
<jsp:include page="footer.jsp" />
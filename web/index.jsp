<jsp:include page="nav.jsp" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->
            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="row">
                <div class="col-lg-8 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="col-sm-7">
                        <div class="card-body">
                          <h5 class="card-title text-primary">Bienvenido estudiante Eduardo!</h5>
                          <p class="mb-4">
                            Reserva tu estacionamiento!. Recuerda que tenemos solo <span class="fw-bold">15 minutos</span> de tolerancia
                          </p>
                        </div>
                      </div>
                      <div class="col-sm-5 text-center text-sm-left">
                        <div class="card-body pb-0 px-0 px-md-4">
                          <img
                            src="assets/img/illustrations/man-with-laptop-light.png"
                            height="140"
                            alt="View Badge User"
                            data-app-dark-img="illustrations/man-with-laptop-dark.png"
                            data-app-light-img="illustrations/man-with-laptop-light.png"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4 col-md-4 order-1">
                  <div class="row">
                    <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                      </div>
                    </div>
                  </div>
                </div>
      
              </div>
              <div class="row">
                <!-- Expense Overview -->
                <div class="col-lg-6 col-md-12 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img src="assets/img/icons/unicons/chart-success.png" alt="chart success" class="rounded">
                            </div>
                            <div class="dropdown">
                              <button class="btn p-0" type="button" id="cardOpt3" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                              </button>
                            </div>
                          </div>
                          <span class="fw-semibold d-block mb-1">Hora Perú</span>
                            <h3 class="card-title mb-2" id="hora-peru">Cargando...</h3>
                          <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
                <!--/ Expense Overview -->

                <!-- Transactions -->
                <!--/ Transactions -->
              </div>
            </div>
            <script>
            let peruDate = null; 
            let lastApiFetchTime = 0; 
            let localTickIntervalId = null;

            console.log('Script iniciado.'); 

            // Función para actualizar la hora mostrada en la pantalla cada segundo (localmente)
            function updateDisplayLocally() {
                console.log('updateDisplayLocally llamado.'); 
                if (peruDate) {
                    const elapsedMillis = Date.now() - lastApiFetchTime;
                    const currentPeruTimeMillis = peruDate.getTime() + elapsedMillis;

                    const displayDate = new Date(currentPeruTimeMillis);

                    const hours = String(displayDate.getHours()).padStart(2, '0');
                    const minutes = String(displayDate.getMinutes()).padStart(2, '0');
                    const seconds = String(displayDate.getSeconds()).padStart(2, '0');

                    // **** CORRECCIÓN AQUÍ: ESCAPAMOS EL SIGNO DE DÓLAR ****
                    const formattedTime = `\${hours}:\${minutes}:\${seconds}`; 
                    console.log('Hora formateada para mostrar:', formattedTime); 

                    document.getElementById('hora-peru').textContent = formattedTime; 
                } else {
                    document.getElementById('hora-peru').textContent = 'Cargando hora... (esperando datos)';
                    console.log('peruDate es null, esperando la primera sincronización.'); 
                }
            }

            // Función para obtener un timestamp fresco del Servlet (que a su vez llama a la API)
            function fetchAndSyncTime() {
                console.log('fetchAndSyncTime llamado. Haciendo solicitud a /horaPeru...'); 
                fetch('<%= request.getContextPath() %>/horaPeru')
                    .then(response => {
                        console.log('Respuesta de Fetch recibida. Estado OK:', response.ok, 'Código:', response.status); 
                        if (!response.ok) {
                            return response.text().then(text => { 
                                console.error('Error en la respuesta del Servlet:', text); 
                                throw new Error(text || `HTTP error! Status: ${response.status}`); 
                            });
                        }
                        return response.text();
                    })
                    .then(data => {
                        console.log('Datos de timestamp recibidos del Servlet:', data); 
                        const apiTimestampSeconds = parseInt(data.trim(), 10); 
                        console.log('Timestamp parseado:', apiTimestampSeconds, ' (isNaN:', isNaN(apiTimestampSeconds), ')'); 

                        if (!isNaN(apiTimestampSeconds) && apiTimestampSeconds > 0) {
                            peruDate = new Date(apiTimestampSeconds * 1000); 
                            lastApiFetchTime = Date.now(); 

                            if (localTickIntervalId) {
                                clearInterval(localTickIntervalId);
                                console.log('Intervalo de tick local previo limpiado.'); 
                            }
                            localTickIntervalId = setInterval(updateDisplayLocally, 1000); 

                            console.log('Hora sincronizada con la API. Tick local iniciado. Próxima sincronización API en 60 segundos.');
                            updateDisplayLocally(); 
                        } else {
                            console.error('Timestamp inválido o cero recibido del Servlet:', data); 
                            document.getElementById('hora-peru').textContent = 'Error: Timestamp inválido o cero.'; 
                        }
                    })
                    .catch(error => {
                        console.error('Hubo un problema al sincronizar con la API o al procesar la respuesta:', error);
                        document.getElementById('hora-peru').textContent = `Error: ${error.message}`;
                    });
            }

            fetchAndSyncTime();
            setInterval(fetchAndSyncTime, 60 * 1000); 
            console.log('Intervalo para sincronización con API (cada 60s) establecido.'); 
        </script>
            <!-- / Content -->
<!-- Footer -->           
<jsp:include page="footer.jsp" />
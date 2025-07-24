<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ws.Reserva"%>

<jsp:include page="nav.jsp" />

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <h4 class="py-3 breadcrumb-wrapper mb-4">
        <span class="text-muted fw-light">Reservas /</span> Nueva Reserva
    </h4>
    
    <%
        Boolean reservaExitosa = (Boolean) request.getAttribute("reservaExitosa");
        Reserva reservaAsignada = (Reserva) request.getAttribute("reservaAsignada");
        String mensajeConfirmacion = (String) request.getAttribute("mensajeConfirmacion");
        
        Boolean mostrarConfirmacion = (Boolean) request.getAttribute("mostrarConfirmacion");
        Reserva reservaConfirmada = (Reserva) request.getAttribute("reservaConfirmada");
        String mensajeExito = (String) request.getAttribute("mensajeExito");
        
        boolean deberaMostrarExito = false;
        Reserva reservaParaMostrar = null;
        String mensajeParaMostrar = null;
        
        if (reservaExitosa != null && reservaExitosa && reservaAsignada != null) {
            deberaMostrarExito = true;
            reservaParaMostrar = reservaAsignada;
            mensajeParaMostrar = mensajeConfirmacion;
        } 
        else if (reservaAsignada != null && reservaAsignada.getNumeroEstacionamiento() != null) {
            deberaMostrarExito = true;
            reservaParaMostrar = reservaAsignada;
            mensajeParaMostrar = "Reserva procesada correctamente";
        }
        else if (mostrarConfirmacion != null && mostrarConfirmacion && reservaConfirmada != null) {
            deberaMostrarExito = true;
            reservaParaMostrar = reservaConfirmada;
            mensajeParaMostrar = mensajeExito;
        }
        
        if (deberaMostrarExito && reservaParaMostrar != null) {
    %>
        <div class="row">
            <div class="col-md-10 mx-auto">
                <div class="alert alert-success alert-dismissible" role="alert">
                    <div class="d-flex align-items-center mb-3">
                        <i class='bx bx-check-circle bx-lg text-success me-2'></i>
                        <h4 class="alert-heading mb-0">🎉 ¡Reserva Confirmada!</h4>
                    </div>
                    <p class="mb-3"><strong>Tu estacionamiento ha sido reservado exitosamente:</strong></p>
                    
                    <div class="card bg-light border-0 mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <p class="mb-2"><strong>🅿️ Estacionamiento:</strong> 
                                        <span class="badge bg-primary fs-6">
                                            <%= reservaParaMostrar.getNumeroEstacionamiento() != null ? reservaParaMostrar.getNumeroEstacionamiento() : "N/A" %>
                                        </span>
                                    </p>
                                    <p class="mb-2"><strong>📅 Fecha:</strong> 
                                        <%= reservaParaMostrar.getFecha() != null ? reservaParaMostrar.getFecha() : "N/A" %>
                                    </p>
                                </div>
                                <div class="col-sm-6">
                                    <p class="mb-2"><strong>🕐 Hora inicio:</strong> 
                                        <%= reservaParaMostrar.getHoraInicio() != null ? reservaParaMostrar.getHoraInicio() : "N/A" %>
                                    </p>
                                    <p class="mb-2"><strong>🕐 Hora fin:</strong> 
                                        <%= reservaParaMostrar.getHoraFin() != null ? reservaParaMostrar.getHoraFin() : "N/A" %>
                                    </p>
                                </div>
                            </div>
                            <% if (mensajeParaMostrar != null) { %>
                                <div class="alert alert-info mt-2 mb-0">
                                    <i class='bx bx-info-circle me-1'></i>
                                    <%= mensajeParaMostrar %>
                                </div>
                            <% } %>
                        </div>
                    </div>
                    
                    <div class="d-flex gap-2 align-items-center">
                        <i class='bx bx-info-circle text-info'></i>
                        <small><strong>Recuerda:</strong> Lleva tu carné SUNEDU o DNI + carné UTP (físico o virtual).</small>
                    </div>
                    
                    <div class="mt-3">
                        <a href="MiReservaServlet" class="btn btn-outline-success me-2">
                            <i class="bx bx-list-ul me-1"></i>Ver mis reservas
                        </a>
                        <a href="index.jsp" class="btn btn-outline-primary">
                            <i class="bx bx-home me-1"></i>Ir al inicio
                        </a>
                    </div>
                    
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </div>
    <%
        }
    %>

    <%
        String mensajeError = (String) request.getAttribute("mensajeError");
        Boolean mostrarError = (Boolean) request.getAttribute("mostrarError");
        
        boolean deberaMostrarError = false;
        
        if (!deberaMostrarExito && mensajeError != null) {
            if ((reservaExitosa != null && !reservaExitosa) || (mostrarError != null && mostrarError)) {
                deberaMostrarError = true;
            }
        }
        
        if (deberaMostrarError) {
    %>
        <div class="row">
            <div class="col-md-10 mx-auto">
                <div class="alert alert-warning alert-dismissible" role="alert">
                    <div class="d-flex align-items-center mb-2">
                        <i class='bx bx-error-circle bx-lg text-warning me-2'></i>
                        <h4 class="alert-heading mb-0">⚠️ No hay disponibilidad</h4>
                    </div>
                    <p class="mb-2"><strong>No se encontraron estacionamientos disponibles para el horario solicitado.</strong></p>
                    <div class="alert alert-info mt-2 mb-0">
                        <h6 class="text-info mb-2">💡 Sugerencias:</h6>
                        <ul class="mb-0 text-muted">
                            <li>Intenta con un horario diferente (menos demandado)</li>
                            <li>Selecciona menos horas de reserva</li>
                            <li>Prueba reservar para otro día</li>
                            <li>Los horarios de 8:15-11:15 y 14:15-17:15 suelen tener más disponibilidad</li>
                        </ul>
                    </div>
                    <div class="mt-3">
                        <small class="text-muted">
                            <i class='bx bx-info-circle me-1'></i>
                            Si el problema persiste, contacta al administrador del sistema.
                        </small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </div>
    <%
        }
    %>

    <%
        if (!deberaMostrarExito) {
    %>
    <div class="row">
        <div class="col-md-10 mx-auto">
            
            <%
                Integer puntos = (Integer) request.getAttribute("puntosDisponibles");
                java.time.LocalDate fechaReserva = (java.time.LocalDate) request.getAttribute("fechaReserva");
                String fechaReservaStr = (String) request.getAttribute("fechaReservaStr");
                
                if (puntos != null && fechaReserva != null) {
            %>
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h5 class="card-title mb-1">
                                    <i class='bx bx-calendar-plus text-primary me-2'></i>Nueva Reserva
                                </h5>
                                <p class="text-muted mb-0">Reserva tu estacionamiento para mañana</p>
                            </div>
                            <div class="col-md-4 text-md-end">
                                <div class="d-flex align-items-center justify-content-md-end">
                                    <img src="assets/img/icons/unicons/points.png" alt="Puntos" class="me-2" width="24">
                                    <span class="text-muted">Puntos disponibles:</span>
                                    <span class="badge bg-success ms-2 fs-6"><%= puntos %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                } else {
            %>
                <div class="alert alert-warning">
                    <i class='bx bx-error text-warning me-2'></i>
                    <strong>Error:</strong> No se pudieron cargar los datos de reserva.
                </div>
            <%
                }
            %>

            <div class="card shadow-sm">
                <div class="card-body">
                    <form action="ReservarServlet" method="post" id="reservaForm">
                        
                        <div class="mb-3">
                            <label for="fecha" class="form-label">📅 Fecha de reserva:</label>
                            <input type="text" class="form-control" id="fechaDisplay" 
                                   value="<%= fechaReserva != null ? fechaReserva : "" %>" readonly>
                            <input type="hidden" name="fecha" value="<%= fechaReservaStr != null ? fechaReservaStr : "" %>">
                            <small class="form-text text-muted">Las reservas son para el día siguiente únicamente.</small>
                        </div>

                        <div class="mb-3">
                            <label for="puntosUsar" class="form-label">🎯 Puntos a utilizar:</label>
                            <select class="form-control" id="puntosUsar" name="puntosUsar" required onchange="calcularHoras()">
                                <option value="">Selecciona los puntos</option>
                                <%
                                    if (puntos != null && puntos > 0) {
                                        for (int i = 1; i <= puntos && i <= 6; i++) {
                                %>
                                            <option value="<%= i %>"><%= i %> punto<%= i > 1 ? "s" : "" %> - <%= (i * 90) %> minutos</option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <small class="form-text text-muted">Cada punto equivale a 1 hora y 30 minutos.</small>
                        </div>

                        <div class="mb-3">
                            <label for="horainicio" class="form-label">🕐 Hora de inicio:</label>
                            <input type="time" 
                                   class="form-control" 
                                   id="horainicio" 
                                   name="horainicio" 
                                   min="08:15" 
                                   max="21:30" 
                                   step="900" 
                                   required 
                                   onchange="calcularHoras()">
                            <small class="form-text text-muted">
                                <i class='bx bx-info-circle me-1'></i>
                                Horario disponible: 08:15 - 21:30 (intervalos de 15 minutos). 
                                La reserva debe terminar antes de las 22:15.
                            </small>
                        </div>

                        <div class="mb-3">
                            <label for="horasalida" class="form-label">🕐 Hora de salida (calculada automáticamente):</label>
                            <input type="text" class="form-control" id="horasalidaDisplay" readonly 
                                   placeholder="Se calculará según los puntos seleccionados">
                            <input type="hidden" id="horasalida" name="horasalida">
                        </div>

                        <div class="mb-3" id="resumenReserva" style="display: none;">
                            <div class="alert alert-info" role="alert">
                                <h6 class="alert-heading">📝 Resumen de tu reserva:</h6>
                                <div id="resumenContenido"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="aceptarTerminos" required>
                                <label class="form-check-label" for="aceptarTerminos">
                                    Acepto los <a href="#" class="text-primary">términos y condiciones</a> <span class="text-danger">*</span>
                                </label>
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary" id="btnConfirmarReserva" disabled>
                                <i class="bx bx-check me-1"></i>
                                Confirmar Reserva
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>

  </div>
</div>

<jsp:include page="footer.jsp" />

<script>
let formularioEnviado = false;
const form = document.getElementById('reservaForm');
const btnConfirmar = document.getElementById('btnConfirmarReserva');

form.addEventListener('submit', function(e) {
    if (formularioEnviado) {
        e.preventDefault();
        return false;
    }
    
    formularioEnviado = true;
    btnConfirmar.disabled = true;
    btnConfirmar.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Procesando...';
});

function calcularHoras() {
    const puntosSelect = document.getElementById('puntosUsar');
    const horaInicioInput = document.getElementById('horainicio');
    const horasalidaDisplay = document.getElementById('horasalidaDisplay');
    const horasalidaHidden = document.getElementById('horasalida');
    const resumenDiv = document.getElementById('resumenReserva');
    
    const puntos = parseInt(puntosSelect.value);
    const horaInicio = horaInicioInput.value;
    
    if (!puntos || !horaInicio) {
        horasalidaDisplay.value = '';
        horasalidaHidden.value = '';
        resumenDiv.style.display = 'none';
        actualizarBotonConfirmar();
        return;
    }
    
    const [horas, minutos] = horaInicio.split(':').map(Number);
    const minutosInicio = horas * 60 + minutos;
    const minutosAdicionales = puntos * 90;
    const minutosSalida = minutosInicio + minutosAdicionales;
    
    const limiteMinutos = 22 * 60 + 15;
    
    if (minutosSalida > limiteMinutos) {
        alert('⚠️ La hora de salida excede el horario límite (22:15). Por favor, selecciona menos puntos o una hora de inicio más temprana.');
        puntosSelect.value = '';
        horasalidaDisplay.value = '';
        horasalidaHidden.value = '';
        resumenDiv.style.display = 'none';
        actualizarBotonConfirmar();
        return;
    }
    
    const horasSalida = Math.floor(minutosSalida / 60);
    const minutosSalidaResto = minutosSalida % 60;
    const horaFormatted = String(horasSalida).padStart(2, '0') + ':' + String(minutosSalidaResto).padStart(2, '0');
    
    horasalidaDisplay.value = horaFormatted;
    horasalidaHidden.value = horaFormatted;
    
    mostrarResumen(puntos, horaInicio, horaFormatted);
}

function mostrarResumen(puntos, horaInicio, horaFormatted) {
    const fechaDisplay = document.getElementById('fechaDisplay').value;
    const resumenDiv = document.getElementById('resumenReserva');
    const resumenContenido = document.getElementById('resumenContenido');
    
    const duracionHoras = Math.floor((puntos * 90) / 60);
    const duracionMins = (puntos * 90) % 60;
    
    const contenidoHTML = 
        '<strong>📅 Fecha:</strong> ' + fechaDisplay + '<br>' +
        '<strong>⏰ Horario:</strong> ' + horaInicio + ' - ' + horaFormatted + '<br>' +
        '<strong>🕐 Duración:</strong> ' + duracionHoras + 'h ' + duracionMins + 'm (' + puntos + ' punto' + (puntos > 1 ? 's' : '') + ')<br>' +
        '<strong>🅿️ Estacionamiento:</strong> Se asignará automáticamente';
    
    resumenContenido.innerHTML = contenidoHTML;
    resumenDiv.style.display = 'block';
    actualizarBotonConfirmar();
}

function actualizarBotonConfirmar() {
    const terminos = document.getElementById('aceptarTerminos');
    const resumenVisible = document.getElementById('resumenReserva').style.display !== 'none';
    btnConfirmar.disabled = !(terminos.checked && resumenVisible);
}

document.getElementById('aceptarTerminos').addEventListener('change', actualizarBotonConfirmar);
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="nav.jsp" />
<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">

        <div class="row">
            <div class="col-md-8 mx-auto">

                <%-- Mensaje de éxito --%>
                <% if (request.getAttribute("reservaExitosa") != null && (Boolean) request.getAttribute("reservaExitosa")) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>¡Éxito!</strong> <%= request.getAttribute("mensajeConfirmacion") %><br>
                        <% if (request.getAttribute("reservaAsignada") != null) {
                            ws.Reserva reservaAsignada = (ws.Reserva) request.getAttribute("reservaAsignada");
                        %>
                            Su estacionamiento asignado es: <strong><%= reservaAsignada.getNumeroEstacionamiento() %></strong>.<br>
                            ID de su reserva: <strong><%= reservaAsignada.getId() %></strong>.
                        <% } %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <%-- Mensaje de error --%>
                <% if (request.getAttribute("reservaExitosa") != null && !(Boolean) request.getAttribute("reservaExitosa")) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Error:</strong> <%= request.getAttribute("mensajeError") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <%-- Mostrar puntos disponibles --%>
                <%
                    Integer puntos = (Integer) request.getAttribute("puntosDisponibles");
                    java.time.LocalDate manana = java.time.LocalDate.now().plusDays(1);
                    if (puntos != null) {
                %>
                    <div class="alert alert-info">
                        Tienes <strong><%= puntos %></strong> puntos disponibles para mañana (<%= manana %>).
                    </div>
                <%
                    }
                %>
            </div>
        </div>

        <div class="card shadow-sm mx-auto" style="max-width: 600px;">
            <div class="card-body">
                <h4 class="card-title">Reserva de estacionamiento</h4>
                <p class="text-muted">
                    Escoge el lugar donde reservarás tu estacionamiento.<br>
                    <strong>Recuerda:</strong> Acércate con tu carné SUNEDU o DNI + carné UTP en físico o virtual.
                </p>

                <form action="ReservarServlet" method="post">
                    <%-- ID del usuario oculto si es necesario --%>
                    <%-- <input type="hidden" name="usuarioId" value="<%= request.getSession().getAttribute("idUsuario") %>"> --%>

                    <div class="mb-3">
                        <label for="fecha" class="form-label">Fechas disponibles:</label>
                        <input type="date" class="form-control" id="fecha" name="fecha"
                               value="<%= manana %>" min="<%= manana %>">
                        <small class="form-text text-muted">El horario de atención es de 08:15 a 22:15.</small>
                    </div>

                    <div class="mb-3">
                        <label for="horainicio" class="form-label">Hora de inicio:</label>
                        <input type="time" class="form-control" id="horainicio" name="horainicio" value="08:15" step="60">
                    </div>

                    <div class="mb-3">
                        <label for="horasalida" class="form-label">Hora de salida:</label>
                       <input type="time" class="form-control" id="horasalida" name="horasalida" value="09:45" step="60"> <%-- De 08:15 a 09:45 son 90 minutos --%>
                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="terminos" name="terminos" required>
                        <label class="form-check-label" for="terminos">
                            Aceptar <a href="#">términos y condiciones</a> <span class="text-danger">*</span>
                        </label>
                    </div>

                    <%-- Condicional para mostrar el botón solo si tiene puntos --%>
                    <%
                        Boolean intentoReserva = (Boolean) request.getAttribute("reservaExitosa");

                        if (intentoReserva == null) {
                            // Primera vez que se entra al formulario
                    %>
                            <button type="submit" class="btn btn-primary">Reservar</button>
                    <%
                        } else if (puntos != null && puntos > 0) {
                    %>
                            <button type="submit" class="btn btn-primary">Reservar</button>
                    <%
                        } else {
                    %>
                            <div class="alert alert-warning">
                                No tienes puntos suficientes para reservar mañana.
                            </div>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />

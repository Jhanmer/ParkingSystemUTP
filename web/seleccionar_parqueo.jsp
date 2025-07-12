<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="nav.jsp" />
<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">

        <div class="row">
            <div class="col-md-8 mx-auto">
                <%-- Mensaje de éxito --%>
                <% if (request.getAttribute("reservaExitosa") != null && (Boolean) request.getAttribute("reservaExitosa")) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>¡Éxito!</strong> <%= request.getAttribute("mensajeConfirmacion") %>
                        <br>
                        <%-- Mostrar el número de estacionamiento asignado si la reserva fue exitosa --%>
                        <% if (request.getAttribute("reservaAsignada") != null) {
                            ws.Reserva reservaAsignada = (ws.Reserva) request.getAttribute("reservaAsignada");
                        %>
                            Su estacionamiento asignado es: <strong><%= reservaAsignada.getNumeroEstacionamiento() %></strong>.
                            <br>
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
                    <%-- Podrías añadir un campo oculto para el ID del usuario si lo manejas directamente desde el formulario --%>
                    <%-- Por ejemplo, si el usuario está logueado y su ID se pasa a este JSP: --%>
                    <%-- <input type="hidden" name="usuarioId" value="<%= request.getSession().getAttribute("idUsuario") %>"> --%>
                    
                    <div class="mb-3">
                        <label for="fecha" class="form-label">Fechas disponibles:</label>
                        <input type="date" class="form-control" id="fecha" name="fecha" value="<%= java.time.LocalDate.now().plusDays(1) %>" min="<%= java.time.LocalDate.now().plusDays(1) %>">
                        <small class="form-text text-muted">El horario de atención es de 08:15 a 22:15.</small>
                    </div>

                    <div class="mb-3">
                        <label for="horainicio" class="form-label">Hora de inicio:</label>
                        <input type="time" class="form-control" id="horainicio" name="horainicio" value="08:15" step="60">
                    </div>

                    <div class="mb-3">
                        <label for="horasalida" class="form-label">Hora de salida:</label>
                        <input type="time" class="form-control" id="horasalida" name="horasalida" value="09:15" step="60">
                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="terminos" name="terminos" required>
                        <label class="form-check-label" for="terminos">
                            Aceptar <a href="#">términos y condiciones</a> <span class="text-danger">*</span>
                        </label>
                    </div>
                   <!--<button type="submit" class="btn btn-primary">Reservar</button>-->
                    <a href="confirmacionReserva.jsp">Reservar</a>
                </form>
            </div>
        </div>

    </div>
</div>
<jsp:include page="footer.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="servicio.Reserva" %>

<jsp:include page="nav.jsp" />

<!-- Content wrapper -->
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <h4 class="fw-bold py-3 mb-4">Listado de Reservas</h4>

    <div class="card">
      <div class="card-body">
        
        <table class="table table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Usuario</th>
              <th>Estacionamiento</th>
              <th>Fecha</th>
              <th>Hora Inicio</th>
              <th>Hora Fin</th>
              <th>Estado</th>
              <th>Acción</th>
            </tr>
          </thead>
          <tbody>
            <%
              List<Reserva> lista = (List<Reserva>) request.getAttribute("listaReservas");
              if (lista != null && !lista.isEmpty()) {
                  for (Reserva r : lista) {
            %>
            <tr>
              <td><%= r.getId() %></td>
              <td><%= r.getUsuarioId() %></td>
              <td><%= r.getCodEsta() %></td>
              <td><%= r.getFecha() %></td>
              <td><%= r.getHoraInicio() %></td>
              <td><%= r.getHoraFin() %></td>
              <td><%= r.getEstado() %></td>
              <td>
                <form action="cambiarEstadoReserva" method="post" style="display:flex; gap:5px;">
                  <input type="hidden" name="idReserva" value="<%= r.getId() %>">
                  <select name="nuevoEstado" class="form-select" style="width: 130px;">
    <option value="reservada" <%= r.getEstado().equalsIgnoreCase("reservada") ? "selected" : "" %>>Reservada</option>
    <option value="asistio" <%= r.getEstado().equalsIgnoreCase("asistio") ? "selected" : "" %>>Asistió</option>
    <option value="cancelada" <%= r.getEstado().equalsIgnoreCase("cancelada") ? "selected" : "" %>>Cancelada</option>
    <option value="no_asistio" <%= r.getEstado().equalsIgnoreCase("no_asistio") ? "selected" : "" %>>No Asistió</option>
    <option value="culmino_tiempo" <%= r.getEstado().equalsIgnoreCase("culmino_tiempo") ? "selected" : "" %>>Culminó Tiempo</option>
</select>

                  <button type="submit" class="btn btn-primary btn-sm">Cambiar</button>
                </form>
              </td>
            </tr>
            <%
                  }
              } else {
            %>
            <tr>
              <td colspan="8" class="text-center">No hay reservas registradas</td>
            </tr>
            <%
              }
            %>
          </tbody>
        </table>

      </div>
    </div>

  </div>
</div>

<jsp:include page="footer.jsp" />

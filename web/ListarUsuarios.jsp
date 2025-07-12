<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List"%>
<%@page import="servicio.Usuario"%>

<jsp:include page="nav.jsp" />

<!-- Content wrapper -->
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <h4 class="fw-bold py-3 mb-4">Lista de Usuarios</h4>

    <div class="card">
      <div class="card-body">

        <table class="table table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nombre</th>
              <th>Apellido</th>
              <th>Correo</th>
              <th>Rol</th>
              <th>Fecha de Registro</th>
            </tr>
          </thead>
          <tbody>
            <%
              List<Usuario> lista = (List<Usuario>) request.getAttribute("listaUsuarios");
              if (lista != null && !lista.isEmpty()) {
                  for (Usuario u : lista) {
            %>
            <tr>
              <td><%= u.getId() %></td>
              <td><%= u.getNombre() %></td>
              <td><%= u.getApellido() %></td>
              <td><%= u.getCorreo() %></td>
              <td><%= u.getRol() %></td>
              <td><%= u.getFechaRegistro() %></td>
            </tr>
            <%
                  }
              } else {
            %>
            <tr>
              <td colspan="7" class="text-center">No hay usuarios registrados</td>
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

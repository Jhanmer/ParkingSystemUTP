package servicios;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import ws.ServicioUsuarioService;  // Cambiado a la nueva clase de servicio
import ws.ServicioUsuario;        // Cambiado a la nueva clase de servicio
import ws.Usuario;            // Importa el modelo Usuario

@WebServlet("/listar")
public class ListarUsuariosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Crear cliente del servicio con el nombre actualizado
            ServicioUsuarioService servicio = new ServicioUsuarioService();  // Cambiado a 'ServicioUsuarioService'
            ServicioUsuario port = servicio.getServicioUsuarioPort();  // Cambiado a 'getServicioUsuarioPort()'

            // Llamada al método listarUsuarios
            List<Usuario> usuarios = port.listarUsuarios();

            // Mostrar la cantidad de usuarios obtenidos
            System.out.println("Cantidad de usuarios recibidos: " + usuarios.size());

            // Pasar la lista de usuarios a la vista (JSP)
            request.setAttribute("listaUsuarios", usuarios);
            request.getRequestDispatcher("ListarUsuarios.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
        }
    }
}

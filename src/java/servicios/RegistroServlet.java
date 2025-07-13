package servicios;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import ws.ServicioUsuario;
import ws.ServicioUsuarioService;  // Cambiado a 'ServicioUsuarioService'

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");

        // Validación de correo institucional
        if (!correo.endsWith("@utp.edu.pe")) {
            request.setAttribute("mensaje", "Debe usar correo institucional @utp.edu.pe");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        try {
            // Crear cliente del servicio con el nombre actualizado
            ServicioUsuarioService servicio = new ServicioUsuarioService();  // Cambiar a 'ServicioUsuarioService'
            ServicioUsuario port = servicio.getServicioUsuarioPort();  // Cambiar a 'getServicioUsuarioPort()'

            // Llamada al método registrar
            String resultado = port.registrar(nombre, apellido, correo, contrasena, rol);

            request.setAttribute("mensaje", resultado);  // Mostrar mensaje con el resultado
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        } catch (Exception e) {
            // Manejo de errores al conectar con el servicio
            request.setAttribute("mensaje", "Error al conectar con el servicio: " + e.getMessage());
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }
}

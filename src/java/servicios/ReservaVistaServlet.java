package servicios;

import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import ws.ReservasWS;
import ws.ReservasWS_Service;

@WebServlet(name = "ReservaVistaServlet", urlPatterns = {"/ReservaVistaServlet"})
public class ReservaVistaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        try {
            Integer usuarioId = (Integer) request.getSession().getAttribute("idUsuario");
            if (usuarioId == null) {
                response.sendRedirect("login.jsp"); // o como manejes sesiones
                return;
            }

            // Obtener la fecha de mañana
            LocalDate manana = LocalDate.now().plusDays(1);
            String fechaStr = manana.toString();

            // Llamar al servicio web
            ReservasWS_Service service = new ReservasWS_Service();
            ReservasWS port = service.getReservasWSPort();
            int puntos = port.obtenerPuntosPorDia(usuarioId, fechaStr);

            // Pasar los puntos a la vista
            request.setAttribute("puntosDisponibles", puntos);
            request.getRequestDispatcher("seleccionar_parqueo.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("mensajeError", "Error al cargar los puntos: " + ex.getMessage());
            request.getRequestDispatcher("seleccionar_parqueo.jsp").forward(request, response);
        }
    }
}

package servicios;

import ws.EstudianteWS;
import ws.EstudianteWS_Service;
import ws.ClaseHorario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/inicioEstudiante")
public class InicioEstudianteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Integer usuarioId = (Integer) sesion.getAttribute("idUsuario");

        if (usuarioId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("ID DE USUARIO EN SESIÓN: " + usuarioId); 

        try {
            // Cliente del Web Service
            EstudianteWS_Service service = new EstudianteWS_Service();
            EstudianteWS port = service.getEstudianteWSPort();

            // Obtener puntos
            String puntos = port.obtenerPuntos(usuarioId);
            request.setAttribute("puntos", puntos);

            // Obtener reserva
            String reserva = port.obtenerReservaHoy(usuarioId);
            if (reserva != null && !reserva.isEmpty()) {
                request.setAttribute("reservaHoy", reserva);
            }

            // Obtener horario
            List<ClaseHorario> horario = port.obtenerHorario(usuarioId);
            request.setAttribute("horarioCompleto", horario);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar datos del Web Service");
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
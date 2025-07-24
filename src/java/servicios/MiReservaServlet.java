package servicios;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ws.Reserva;
import ws.ReservasWS;
import ws.ReservasWS_Service;

@WebServlet("/MiReservaServlet")
public class MiReservaServlet extends HttpServlet {

    private ReservasWS_Service servicio;

    @Override
    public void init() throws ServletException {
        servicio = new ReservasWS_Service();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer usuarioId = (Integer) session.getAttribute("idUsuario");

            if (usuarioId == null) {
                response.sendRedirect("login.jsp");
                return;
            } 
            
            ReservasWS port = servicio.getReservasWSPort();
            List<Reserva> historialReservas = port.listarHistorialReservasPorUsuario(usuarioId);

            request.setAttribute("historialReservas", historialReservas);
            request.getRequestDispatcher("mireserva.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error al cargar las reservas: " + e.getMessage());
            request.getRequestDispatcher("mireserva.jsp").forward(request, response);
        }
    }
}
    


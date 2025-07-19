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
import ws.Usuario;

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
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            if (usuario  == null) {
                response.sendRedirect("login.jsp"); // O maneja el caso de sesión expirada
                return;
            }
            
             int usuarioId = usuario.getId(); 
            
            ReservasWS port = servicio.getReservasWSPort();
            List<Reserva> historialReservas = port.listarHistorialReservasPorUsuario(usuarioId);
            
             System.out.println("Reservas encontradas: " + historialReservas.size());

            request.setAttribute("historialReservas", historialReservas);
            RequestDispatcher dispatcher = request.getRequestDispatcher("mireserva.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
        }
    }
}

package servicios;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import ws.ReservasWS;
import ws.ReservasWS_Service;
import ws.Reserva;

@WebServlet("/listarReservas")
public class ListarReservasServlet extends HttpServlet {

    private ReservasWS_Service servicio;

    @Override
    public void init() throws ServletException {
        servicio = new ReservasWS_Service();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ReservasWS port = servicio.getReservasWSPort();
            List<Reserva> lista = port.listarReservas();

            request.setAttribute("listaReservas", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher("ListadoReservas.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
        }
    }
}

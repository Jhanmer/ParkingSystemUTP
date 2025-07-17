
package servicios;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ws.Estacionamiento;

import ws.ReservasWS;
import ws.ReservasWS_Service;
import ws.Reserva;

@WebServlet(name = "ListarEstacionamientosServlet", urlPatterns = {"/ListarEstacionamientosServlet"})
public class ListarEstacionamientosServlet extends HttpServlet {

    private ReservasWS_Service servicio;

    @Override
    public void init() throws ServletException {
        servicio = new ReservasWS_Service();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ReservasWS port = servicio.getReservasWSPort();

            RequestDispatcher dispatcher = request.getRequestDispatcher("Parqueo.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
        }
    }

}

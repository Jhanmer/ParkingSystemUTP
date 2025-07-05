package servicios;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import ws.ReservasWS;
import ws.ReservasWS_Service;

@WebServlet("/cambiarEstadoReserva")
public class CambiarEstadoReservaServlet extends HttpServlet {

    private ReservasWS_Service servicio;

    @Override
    public void init() throws ServletException {
        servicio = new ReservasWS_Service();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            String nuevoEstado = request.getParameter("nuevoEstado");

            ReservasWS port = servicio.getReservasWSPort();
            boolean actualizado = port.cambiarEstadoReserva(idReserva, nuevoEstado);

            if (actualizado) {
                System.out.println("Estado actualizado correctamente.");
            } else {
                System.out.println("Error al actualizar el estado.");
            }

            response.sendRedirect(request.getContextPath() + "/listarReservas");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
        }
    }
}

package servicios;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import servicio.ServicioReservas_Service;
import servicio.ServicioReservas;

@WebServlet("/cambiarEstadoReserva")
public class CambiarEstadoReservaServlet extends HttpServlet {

    private ServicioReservas_Service servicio;

    @Override
    public void init() throws ServletException {
        servicio = new ServicioReservas_Service();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            String nuevoEstado = request.getParameter("nuevoEstado");

            ServicioReservas port = servicio.getServicioReservasPort();
            boolean actualizado = port.cambiarEstadoReserva(idReserva, nuevoEstado);

            if (actualizado) {
                System.out.println("Estado actualizado correctamente.");
            } else {
                System.out.println("Error al actualizar el estado.");
            }

            // Redirigir nuevamente al listado
            response.sendRedirect(request.getContextPath() + "/listarReservas");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
        }
    }
}

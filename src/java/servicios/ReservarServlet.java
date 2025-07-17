
package servicios;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.WebServiceRef;
import ws.Reserva;
import ws.ReservasWS_Service;

@WebServlet(name = "ReservarServlet", urlPatterns = {"/ReservarServlet"})
public class ReservarServlet extends HttpServlet {

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/Servicio_Reserva/index.jsp/ReservasWS.wsdl")
    private ReservasWS_Service service;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Obtener datos del formulario
            String fecha = request.getParameter("fecha");
            String horaInicio = request.getParameter("horainicio");
            String horaFin = request.getParameter("horasalida");

            // 2. Obtener el ID del usuario desde sesión
            Integer usuarioId = (Integer) request.getSession().getAttribute("idUsuario");

            if (usuarioId == null) {
                request.setAttribute("reservaExitosa", false);
                request.setAttribute("mensajeError", "No se ha identificado al usuario.");
                request.getRequestDispatcher("seleccionar_parqueo.jsp").forward(request, response);
                return;
            }
            
            
            LocalDate fechaObj = LocalDate.parse(fecha);
            // Conexión al Web Service
            ws.ReservasWS_Service service = new ws.ReservasWS_Service();
            ws.ReservasWS port = service.getReservasWSPort();

            String fechaStr = fecha; 
            int puntos;
            puntos = port.obtenerSaldoPuntosUsuario(usuarioId);
            System.out.println("Puntos obtenidos para mañana: " + puntos);
            // Establecer los puntos para mostrar en el JSP si deseas
            request.setAttribute("puntosDisponibles", puntos);
            System.out.println("Fecha recibida: " + horaFin);
            System.out.println("Hora inicio recibida: " + horaInicio);
            System.out.println("Hora fin recibida: " + horaFin);

            // Validar puntos
            if (puntos < 1) {
                request.setAttribute("reservaExitosa", false);
                request.setAttribute("mensajeError", "No tienes puntos suficientes para reservar mañana.");
                request.getRequestDispatcher("seleccionar_parqueo.jsp").forward(request, response);
                return;
            }
            ws.Reserva reserva = port.generarReservaAutomatica(usuarioId, fecha, horaInicio, horaFin);

            if (reserva != null) {
                request.setAttribute("reservaExitosa", true);
                request.setAttribute("mensajeConfirmacion", "Reserva generada correctamente.");
                request.setAttribute("reservaAsignada", reserva);
            } else {
                request.setAttribute("reservaExitosa", false);
                request.setAttribute("mensajeError", "No se pudo generar la reserva. Verifica disponibilidad o tus puntos.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("reservaExitosa", false);
            request.setAttribute("mensajeError", "Error en el proceso de reserva: " + ex.getMessage());
        }

        // 4. Redirigir a la página con mensajes
        request.getRequestDispatcher("seleccionar_parqueo.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que gestiona la reserva de estacionamientos vía servicio web.";
    }

    private Reserva generarReservaAutomatica(int usuarioId, java.lang.String fecha, java.lang.String horaInicio, java.lang.String horaFin) {

        ws.ReservasWS port = service.getReservasWSPort();
        return port.generarReservaAutomatica(usuarioId, fecha, horaInicio, horaFin);
    }

}

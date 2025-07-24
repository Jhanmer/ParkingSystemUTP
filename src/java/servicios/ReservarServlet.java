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
import ws.ReservasWS;
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

            // VALIDACIÓN ULTRA SIMPLE - sin métodos que puedan fallar
            boolean reservaValida = false;
            
            if (reserva != null) {
                System.out.println("🔍 Analizando reserva recibida...");
                System.out.println("   - ID: " + reserva.getId());
                System.out.println("   - Estacionamiento: " + reserva.getNumeroEstacionamiento());
                
                // Verificar solo si existe número de estacionamiento
                String numeroEstacionamiento = reserva.getNumeroEstacionamiento();
                if (numeroEstacionamiento != null) {
                    if (numeroEstacionamiento.length() > 0) {
                        reservaValida = true;
                        System.out.println("✅ Reserva válida por número de estacionamiento");
                    }
                }
                
                if (!reservaValida) {
                    System.out.println("❌ Sin número de estacionamiento válido");
                }
            }
            
            if (reservaValida) {
                System.out.println("✅ Reserva creada exitosamente:");
                System.out.println("   - ID: " + reserva.getId());
                System.out.println("   - Estacionamiento: " + reserva.getNumeroEstacionamiento());
                System.out.println("   - Fecha: " + reserva.getFecha());
                System.out.println("   - Horario: " + reserva.getHoraInicio() + " - " + reserva.getHoraFin());
                
                request.setAttribute("reservaExitosa", true);
                request.setAttribute("mensajeConfirmacion", "Reserva generada correctamente en estacionamiento " + reserva.getNumeroEstacionamiento());
                request.setAttribute("reservaAsignada", reserva);
                
            } else {
                System.out.println("❌ Reserva fallida o incompleta:");
                if (reserva != null) {
                    System.out.println("   - ID recibido: " + reserva.getId());
                    System.out.println("   - Estacionamiento: " + reserva.getNumeroEstacionamiento());
                    System.out.println("   - Objeto reserva existe pero datos insuficientes");
                } else {
                    System.out.println("   - Objeto reserva es null");
                }
                
                request.setAttribute("reservaExitosa", false);
                request.setAttribute("mensajeError", "No se pudo generar la reserva. Verifica disponibilidad o tus puntos.");
            }

        } catch (Exception ex) {
            System.out.println("❌ Error en ReservarServlet: " + ex.getMessage());
            ex.printStackTrace();
            request.setAttribute("reservaExitosa", false);
            request.setAttribute("mensajeError", "Error en el proceso de reserva: " + ex.getMessage());
        }

        // 4. Redirigir CORRECTAMENTE al servlet vista (no directamente al JSP)
        System.out.println("🔄 Redirigiendo a ReservaVistaServlet...");
        request.getRequestDispatcher("ReservaVistaServlet").forward(request, response);
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

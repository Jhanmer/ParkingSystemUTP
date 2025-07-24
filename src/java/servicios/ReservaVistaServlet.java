package servicios;

import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import ws.ReservasWS;
import ws.ReservasWS_Service;
import ws.Reserva;

@WebServlet(name = "ReservaVistaServlet", urlPatterns = {"/ReservaVistaServlet"})
public class ReservaVistaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Acceso directo vía GET - mostrar formulario limpio
        System.out.println("📥 ReservaVistaServlet - Acceso directo GET");
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Viene de ReservarServlet con datos de reserva
        System.out.println("📥 ReservaVistaServlet - POST desde ReservarServlet");
        processRequest(request, response);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        try {
            Integer usuarioId = (Integer) request.getSession().getAttribute("idUsuario");
            if (usuarioId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Verificar si viene de una reserva (SOLO verificar, no crear nueva)
            Boolean reservaExitosa = (Boolean) request.getAttribute("reservaExitosa");
            Reserva reservaAsignada = (Reserva) request.getAttribute("reservaAsignada");
            String mensajeConfirmacion = (String) request.getAttribute("mensajeConfirmacion");
            String mensajeError = (String) request.getAttribute("mensajeError");

            System.out.println("🔍 ReservaVistaServlet - Estado:");
            System.out.println("   - reservaExitosa: " + reservaExitosa);
            System.out.println("   - reservaAsignada: " + (reservaAsignada != null ? "Sí" : "No"));

            // Si hay confirmación, mostrarla (NO crear nueva reserva)
            if (reservaExitosa != null && reservaExitosa && reservaAsignada != null) {
                request.setAttribute("mostrarConfirmacion", true);
                request.setAttribute("reservaConfirmada", reservaAsignada);
                request.setAttribute("mensajeExito", mensajeConfirmacion);
                System.out.println("✅ Mostrando confirmación para estacionamiento: " + reservaAsignada.getNumeroEstacionamiento());
            } else if (reservaExitosa != null && !reservaExitosa) {
                request.setAttribute("mostrarError", true);
                request.setAttribute("mensajeError", mensajeError);
                System.out.println("❌ Mostrando error: " + mensajeError);
            }

            // Siempre cargar datos para nuevo formulario (SOLO datos, no reservas)
            LocalDate manana = LocalDate.now().plusDays(1);
            String fechaStr = manana.toString();

            // SOLO obtener puntos disponibles (no hacer reservas aquí)
            ReservasWS_Service service = new ReservasWS_Service();
            ReservasWS port = service.getReservasWSPort();
            int puntosDisponibles = port.obtenerSaldoPuntosUsuario(usuarioId);

            request.setAttribute("puntosDisponibles", puntosDisponibles);
            request.setAttribute("fechaReserva", manana);
            request.setAttribute("fechaReservaStr", fechaStr);
            
            System.out.println("📋 Datos cargados - Puntos: " + puntosDisponibles + ", Fecha: " + fechaStr);
            
            request.getRequestDispatcher("seleccionar_parqueo.jsp").forward(request, response);

        } catch (Exception ex) {
            System.out.println("❌ Error en ReservaVistaServlet: " + ex.getMessage());
            ex.printStackTrace();
            request.setAttribute("mensajeError", "Error al cargar los datos: " + ex.getMessage());
            request.getRequestDispatcher("seleccionar_parqueo.jsp").forward(request, response);
        }
    }
}

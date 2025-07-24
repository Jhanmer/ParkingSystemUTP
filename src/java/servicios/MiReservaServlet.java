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

            // Buscar la reserva más reciente (activa o para el futuro)
            Reserva reservaActual = null;
            if (historialReservas != null && !historialReservas.isEmpty()) {
                java.time.LocalDate hoy = java.time.LocalDate.now();
                java.time.LocalTime ahoraHora = java.time.LocalTime.now();
                
                System.out.println("🔍 Buscando reserva más reciente...");
                System.out.println("📅 Fecha actual: " + hoy);
                System.out.println("⏰ Hora actual: " + ahoraHora);
                
                // Buscar reservas activas (para hoy o futuras)
                for (Reserva reserva : historialReservas) {
                    System.out.println("🔎 Evaluando reserva ID: " + reserva.getId());
                    System.out.println("   Estado: " + reserva.getEstado());
                    System.out.println("   Fecha: " + reserva.getFecha());
                    System.out.println("   Hora inicio: " + reserva.getHoraInicio());
                    
                    if ("reservada".equals(reserva.getEstado()) && 
                        reserva.getFecha() != null && 
                        reserva.getHoraInicio() != null) {
                        
                        try {
                            java.time.LocalDate fechaReserva = java.time.LocalDate.parse(reserva.getFecha());
                            java.time.LocalTime horaInicioReserva = java.time.LocalTime.parse(reserva.getHoraInicio());
                            
                            // Solo considerar reservas de hoy (futuras) o futuras
                            boolean esReservaValida = false;
                            
                            if (fechaReserva.isAfter(hoy)) {
                                // Reserva para día futuro
                                esReservaValida = true;
                                System.out.println("   ✅ Reserva válida: día futuro");
                            } else if (fechaReserva.equals(hoy) && horaInicioReserva.isAfter(ahoraHora)) {
                                // Reserva para hoy pero hora futura
                                esReservaValida = true;
                                System.out.println("   ✅ Reserva válida: hoy, hora futura");
                            } else if (fechaReserva.equals(hoy)) {
                                // Reserva para hoy, verificar si está en curso
                                if (reserva.getHoraFin() != null) {
                                    java.time.LocalTime horaFinReserva = java.time.LocalTime.parse(reserva.getHoraFin());
                                    if (horaInicioReserva.isBefore(ahoraHora) && horaFinReserva.isAfter(ahoraHora)) {
                                        esReservaValida = true;
                                        System.out.println("   ✅ Reserva válida: en curso");
                                    }
                                }
                            }
                            
                            if (esReservaValida) {
                                if (reservaActual == null) {
                                    reservaActual = reserva;
                                    System.out.println("   🎯 Primera reserva válida seleccionada");
                                } else {
                                    // Comparar cuál es más próxima
                                    java.time.LocalDate fechaActual = java.time.LocalDate.parse(reservaActual.getFecha());
                                    java.time.LocalTime horaActual = java.time.LocalTime.parse(reservaActual.getHoraInicio());
                                    
                                    if (fechaReserva.isBefore(fechaActual) || 
                                        (fechaReserva.equals(fechaActual) && horaInicioReserva.isBefore(horaActual))) {
                                        reservaActual = reserva;
                                        System.out.println("   🔄 Reserva más próxima encontrada");
                                    }
                                }
                            } else {
                                System.out.println("   ❌ Reserva no válida: pasada");
                            }
                            
                        } catch (Exception e) {
                            System.out.println("   ❌ Error al parsear fecha/hora: " + e.getMessage());
                        }
                    } else {
                        System.out.println("   ❌ Reserva no activa o datos faltantes");
                    }
                }
                
                if (reservaActual != null) {
                    System.out.println("🎉 Reserva seleccionada ID: " + reservaActual.getId());
                    System.out.println("   Fecha: " + reservaActual.getFecha());
                    System.out.println("   Hora: " + reservaActual.getHoraInicio() + " - " + reservaActual.getHoraFin());
                    System.out.println("   Estacionamiento: " + reservaActual.getNumeroEstacionamiento());
                } else {
                    System.out.println("❌ No se encontró ninguna reserva válida");
                }
            }

            request.setAttribute("historialReservas", historialReservas);
            request.setAttribute("reservaActual", reservaActual);
            request.getRequestDispatcher("mireserva.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error al cargar las reservas: " + e.getMessage());
            request.getRequestDispatcher("mireserva.jsp").forward(request, response);
        }
    }
}



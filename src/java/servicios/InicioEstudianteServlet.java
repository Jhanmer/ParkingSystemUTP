package servicios;

import ws.EstudianteWS;
import ws.EstudianteWS_Service;
import ws.ClaseHorario;
import ws.Reserva;
import ws.ReservasWS;
import ws.ReservasWS_Service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet(name = "InicioEstudianteServlet", urlPatterns = {"/inicioEstudiante"})
public class InicioEstudianteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Integer usuarioId = (Integer) sesion.getAttribute("idUsuario");

        if (usuarioId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("🏠 InicioEstudianteServlet - ID DE USUARIO EN SESIÓN: " + usuarioId); 

        try {
            // Cliente del Web Service de Estudiante
            EstudianteWS_Service service = new EstudianteWS_Service();
            EstudianteWS port = service.getEstudianteWSPort();

            // Cliente del Web Service de Reservas
            ReservasWS_Service reservasService = new ReservasWS_Service();
            ReservasWS reservasPort = reservasService.getReservasWSPort();

            // Obtener puntos
            String puntos = port.obtenerPuntos(usuarioId);
            request.setAttribute("puntos", puntos);
            System.out.println("📊 Puntos obtenidos: " + puntos);

            // Obtener todas las reservas del usuario
            List<Reserva> todasLasReservas = reservasPort.listarHistorialReservasPorUsuario(usuarioId);
            
            // Buscar reservas para HOY
            LocalDate hoy = LocalDate.now();
            LocalTime ahoraHora = LocalTime.now();
            String fechaHoyStr = hoy.toString();
            
            Reserva reservaHoy = null;
            Reserva reservaProxima = null;
            
            System.out.println("🔍 Buscando reservas para hoy: " + fechaHoyStr);
            
            if (todasLasReservas != null && !todasLasReservas.isEmpty()) {
                for (Reserva reserva : todasLasReservas) {
                    System.out.println("🔎 Evaluando reserva:");
                    System.out.println("   ID: " + reserva.getId());
                    System.out.println("   Estado: " + reserva.getEstado());
                    System.out.println("   Fecha: " + reserva.getFecha());
                    System.out.println("   Hora: " + reserva.getHoraInicio() + " - " + reserva.getHoraFin());
                    System.out.println("   Estacionamiento: " + reserva.getNumeroEstacionamiento());
                    
                    if ("reservada".equals(reserva.getEstado()) && reserva.getFecha() != null) {
                        try {
                            LocalDate fechaReserva = LocalDate.parse(reserva.getFecha());
                            
                            if (fechaReserva.equals(hoy)) {
                                // Reserva para hoy
                                reservaHoy = reserva;
                                System.out.println("   ✅ Reserva para HOY encontrada");
                                
                                // Determinar estado actual de la reserva de hoy
                                if (reserva.getHoraInicio() != null && reserva.getHoraFin() != null) {
                                    LocalTime horaInicio = LocalTime.parse(reserva.getHoraInicio());
                                    LocalTime horaFin = LocalTime.parse(reserva.getHoraFin());
                                    
                                    if (ahoraHora.isBefore(horaInicio)) {
                                        request.setAttribute("estadoReservaHoy", "PENDIENTE");
                                        System.out.println("   🕐 Estado: PENDIENTE");
                                    } else if (ahoraHora.isAfter(horaInicio) && ahoraHora.isBefore(horaFin)) {
                                        request.setAttribute("estadoReservaHoy", "ACTIVA");
                                        System.out.println("   ✅ Estado: ACTIVA");
                                    } else {
                                        request.setAttribute("estadoReservaHoy", "FINALIZADA");
                                        System.out.println("   ⏰ Estado: FINALIZADA");
                                    }
                                }
                                
                            } else if (fechaReserva.isAfter(hoy) && reservaProxima == null) {
                                // Primera reserva futura encontrada
                                reservaProxima = reserva;
                                System.out.println("   📅 Próxima reserva encontrada para: " + fechaReserva);
                            }
                            
                        } catch (Exception e) {
                            System.out.println("   ❌ Error al parsear fecha: " + e.getMessage());
                        }
                    }
                }
            }

            // Establecer atributos para el JSP
            if (reservaHoy != null) {
                request.setAttribute("reservaHoy", reservaHoy);
                request.setAttribute("tieneReservaHoy", true);
                
                // Crear mensaje descriptivo
                String mensajeReserva = String.format("Estacionamiento %s - %s a %s", 
                    reservaHoy.getNumeroEstacionamiento(), 
                    reservaHoy.getHoraInicio(), 
                    reservaHoy.getHoraFin());
                request.setAttribute("mensajeReservaHoy", mensajeReserva);
                
                System.out.println("🅿️ Reserva hoy configurada: " + mensajeReserva);
            } else {
                request.setAttribute("tieneReservaHoy", false);
                System.out.println("❌ No hay reservas para hoy");
            }
            
            if (reservaProxima != null) {
                request.setAttribute("reservaProxima", reservaProxima);
                System.out.println("📅 Próxima reserva: " + reservaProxima.getFecha());
            }

            // Obtener horario
            List<ClaseHorario> horario = port.obtenerHorario(usuarioId);
            request.setAttribute("horarioCompleto", horario);
            System.out.println("📅 Horario cargado: " + (horario != null ? horario.size() + " clases" : "No disponible"));

        } catch (Exception e) {
            System.out.println("❌ Error en InicioEstudianteServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar datos del Web Service");
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
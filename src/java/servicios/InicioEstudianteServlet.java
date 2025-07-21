package servicios;

import util.Conexion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.*;
import java.util.*;

@WebServlet("/inicioEstudiante")
public class InicioEstudianteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        Integer usuarioId = (Integer) sesion.getAttribute("idUsuario"); // ✅ ID desde sesión

        if (usuarioId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = Conexion.getConnection()) {

            // Obtener puntos
            PreparedStatement psPuntos = conn.prepareStatement(
                "SELECT total_puntos FROM puntos_alumno WHERE usuario_id = ?"
            );
            psPuntos.setInt(1, usuarioId);
            ResultSet rsPuntos = psPuntos.executeQuery();
            if (rsPuntos.next()) {
                request.setAttribute("puntos", rsPuntos.getBigDecimal("total_puntos"));
            }

            // Obtener reserva activa para hoy
            PreparedStatement psReserva = conn.prepareStatement(
                "SELECT e.numero, r.hora_inicio, r.hora_fin " +
                "FROM reservas r " +
                "JOIN estacionamiento e ON r.codEsta = e.codEsta " +
                "WHERE r.usuario_id = ? AND r.fecha = CURDATE() AND r.estado = 'reservada' " +
                "ORDER BY r.hora_inicio LIMIT 1"
            );
            psReserva.setInt(1, usuarioId);
            ResultSet rsReserva = psReserva.executeQuery();
            if (rsReserva.next()) {
                Map<String, String> reserva = new HashMap<>();
                reserva.put("numero", rsReserva.getString("numero"));
                reserva.put("hora_inicio", rsReserva.getString("hora_inicio"));
                reserva.put("hora_fin", rsReserva.getString("hora_fin"));
                request.setAttribute("reservaHoy", reserva);
            }

            // Obtener horario de hoy
            String dia = obtenerDiaSemana();
            PreparedStatement psHorario = conn.prepareStatement(
                "SELECT hora_inicio, hora_fin, clase, aula FROM horarios WHERE usuario_id = ? AND dia_semana = ?"
            );
            psHorario.setInt(1, usuarioId);
            psHorario.setString(2, dia);
            ResultSet rsHorario = psHorario.executeQuery();
            List<Map<String, String>> horarioHoy = new ArrayList<>();
            while (rsHorario.next()) {
                Map<String, String> clase = new HashMap<>();
                clase.put("hora_inicio", rsHorario.getString("hora_inicio"));
                clase.put("hora_fin", rsHorario.getString("hora_fin"));
                clase.put("clase", rsHorario.getString("clase"));
                clase.put("aula", rsHorario.getString("aula"));
                horarioHoy.add(clase);
            }
            request.setAttribute("horarioHoy", horarioHoy);

        } catch (SQLException e) {
            throw new ServletException("Error al consultar datos del estudiante", e);
        }

        // Redirige al index.jsp con los datos cargados
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private String obtenerDiaSemana() {
        Locale locale = new Locale("es", "PE");
        DayOfWeek dia = LocalDate.now().getDayOfWeek();
        return dia.getDisplayName(java.time.format.TextStyle.FULL, locale);
    }
}
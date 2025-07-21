package servicios;

import autenticacion.Login;
import autenticacion.LoginResponse;
import autenticacion.Login_Service;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import util.Conexion;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("email-username");
        String contrasena = request.getParameter("password");
        String recordar = request.getParameter("remember"); // <- Recuérdame checkbox

        try {
            LoginResponse resultado = iniciarSesion(correo, contrasena);

            System.out.println("Resultado desde servicio:");
            System.out.println("Éxito: " + resultado.isSuccess());
            System.out.println("Mensaje: " + resultado.getMessage());
            System.out.println("Rol: " + resultado.getRol());
            System.out.println("id: " + resultado.getId());
            System.out.println("Nombre completo: " + resultado.getNombreCompleto());

            if (resultado.isSuccess()) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", resultado.getNombreCompleto());
                session.setAttribute("rol", resultado.getRol());
                session.setAttribute("correo", correo);
                session.setAttribute("idUsuario", resultado.getId());

                // 🔁 Consultar ruta_foto desde la base de datos MySQL
                String idUsuario = String.valueOf(resultado.getId());

                try (Connection conn = Conexion.getConnection()) {
                    PreparedStatement ps = conn.prepareStatement("SELECT ruta_foto FROM usuarios WHERE id = ?");
                    ps.setString(1, idUsuario);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        String rutaFoto = rs.getString("ruta_foto");
                        session.setAttribute("rutaFoto", (rutaFoto != null && !rutaFoto.isEmpty())
                            ? rutaFoto
                            : "assets/img/avatars/1.png");
                    } else {
                        session.setAttribute("rutaFoto", "assets/img/avatars/1.png");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("rutaFoto", "assets/img/avatars/1.png");
                }

                // ✅ Recuérdame (guardar/eliminar cookie)
                if ("on".equals(recordar)) {
                    Cookie cookie = new Cookie("correoRecordado", correo);
                    cookie.setPath("/"); // ✅ Asegura que sea accesible desde toda la app
                    cookie.setMaxAge(60 * 60 * 24 * 7); // 7 días
                    response.addCookie(cookie);
                } else {
                    Cookie cookie = new Cookie("correoRecordado", "");
                    cookie.setPath("/"); // ✅ Muy importante para que se pueda eliminar correctamente
                    cookie.setMaxAge(0); // Eliminar cookie
                    response.addCookie(cookie);
                }

                response.sendRedirect("index.jsp");

            } else {
                request.setAttribute("error", resultado.getMessage());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error inesperado de autenticación.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Método para invocar al servicio web de autenticación
    private LoginResponse iniciarSesion(String correo, String contrasena) {
        Login_Service service = new Login_Service();
        Login port = service.getLoginPort();
        return port.iniciarSesion(correo, contrasena);
    }

    @Override
    public String getServletInfo() {
        return "Controlador de inicio de sesión";
    }
}
  package servicios;

import autenticacion.Login;
import autenticacion.LoginResponse;
import autenticacion.Login_Service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("email-username");
        String contrasena = request.getParameter("password");

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

                // Redireccionar según el rol, o a index.jsp
                response.sendRedirect("index.jsp");
            } else {
                // Error de credenciales
                request.setAttribute("error", resultado.getMessage());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error inesperado de autenticación.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private LoginResponse iniciarSesion(String correo, String contrasena) {
        Login_Service service = new Login_Service(); // Se instancia manualmente
        Login port = service.getLoginPort();         // Se obtiene el puerto
        return port.iniciarSesion(correo, contrasena);
    }

    @Override
    public String getServletInfo() {
        return "Controlador de inicio de sesión";
    }
}
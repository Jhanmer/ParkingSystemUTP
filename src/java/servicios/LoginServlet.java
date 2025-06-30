
package servicios;

import autenticacion.LoginResponse;
import autenticacion.Login_Service;
import autenticacion.Login;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.WebServiceRef;



@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @WebServiceRef(wsdlLocation = "http://localhost:8080/Servicio-Autenticacion/login?WSDL")
    private Login_Service service;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("email-username");
        String contrasena = request.getParameter("password");

        try {
            LoginResponse resultado = iniciarSesion(correo, contrasena);

            if (resultado.isSuccess()) {
                // Guardar datos en sesión si deseas
                request.getSession().setAttribute("usuario", resultado.getNombreCompleto());
                request.getSession().setAttribute("rol", resultado.getRol());
                request.getSession().setAttribute("correo", correo);


                // Redirigir según el rol
                response.sendRedirect("index.jsp");
            } else {
                // Enviar mensaje de error al login
                request.setAttribute("error", resultado.getMessage());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al conectar con el servicio.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private LoginResponse iniciarSesion(java.lang.String correo, java.lang.String contrasena) {
        autenticacion.Login port = service.getLoginPort();
        return port.iniciarSesion(correo, contrasena);
    }

}

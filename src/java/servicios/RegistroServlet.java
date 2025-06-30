package controlador;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");

        if (!correo.endsWith("@utp.edu.pe")) {
            request.setAttribute("error", "Correo inválido.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/parkingsystem", "root", "");
            String query = "INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, nombre);
            ps.setString(2, apellido);
            ps.setString(3, correo);
            ps.setString(4, contrasena);
            ps.setString(5, rol);

            int rows = ps.executeUpdate();
            con.close();

            if (rows > 0) {
                response.sendRedirect("index.jsp?registro=ok");
            } else {
                request.setAttribute("error", "No se pudo registrar.");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }
}
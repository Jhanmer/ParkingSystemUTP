package controlador;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;
import util.Conexion;


@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    private static final String TOKEN = "719284fc77b0e8b1e3ca5a9aa8bc68ba67eed8e30167e779515b4094134c12d5";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String dni = request.getParameter("dni");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");

        // Validar dominio de correo
        if (!correo.endsWith("@utp.edu.pe")) {
            request.setAttribute("error", "Correo debe terminar en @utp.edu.pe");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        try {
            // Llamar API DNI
            JSONObject jsonRequest = new JSONObject();
            jsonRequest.put("dni", dni);

            URL url = new URL("https://apiperu.dev/api/dni");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Accept", "application/json");
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("Authorization", "Bearer " + TOKEN);
            con.setDoOutput(true);

            OutputStream os = con.getOutputStream();
            os.write(jsonRequest.toString().getBytes());
            os.flush();
            os.close();

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = in.readLine()) != null) {
                sb.append(line);
            }
            in.close();

            JSONObject responseJson = new JSONObject(sb.toString()).getJSONObject("data");
            String nombres = responseJson.getString("nombres");
            String apellidoPaterno = responseJson.getString("apellido_paterno");
            String apellidoMaterno = responseJson.getString("apellido_materno");

            // Registrar en base de datos
            Connection conn = Conexion.getConnection();
            String sql = "INSERT INTO usuarios (nombre, apellido, correo, contrasena, rol) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nombres);
            ps.setString(2, apellidoPaterno + " " + apellidoMaterno);
            ps.setString(3, correo);
            ps.setString(4, contrasena);
            ps.setString(5, rol);

            ps.executeUpdate();
            ps.close();
            conn.close();

            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al registrar: " + e.getMessage());
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }
}

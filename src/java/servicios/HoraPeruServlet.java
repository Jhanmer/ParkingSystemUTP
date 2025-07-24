package servicios;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

@WebServlet(name = "HoraPeruServlet", urlPatterns = {"/horaPeru"})
public class HoraPeruServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String formato = request.getParameter("formato"); // "json" o null
        
        if ("json".equals(formato)) {
            response.setContentType("application/json;charset=UTF-8");
        } else {
            response.setContentType("text/plain;charset=UTF-8");
        }

        try (PrintWriter out = response.getWriter()) {
            String apiUrl = "http://worldtimeapi.org/api/timezone/America/Lima";
            HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
            conn.setRequestMethod("GET");

            Scanner scanner = new Scanner(conn.getInputStream());
            StringBuilder jsonStr = new StringBuilder();
            while (scanner.hasNext()) {
                jsonStr.append(scanner.nextLine());
            }
            scanner.close();

            JSONObject json = new JSONObject(jsonStr.toString());
            String datetime = json.getString("datetime");

            String horaCompleta = datetime.split("T")[1];
            String[] partesHora = horaCompleta.split(":");
            String segundosParte = partesHora[2].split("\\.")[0];
            String horaFormateada = partesHora[0] + ":" + partesHora[1] + ":" + segundosParte;
            
            // Extraer fecha
            String fecha = datetime.split("T")[0];

            if ("json".equals(formato)) {
                // Devolver JSON con más información
                JSONObject respuesta = new JSONObject();
                respuesta.put("fecha", fecha);
                respuesta.put("hora", horaFormateada);
                respuesta.put("datetime", datetime);
                respuesta.put("timestamp", System.currentTimeMillis());
                out.print(respuesta.toString());
            } else {
                // Formato original (solo hora)
                out.print(horaFormateada);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            if ("json".equals(formato)) {
                  response.getWriter().println("{\"error\":\"" + e.getMessage() + "\"}");
            } else {
                 response.getWriter().println("ERROR: " + e.getMessage());
            }
        }
    }

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
}
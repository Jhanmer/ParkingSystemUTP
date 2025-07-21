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

        response.setContentType("text/plain;charset=UTF-8");

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
            String datetime = json.getString("datetime"); // Ej: 2025-07-21T23:32:55.112233-05:00

            // Extraer solo la hora (HH:mm)
            String horaCompleta = datetime.split("T")[1];     // "23:32:55.112233-05:00"
            String[] partesHora = horaCompleta.split(":");    // ["23", "32", "55.112233-05:00"]
            String horaFormateada = partesHora[0] + ":" + partesHora[1]; // "23:32"

            out.print(horaFormateada);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("ERROR: " + e.getMessage());
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
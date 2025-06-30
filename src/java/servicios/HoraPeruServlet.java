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
        PrintWriter out = response.getWriter();

        try {
            // Usamos worldtimeapi.org sin token
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
            long timestamp = json.getLong("unixtime"); // tiempo en segundos

            out.print(timestamp);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("ERROR: " + e.getMessage());
        } finally {
            out.close();
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
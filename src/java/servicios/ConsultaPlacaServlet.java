
package servicios;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;


@WebServlet("/consultaPlaca")
public class ConsultaPlacaServlet extends HttpServlet {
    //*eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODc5NiIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6ImNvbnN1bHRvciJ9.0cJ9LR-93XFWdzPeRDCzUUmaSUIukHnrBYU7zGqRoKE
    private static final String TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODc5NiIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6ImNvbnN1bHRvciJ9.0cJ9LR-93XFWdzPeRDCzUUmaSUIukHnrBYU7zGqRoKE"; // Cambia por tu token

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String placa = request.getParameter("placa").toUpperCase().trim();

        if (placa.isEmpty()) {
            request.setAttribute("error", "Debe ingresar un número de placa válido.");
            request.getRequestDispatcher("vehiculo.jsp").forward(request, response);
            return;
        }

        String urlStr = "https://api.factiliza.com/v1/placa/info/" + placa;

        HttpURLConnection con = null;

        try {
            URL url = new URL(urlStr);
            con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", "Bearer " + TOKEN);
            con.setConnectTimeout(5000);
            con.setReadTimeout(5000);

            int status = con.getResponseCode();

            if (status == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
                StringBuilder content = new StringBuilder();
                String line;
                while ((line = in.readLine()) != null) {
                    content.append(line);
                }
                in.close();

                JSONObject obj = new JSONObject(content.toString());

                int statusAPI = obj.optInt("status", 0);
                if (statusAPI == 200) {
                    JSONObject data = obj.getJSONObject("data");
                    request.setAttribute("data", data);
                } else {
                    request.setAttribute("error", "No se encontró información para la placa.");
                }

            } else {
                request.setAttribute("error", "Error en la consulta: código " + status);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en la conexión: " + e.getMessage());
        } finally {
            if (con != null) {
                con.disconnect();
            }
        }
        request.getRequestDispatcher("vehiculo.jsp").forward(request, response);
    }

}

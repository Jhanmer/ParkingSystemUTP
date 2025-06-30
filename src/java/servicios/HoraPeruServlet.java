
package servicios;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


@WebServlet(name = "HoraPeruServlet", urlPatterns = {"/horaPeru"})
public class HoraPeruServlet extends HttpServlet {

    private static final String API_KEY = "X6FCXNGHTTSU"; // Tu clave API
    private static final String API_URL = "http://api.timezonedb.com/v2.1/list-time-zone";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8"); // Devolvemos texto plano
        PrintWriter out = response.getWriter();

        try {
            String fullUrl = API_URL + "?key=" + API_KEY + "&format=xml&country=PT";
            
            URL url = new URL(fullUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                Document doc = dBuilder.parse(connection.getInputStream());
                doc.getDocumentElement().normalize();

                NodeList statusNode = doc.getElementsByTagName("status");
                String status = statusNode.item(0).getTextContent();

                if ("OK".equals(status)) {
                    NodeList zoneList = doc.getElementsByTagName("zone");
                    long timestamp = 0;
                    if (zoneList.getLength() > 0) {
                        for (int i = 0; i < zoneList.getLength(); i++) {
                            Element zoneElement = (Element) zoneList.item(i);
                            String zoneName = zoneElement.getElementsByTagName("zoneName").item(0).getTextContent();
                            if ("America/Lima".equals(zoneName)) {
                                timestamp = Long.parseLong(zoneElement.getElementsByTagName("timestamp").item(0).getTextContent());
                                break;
                            }
                        }
                        if (timestamp == 0) { 
                            Element firstZone = (Element) zoneList.item(0);
                            timestamp = Long.parseLong(firstZone.getElementsByTagName("timestamp").item(0).getTextContent());
                        }

                        // **** CAMBIO AQUÍ: Solo enviamos el timestamp como texto ****
                        out.print(String.valueOf(timestamp)); 
                    } else {
                        // Si no hay zonas, enviamos un error 500 para que JavaScript lo detecte
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        out.print("ERROR: No se encontraron zonas horarias para Perú en la respuesta de la API.");
                    }
                } else {
                    // Si la API reporta un error, enviamos un error 500 y el mensaje de la API
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    NodeList messageNode = doc.getElementsByTagName("message");
                    String message = (messageNode.getLength() > 0) ? messageNode.item(0).getTextContent() : "Error desconocido de la API.";
                    out.print("ERROR: " + message);
                }

            } else {
                // Si la conexión HTTP falla, enviamos el código de error para que JavaScript lo maneje
                response.setStatus(responseCode); // Enviar el código de respuesta original de la conexión
                out.print("ERROR: Fallo de conexión con la API de TimeZoneDB. Código: " + responseCode);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("ERROR: Error interno del servidor al procesar la solicitud: " + e.getMessage());
            e.printStackTrace();
        } finally {
            out.close();
        }   
    }
}

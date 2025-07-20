package servicios;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ws.Estacionamiento;
import ws.EstacionamientoWS;
import ws.EstacionamientoWS_Service;

@WebServlet(name = "EstacionamientoServlet", urlPatterns = {"/EstacionamientoServlet"})
public class EstacionamientoServlet extends HttpServlet {

    private EstacionamientoWS_Service servicio;

    @Override
    public void init() throws ServletException {
        servicio = new EstacionamientoWS_Service();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Obtener lista de estacionamientos desde el web service
            EstacionamientoWS port = servicio.getEstacionamientoWSPort();
            List<Estacionamiento> listaEstacionamientos = port.listarEstacionamientos();
            
            // Pasar la lista al JSP
            request.setAttribute("listaEstacionamientos", listaEstacionamientos);
            
            // Redirigir a la vista
            RequestDispatcher dispatcher = request.getRequestDispatcher("Parqueo.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("liberarMultiples".equals(accion)) {
            liberarMultiplesEstacionamientos(request, response);
        } else if ("eliminar".equals(accion)) {
            eliminarEstacionamiento(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void liberarMultiplesEstacionamientos(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String[] ids = request.getParameterValues("ids");
            
            if (ids != null && ids.length > 0) {
                EstacionamientoWS port = servicio.getEstacionamientoWSPort();
                
                for (String idStr : ids) {
                    int codEsta = Integer.parseInt(idStr);
                    // Cambiar estado a "disponible"
                    Estacionamiento estacionamiento = port.buscarEstacionamientoPorId(codEsta);
                    if (estacionamiento != null) {
                        estacionamiento.setEstado("disponible");
                        port.actualizarEstacionamiento(estacionamiento);
                    }
                }
                
                System.out.println("Se liberaron " + ids.length + " estacionamientos.");
            }
            
            // Redirigir de vuelta a la vista
            response.sendRedirect(request.getContextPath() + "/EstacionamientoServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al liberar estacionamientos: " + e.getMessage());
        }
    }

    private void eliminarEstacionamiento(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            EstacionamientoWS port = servicio.getEstacionamientoWSPort();
            
            // Cambiar estado a "disponible" en lugar de eliminar
            Estacionamiento estacionamiento = port.buscarEstacionamientoPorId(id);
            if (estacionamiento != null) {
                estacionamiento.setEstado("disponible");
                boolean actualizado = port.actualizarEstacionamiento(estacionamiento);
                
                if (actualizado) {
                    System.out.println("Estacionamiento " + estacionamiento.getNumero() + " liberado correctamente.");
                } else {
                    System.out.println("Error al liberar el estacionamiento.");
                }
            }
            
            // Redirigir de vuelta a la vista
            response.sendRedirect(request.getContextPath() + "/EstacionamientoServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al liberar estacionamiento: " + e.getMessage());
        }
    }
}

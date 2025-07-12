package servicios;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.xml.ws.WebServiceRef;
import servicio.ServicioListarUsuarios_Service;
import servicio.ServicioListarUsuarios;
import servicio.Usuario;

@WebServlet("/listar")
public class ListarUsuariosServlet extends HttpServlet {

    @WebServiceRef(wsdlLocation = "http://localhost:8080/ServicioListarUsuario/ServicioListarUsuarios?wsdl")
    private ServicioListarUsuarios_Service servicio;

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
    try {
        servicio.ServicioListarUsuarios_Service servicio = new servicio.ServicioListarUsuarios_Service();
        servicio.ServicioListarUsuarios port = servicio.getServicioListarUsuariosPort();

        List<servicio.Usuario> usuarios = port.listarUsuarios();
        
        System.out.println("Cantidad de usuarios recibidos: " + usuarios.size());
        
        request.setAttribute("listaUsuarios", usuarios);
        request.getRequestDispatcher("ListarUsuarios.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Error al consumir el Web Service: " + e.getMessage());
    }
}


    private java.util.List<servicio.Usuario> listarUsuarios() {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        servicio.ServicioListarUsuarios port = servicio.getServicioListarUsuariosPort();
        return port.listarUsuarios();
    }

  
}

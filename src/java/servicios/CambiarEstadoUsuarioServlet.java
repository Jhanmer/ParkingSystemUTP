/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servicios;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import ws.ServicioUsuarioService;
import ws.ServicioUsuario;

@WebServlet("/cambiarEstadoUsuario")
public class CambiarEstadoUsuarioServlet extends HttpServlet {

    private ServicioUsuarioService servicio;

    @Override
    public void init() throws ServletException {
        servicio = new ServicioUsuarioService();  // nombre sin guión bajo
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String nuevoEstado = request.getParameter("nuevoEstado");

            ServicioUsuario port = servicio.getServicioUsuarioPort();
            String resultado = port.cambiarEstadoUsuario(idUsuario, nuevoEstado);

            System.out.println("➡️ Resultado del WS: " + resultado);

            response.sendRedirect(request.getContextPath() + "/listar");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error al cambiar estado: " + e.getMessage());
        }
    }
}



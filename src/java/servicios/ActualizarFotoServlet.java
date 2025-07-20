/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servicios;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.Connection;
import java.sql.PreparedStatement;
import util.Conexion; 

@WebServlet("/ActualizarFotoServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,
                 maxFileSize = 1024 * 1024 * 5,
                 maxRequestSize = 1024 * 1024 * 10)
public class ActualizarFotoServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "assets/img/avatars";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idUsuario = request.getParameter("idUsuario");
        Part filePart = request.getPart("fotoPerfil");
        String fileName = "usuario_" + idUsuario + ".png";

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        File file = new File(uploadPath + File.separator + fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
        }
        // Ruta relativa para mostrarla en el HTML
        String rutaRelativa = UPLOAD_DIR + "/" + fileName;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = Conexion.getConnection(); // Tu clase util.Conexion
            ps = conn.prepareStatement("UPDATE usuarios SET ruta_foto = ? WHERE id = ?");
            ps.setString(1, rutaRelativa);
            ps.setString(2, idUsuario);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
        // Guardar la ruta de la imagen en la sesión
        request.getSession().setAttribute("rutaFoto", rutaRelativa);
        response.sendRedirect("index.jsp");
    }
}


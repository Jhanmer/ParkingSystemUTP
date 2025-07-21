package servicios;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.*;
import java.nio.file.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import util.Conexion;

@WebServlet("/ActualizarFotoServlet")
@MultipartConfig
public class ActualizarFotoServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/img/avatars";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String idUsuario = request.getParameter("idUsuario");
        Part filePart = request.getPart("fotoPerfil");

        if (idUsuario == null || filePart == null || filePart.getSize() == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Archivo inválido");
            return;
        }

        String fileName = "usuario_" + idUsuario + ".png";
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        File destino = new File(dir, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, destino.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        String rutaRelativa = UPLOAD_DIR + "/" + fileName;

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE usuarios SET ruta_foto = ? WHERE id = ?")) {
            ps.setString(1, rutaRelativa);
            ps.setString(2, idUsuario);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ActualizarFotoServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getSession().setAttribute("rutaFoto", rutaRelativa);
        response.setContentType("text/plain");
        response.getWriter().print(rutaRelativa + "?t=" + System.currentTimeMillis()); // rompe caché
    }
}
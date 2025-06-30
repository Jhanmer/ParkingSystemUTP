
package servicios;

import dao.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;


@WebService(serviceName = "RegistroService")
public class RegistroService {

  
    @WebMethod
    public String registrarUsuario(String nombres, String dni, String telefono, String correo, String placa, int tipoVehiculo) {
        if (!correo.matches("^U\\d{8}@utp\\.edu\\.pe$")) {
            return "Correo inválido. Debe ser institucional.";
        }

        try (Connection conn = Conexion.conectar()) {
            String sql = "INSERT INTO usuarios_parqueo (nombres, dni, telefono, correo, placa_vehiculo, tipo_vehiculo) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nombres);
            ps.setString(2, dni);
            ps.setString(3, telefono);
            ps.setString(4, correo);
            ps.setString(5, placa);
            ps.setInt(6, tipoVehiculo);
            ps.executeUpdate();
            return "Gracias por tu registro.";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
}

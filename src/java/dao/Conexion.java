
package dao;
import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
     public static Connection conectar() {
        Connection conn = null;
        try {
            // Usa el driver de Apache Derby
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Conexión a la base de datos (reemplaza el nombre y las credenciales si es necesario)
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ParqueoUTP", "app", "app");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
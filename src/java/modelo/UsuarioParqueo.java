
package modelo;

public class UsuarioParqueo {
    
    private String nombres;
    private String dni;
    private String telefono;
    private String correo;
    private String placaVehiculo;
    private int tipoVehiculo;

    public UsuarioParqueo(String nombres, String dni, String telefono, String correo, String placaVehiculo, int tipoVehiculo) {
        this.nombres = nombres;
        this.dni = dni;
        this.telefono = telefono;
        this.correo = correo;
        this.placaVehiculo = placaVehiculo;
        this.tipoVehiculo = tipoVehiculo;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPlacaVehiculo() {
        return placaVehiculo;
    }

    public void setPlacaVehiculo(String placaVehiculo) {
        this.placaVehiculo = placaVehiculo;
    }

    public int getTipoVehiculo() {
        return tipoVehiculo;
    }

    public void setTipoVehiculo(int tipoVehiculo) {
        this.tipoVehiculo = tipoVehiculo;
    }
    
    
    
}

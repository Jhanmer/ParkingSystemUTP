
package modelo;


public class Hora {
    private String hora;
    private String zonaHoraria;

    public Hora(String hora, String zonaHoraria) {
        this.hora = hora;
        this.zonaHoraria = zonaHoraria;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getZonaHoraria() {
        return zonaHoraria;
    }

    public void setZonaHoraria(String zonaHoraria) {
        this.zonaHoraria = zonaHoraria;
    }
    
    
    
}

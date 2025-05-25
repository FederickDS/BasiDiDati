package org.example.model.domain;

public class Telefono {
    private String telefono;
    private String utilizzatore;

    // Costruttori, getter e setter
    public Telefono() {}

    public Telefono(String telefono, String utilizzatore) {
        this.telefono = telefono;
        this.utilizzatore = utilizzatore;
    }

    // Getter e Setter
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getUtilizzatore() { return utilizzatore; }
    public void setUtilizzatore(String utilizzatore) { this.utilizzatore = utilizzatore; }
}
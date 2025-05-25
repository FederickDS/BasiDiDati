package org.example.model.domain;

public class Cellulare {
    private String cellulare;
    private String utilizzatore;

    // Costruttori, getter e setter
    public Cellulare() {}

    public Cellulare(String cellulare, String utilizzatore) {
        this.cellulare = cellulare;
        this.utilizzatore = utilizzatore;
    }

    // Getter e Setter
    public String getCellulare() { return cellulare; }
    public void setCellulare(String cellulare) { this.cellulare = cellulare; }

    public String getUtilizzatore() { return utilizzatore; }
    public void setUtilizzatore(String utilizzatore) { this.utilizzatore = utilizzatore; }
}
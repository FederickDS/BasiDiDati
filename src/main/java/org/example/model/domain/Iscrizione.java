package org.example.model.domain;

public class Iscrizione {
    private Integer corso;
    private String utente;

    // Costruttori, getter e setter
    public Iscrizione() {}

    public Iscrizione(Integer corso, String utente) {
        this.corso = corso;
        this.utente = utente;
    }

    // Getter e Setter
    public Integer getCorso() { return corso; }
    public void setCorso(Integer corso) { this.corso = corso; }

    public String getUtente() { return utente; }
    public void setUtente(String utente) { this.utente = utente; }
}
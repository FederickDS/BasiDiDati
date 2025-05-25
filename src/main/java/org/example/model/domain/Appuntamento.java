package org.example.model.domain;

import java.sql.Timestamp;

public class Appuntamento {
    private Integer corso;
    private Timestamp inizio;
    private Timestamp fine;
    private String vasca;

    // Costruttori, getter e setter
    public Appuntamento() {}

    public Appuntamento(Integer corso, Timestamp inizio, Timestamp fine, String vasca) {
        this.corso = corso;
        this.inizio = inizio;
        this.fine = fine;
        this.vasca = vasca;
    }

    // Getter e Setter
    public Integer getCorso() { return corso; }
    public void setCorso(Integer corso) { this.corso = corso; }

    public Timestamp getInizio() { return inizio; }
    public void setInizio(Timestamp inizio) { this.inizio = inizio; }

    public Timestamp getFine() { return fine; }
    public void setFine(Timestamp fine) { this.fine = fine; }

    public String getVasca() { return vasca; }
    public void setVasca(String vasca) { this.vasca = vasca; }
}
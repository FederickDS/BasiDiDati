package org.example.model.domain;

import java.sql.Timestamp;

public class BadgeStorico {
    private String utente;
    private Integer badge;
    private Timestamp inizio;
    private Timestamp fine;

    // Costruttori, getter e setter
    public BadgeStorico() {}

    public BadgeStorico(String utente, Integer badge, Timestamp inizio, Timestamp fine) {
        this.utente = utente;
        this.badge = badge;
        this.inizio = inizio;
        this.fine = fine;
    }

    // Getter e Setter
    public String getUtente() { return utente; }
    public void setUtente(String utente) { this.utente = utente; }

    public Integer getBadge() { return badge; }
    public void setBadge(Integer badge) { this.badge = badge; }

    public Timestamp getInizio() { return inizio; }
    public void setInizio(Timestamp inizio) { this.inizio = inizio; }

    public Timestamp getFine() { return fine; }
    public void setFine(Timestamp fine) { this.fine = fine; }
}
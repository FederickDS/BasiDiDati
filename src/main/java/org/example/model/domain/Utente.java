package org.example.model.domain;

import java.sql.Timestamp;

public class Utente {
    private String CF;
    private Badge badge;
    private Timestamp inizioBadge;

    // Costruttori, getter e setter
    public Utente() {}

    public Utente(String CF, Badge badge, Timestamp inizioBadge) {
        this.CF = CF;
        this.badge = badge;
        this.inizioBadge = inizioBadge;
    }

    // Getter e Setter
    public String getCF() { return CF; }
    public void setCF(String CF) { this.CF = CF; }

    public Badge getBadge() { return badge; }
    public void setBadge(Badge badge) { this.badge = badge; }

    public Timestamp getInizioBadge() { return inizioBadge; }
    public void setInizioBadge(Timestamp inizioBadge) { this.inizioBadge = inizioBadge; }
}
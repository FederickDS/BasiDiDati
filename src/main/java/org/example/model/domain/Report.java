package org.example.model.domain;

import java.sql.Timestamp;

public class Report {
    private Timestamp inizio;
    private Timestamp fine;
    private int utentiPrevisti;
    private int utentiEffettivi;

    public Timestamp getInizio() {
        return inizio;
    }
    public void setInizio(Timestamp inizio) {
        this.inizio = inizio;
    }
    public Timestamp getFine() {
        return fine;
    }
    public void setFine(Timestamp fine) {
        this.fine = fine;
    }
    public int getUtentiPrevisti() {
        return utentiPrevisti;
    }
    public void setUtentiPrevisti(int utentiPrevisti) {
        this.utentiPrevisti = utentiPrevisti;
    }
    public int getUtentiEffettivi() {
        return utentiEffettivi;
    }
    public void setUtentiEffettivi(int utentiEffettivi) {
        this.utentiEffettivi = utentiEffettivi;
    }
}

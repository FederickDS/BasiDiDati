package org.example.model.domain;

import java.sql.Timestamp;

public class Accesso {
    private Timestamp istante;
    private Integer badge;

    // Costruttori, getter e setter
    public Accesso() {}

    public Accesso(Timestamp istante, Integer badge) {
        this.istante = istante;
        this.badge = badge;
    }

    // Getter e Setter
    public Timestamp getIstante() { return istante; }
    public void setIstante(Timestamp istante) { this.istante = istante; }

    public Integer getBadge() { return badge; }
    public void setBadge(Integer badge) { this.badge = badge; }
}
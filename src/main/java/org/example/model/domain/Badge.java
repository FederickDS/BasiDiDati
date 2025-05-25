package org.example.model.domain;

public class Badge {
    private Integer badgeID;
    private String stato;

    // Costruttori, getter e setter
    public Badge() {}

    public Badge(Integer badgeID, String stato) {
        this.badgeID = badgeID;
        this.stato = stato;
    }

    // Getter e Setter
    public Integer getBadgeID() { return badgeID; }
    public void setBadgeID(Integer badgeID) { this.badgeID = badgeID; }

    public String getStato() { return stato; }
    public void setStato(String stato) { this.stato = stato; }
}
package org.example.model.domain;

public class Email {
    private String email;
    private String utilizzatore;

    // Costruttori, getter e setter
    public Email() {}

    public Email(String email, String utilizzatore) {
        this.email = email;
        this.utilizzatore = utilizzatore;
    }

    // Getter e Setter
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUtilizzatore() { return utilizzatore; }
    public void setUtilizzatore(String utilizzatore) { this.utilizzatore = utilizzatore; }
}
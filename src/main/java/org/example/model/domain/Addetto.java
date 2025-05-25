package org.example.model.domain;

public class Addetto {
    private String CF;
    private String username;
    private String password;

    // Costruttori, getter e setter
    public Addetto() {}

    public Addetto(String CF, String username, String password) {
        this.CF = CF;
        this.username = username;
        this.password = password;
    }

    // Getter e Setter
    public String getCF() { return CF; }
    public void setCF(String CF) { this.CF = CF; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
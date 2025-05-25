package org.example.model.domain;

import java.util.ArrayList;

public class Utilizzatore {
    private String CF;
    private String indirizzo;
    private String nome;
    private Utente utente;
    private Addetto addetto;
    private ArrayList<Telefono> telefoni;
    private ArrayList<Email> emails;
    private ArrayList<Cellulare> cellulari;

    // Costruttori, getter e setter
    public Utilizzatore() {}

    public Utilizzatore(String CF, String indirizzo, String nome) {
        this.CF = CF;
        this.indirizzo = indirizzo;
        this.nome = nome;
    }

    // Getter e Setter
    public String getCF() { return CF; }
    public void setCF(String CF) { this.CF = CF; }

    public String getIndirizzo() { return indirizzo; }
    public void setIndirizzo(String indirizzo) { this.indirizzo = indirizzo; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public Utente getUtente() { return utente; }
    public void setUtente(Utente utente) { this.utente = utente; }

    public Addetto getAddetto() { return addetto; }
    public void setAddetto(Addetto addetto) { this.addetto = addetto; }

    public ArrayList<Telefono> getTelefoni() { return telefoni; }
    public void setTelefoni(ArrayList<Telefono> telefoni) {
        this.telefoni = telefoni;
    }
    public void addTelefono(Telefono telefono) {
        if(this.telefoni==null) {
            this.telefoni = new ArrayList<>();
        }
        this.telefoni.add(telefono);
    }
    public ArrayList<Email> getEmails() { return emails; }
    public void setEmails(ArrayList<Email> emails) {
        this.emails = emails;
    }
    public void addEmail(Email email) {
        if(this.emails==null) {
            this.emails = new ArrayList<>();
        }
        this.emails.add(email);
    }

    public ArrayList<Cellulare> getCellulari() { return cellulari; }
    public void setCellulari(ArrayList<Cellulare> cellulari) {
        this.cellulari = cellulari;
    }
    public void addCellulare(Cellulare cellulare) {
        if(this.cellulari==null) {
            this.cellulari = new ArrayList<>();
        }
        this.cellulari.add(cellulare);
    }
}
package org.example.model.domain;

import java.sql.Timestamp;

public class Corso {
    private Integer corsoID;
    private Integer minimo;
    private char stato;
    private String nome;
    private Integer costo;
    private Integer numIscritti;
    private Timestamp dataInizio;
    private Timestamp dataFine;
    private Integer capienza;

    // Costruttori, getter e setter
    public Corso() {}

    public Corso(Integer corsoID, Integer minimo, char stato, String nome, Integer costo,
                 Integer numIscritti, Timestamp dataInizio, Timestamp dataFine, Integer capienza) {
        this.corsoID = corsoID;
        this.minimo = minimo;
        this.stato = stato;
        this.nome = nome;
        this.costo = costo;
        this.numIscritti = numIscritti;
        this.dataInizio = dataInizio;
        this.dataFine = dataFine;
        this.capienza = capienza;
    }

    // Getter e Setter
    public Integer getCorsoID() { return corsoID; }
    public void setCorsoID(Integer corsoID) { this.corsoID = corsoID; }

    public Integer getMinimo() { return minimo; }
    public void setMinimo(Integer minimo) { this.minimo = minimo; }

    public char getStato() { return stato; }
    public void setStato(char stato) { this.stato = stato; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public Integer getCosto() { return costo; }
    public void setCosto(Integer costo) { this.costo = costo; }

    public Integer getNumIscritti() { return numIscritti; }
    public void setNumIscritti(Integer numIscritti) { this.numIscritti = numIscritti; }

    public Timestamp getDataInizio() { return dataInizio; }
    public void setDataInizio(Timestamp dataInizio) { this.dataInizio = dataInizio; }

    public Timestamp getDataFine() { return dataFine; }
    public void setDataFine(Timestamp dataFine) { this.dataFine = dataFine; }

    public Integer getCapienza() { return capienza; }
    public void setCapienza(Integer capienza) { this.capienza = capienza; }

    @Override
    public String toString() {
        return this.corsoID + " – " + this.nome;
    }

}
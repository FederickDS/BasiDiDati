package org.example.model.domain;

public class Vasca {
    private String nome;

    // Costruttori, getter e setter
    public Vasca() {}

    public Vasca(String nome) {
        this.nome = nome;
    }

    // Getter e Setter
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
}
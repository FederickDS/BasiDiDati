package org.example.model.domain;

public class IscrittoCorso {
    private String cf;
    private String nome;

    public IscrittoCorso(String cf, String nome) {
        this.cf = cf;
        this.nome = nome;
    }

    public String getCf() {
        return cf;
    }

    public void setCf(String cf) {
        this.cf = cf;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    @Override
    public String toString() {
        return this.cf + " – " + this.nome;
    }
}

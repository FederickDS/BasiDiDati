package org.example.model.domain;

import java.util.ArrayList;
import java.util.List;

public class UtenteList {
    List<Utente> utenti = new ArrayList<>();

    public void addUtente(Utente utente) {
        utenti.add(utente);
    }
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for(Utente utente : utenti) {
            sb.append(utente);
        }
        return sb.toString();
    }

}

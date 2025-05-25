package org.example.view;

import org.example.model.domain.*;

import java.io.IOException;
import java.util.Scanner;

public class AddettoView {
    public static int showMenu() throws IOException {
        System.out.println("*********************************");
        System.out.println("*    TORNELLO PER ADDETTO    *");
        System.out.println("*********************************\n");
        System.out.println("*** Bentornato! Cosa posso fare per te? ***\n");
        System.out.println("1) Registra un nuovo utente");
        System.out.println("2) Aggiorna il badge di un utente");
        System.out.println("3) Aggiorna i contatti di un utente");
        System.out.println("4) Aggiungi un iscrizione a un utente");
        System.out.println("5) Aggiungi un corso alla struttura");
        System.out.println("6) Modifica le informazioni generali di un corso");
        System.out.println("7) Annulla un corso");
        System.out.println("8) Aggiungi un appuntamento di un corso");
        System.out.println("9) Modifica un appuntamento di un corso");
        System.out.println("10) Rimuovi un appuntamento di un corso");
        System.out.println("11) Aggiungi un addetto alla segreteria");
        System.out.println("12) Modifica le credenziali di un addetto alla segreteria");
        System.out.println("13) Rimuovi un addetto alla segreteria");
        System.out.println("14) Accedi come un diverso addetto alla segreteria");
        System.out.println("15) Genera un report sugli accessi");
        System.out.println("16) Visualizza gli utenti di un corso");
        System.out.println("17) Visualizza i corsi di un utente");
        System.out.println("18) Visualizza gli appuntamenti di un corso");
        System.out.println("19) Esci");

        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Inserisci la tua scelta quì: ");
            choice = input.nextInt();
            if (choice >= 1 && choice <= 19) {
                break;
            }
            System.out.println("Non hai scelto un'operazione valida. Ritenta");
        }

        return choice;
    }

    //per rendere più leggibile l'input dei contatti, di utente e di addetto ho creato un metodo per chiedere il suo identificativo a parte
    public static String getCodiceFiscale(){
        Scanner input = new Scanner(System.in);
        String codiceFiscale = null;
        System.out.print("Inserisci il codice fiscale dell'utilizzatore: ");
        codiceFiscale = input.nextLine();
        return codiceFiscale;
    }
    
    public static Utilizzatore getUtilizzatore(Object... params) {
        Utilizzatore utilizzatore = new Utilizzatore();
        Scanner input = new Scanner(System.in);
        if (params.length == 0) {
            utilizzatore.setCF(getCodiceFiscale());
        } else {
            utilizzatore.setCF(params[0].toString());
        }
        System.out.print("Inserisci l'indirizzo: ");
        utilizzatore.setIndirizzo(input.nextLine());
        System.out.print("Inserisci il nome: ");
        utilizzatore.setNome(input.nextLine());
        return utilizzatore;
    }

    public static Badge getBadge() {
        Badge badge = new Badge();
        Scanner input = new Scanner(System.in);
        try {
            System.out.print("Inserisci il badge: ");
            badge.setBadgeID(input.nextInt());
        }catch (NumberFormatException e) {
            System.out.println("Devi inserire il nuovo codice del badge");
        }
        return badge;
    }

    public static int getNumberOfObjects(String stringa){
        int choice = 0;
        try {
            Scanner input = new Scanner(System.in);
            System.out.print(stringa + " vuoi aggiungere? : ");
            choice = input.nextInt();
        }catch (IllegalArgumentException e){
            System.out.println("INSERISCI UN NUMERO");
        }
        return choice;
    }

    public static Email GetEmail() {
        Email email = new Email();
        Scanner input = new Scanner(System.in);
        System.out.print("Inserisci l'indirizzo email: ");
        email.setEmail(input.nextLine());
        if(email.getEmail() == null || email.getEmail().isEmpty()) {
            return null;
        }else{
            return email;
        }
    }

    public static Telefono GetTelefono() {
        Telefono telefono = new Telefono();
        Scanner input = new Scanner(System.in);
        do {
            System.out.print("Inserisci il numero di telefono (vuoto per non inserire nulla): ");
            telefono.setTelefono(input.nextLine());
        }while(telefono.getTelefono().length()>1 && telefono.getTelefono().length()!=10);
        if(telefono.getTelefono().isEmpty()) {
            return null;
        }else{
            return telefono;
        }
    }

    public static Cellulare GetCellulare() {
        Cellulare cellulare = new Cellulare();
        Scanner input = new Scanner(System.in);
        do {
            System.out.print("Inserisci il numero di cellulare (vuoto per non inserire nulla): ");
            cellulare.setCellulare(input.nextLine());
        }while(cellulare.getCellulare().length()>1 && cellulare.getCellulare().length()!=10);
        if(cellulare.getCellulare().isEmpty()) {
            return null;
        }else{
            return cellulare;
        }
    }

    public static int getCodiceCorso() {
        Scanner input = new Scanner(System.in);
        int codiceCorso = 0;
        try {
            System.out.print("Inserisci il codice del corso: ");
            codiceCorso = input.nextInt();
        }catch (IllegalArgumentException e){
            System.out.println("INSERISCI UN NUMERO");
        }
        return codiceCorso;
    }


}

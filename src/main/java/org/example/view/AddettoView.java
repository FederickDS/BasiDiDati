package org.example.view;

import org.example.model.domain.*;
import org.example.utils.TimestampGenerator;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
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

    public static int getSceltaOperazione(String stringa) {
        Scanner input = new Scanner(System.in);
        int sceltaOperazione = 0;
        try{
            System.out.print("Inserisci la scelta " + stringa + " : ");
            sceltaOperazione = input.nextInt();
        }catch (IllegalArgumentException e){
            System.out.println("Devi inserire il numero dell'operazione scelta");
        }
        return sceltaOperazione;
    }

    public static void print(String stringa) {
        System.out.println(stringa);
    }


    public static Corso getCorso(String suffisso) {
        char stato;
        Corso corso = new Corso();
        Scanner input = new Scanner(System.in);
        try {
            System.out.print("Inserisci il nome"+ suffisso+": ");
            corso.setNome(input.nextLine());
            System.out.print("Inserisci il minimo di utenti"+ suffisso +": ");
            corso.setMinimo(input.nextInt());
            System.out.print("Inserisci la capienza"+ suffisso +": ");
            corso.setCapienza(input.nextInt());
            System.out.print("Inserisci il costo del corso" + suffisso +": ");
            corso.setCosto(input.nextInt());
            System.out.print("Data di inizio del corso" + suffisso +": ");
            corso.setDataInizio(getGiorno());
            System.out.print("Data di fine del corso" + suffisso +": ");
            corso.setDataFine(getGiorno());
            do {
                System.out.print("Il corso è già stato confermato (Si: C /No: P)? ");
                stato = input.next().charAt(0);
            } while (stato != 'C' && stato != 'P');
            corso.setStato(stato);
            corso.setNumIscritti(0);//non viene deciso dall'addetto ma lo imponiamo noi
        }catch (IllegalArgumentException e){
            System.out.println("Hai inserito un valore di tipo, ritenta.");
        }
        return corso;
    }

    public static Corso changeCorso(String suffisso){
        char stato;
        String buffer;
        Corso corso = new Corso();
        Scanner input = new Scanner(System.in);
        try {
            System.out.print("Inserisci il nome"+ suffisso+": ");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                corso.setNome(buffer);
            }
            System.out.print("Inserisci il minimo di utenti"+ suffisso +": ");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                corso.setMinimo(Integer.getInteger(buffer));
            }
            System.out.print("Inserisci la capienza"+ suffisso +": ");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                corso.setCapienza(Integer.getInteger(buffer));
            }
            System.out.print("Inserisci il costo del corso" + suffisso +": ");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                corso.setCosto(Integer.getInteger(buffer));
            }
            System.out.print("Vuoi cambiare la data di inizio del corso (Si: premi almeno un tasto, no: premi solo invio)? ");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                corso.setDataInizio(getGiorno());
            }
            System.out.print("Vuoi cambiare la data di inizio del corso (Si: premi almeno un tasto, no: premi solo invio)? ");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                corso.setDataFine(getGiorno());
            }
            do {
                System.out.print("Il corso è già stato confermato (Si: C /No: P)? ");
                stato = input.next().charAt(0);
            } while (stato != 'C' && stato != 'P');
            corso.setStato(stato);
        }catch (IllegalArgumentException e){
            System.out.println("Hai inserito un valore di tipo, ritenta.");
        }
        return corso;
    }

    public static Appuntamento getAppuntamentoCode(){
        Scanner input = new Scanner(System.in);
        Appuntamento appuntamento = new Appuntamento();
        try {
            System.out.print("Inserisci il corso: ");
            appuntamento.setCorso(input.nextInt());
            System.out.println("Inserisci la data di inizio:");
            appuntamento.setInizio(getOrario());
        }catch(IllegalArgumentException e){
            System.out.println("Hai inserito un valore di tipo errato, ritenta.");
        }
        return appuntamento;
    }

    public static Appuntamento getAppuntamentoExtra(){
        Scanner input = new Scanner(System.in);
        Appuntamento appuntamento = new Appuntamento();
        try {
            System.out.print("Inserisci la vasca: ");
            appuntamento.setVasca(input.nextLine());
            System.out.println("Inserisci la data di fine:");
            appuntamento.setFine(getOrario());
        }catch(IllegalArgumentException e){
            System.out.println("Hai inserito un valore di tipo errato, ritenta.");
        }
        return appuntamento;
    }

    public static Appuntamento getAppuntamentoChoice(){
        Scanner input = new Scanner(System.in);
        Appuntamento appuntamento = new Appuntamento();
        String buffer;
        try {
            System.out.print("Inserisci la vasca (non inserire niente per lasciare): ");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                appuntamento.setVasca(buffer);
            }
            System.out.println("Vuoi cambiare la data di fine (Si: premi almeno un tasto, No: premi solo invio)?");
            buffer = input.nextLine();
            if(!buffer.isEmpty()){
                appuntamento.setFine(getOrario());
            }
        }catch(IllegalArgumentException e){
            System.out.println("Hai inserito un valore di tipo errato, ritenta.");
        }
        return appuntamento;
    }

    public static Addetto getAddetto(){
        Scanner input = new Scanner(System.in);
        Addetto addetto = new Addetto();
        System.out.print("Inserisci lo username: ");
        addetto.setUsername(input.nextLine());
        System.out.print("Inserisci la password: ");
        addetto.setPassword(input.nextLine());
        return addetto;
    }

    public static Addetto choiceAddetto(){
        Scanner input = new Scanner(System.in);
        Addetto addetto = new Addetto();
        String buffer;
        System.out.print("Inserisci lo username ( non inserire nulla per mantenerlo ): ");
        buffer = input.nextLine();
        if(!buffer.isEmpty()){
            addetto.setUsername(buffer);
        }
        System.out.print("Inserisci la password ( non inserire nulla per mantenerlo ): ");
        buffer = input.nextLine();
        if(!buffer.isEmpty()){
            addetto.setPassword(buffer);
        }
        return addetto;
    }

    public static Timestamp getGiorno() {
        Scanner input = new Scanner(System.in);
        System.out.print("Inserisci l'anno: ");
        int anno = input.nextInt();
        System.out.print("Inserisci il mese: ");
        int mese = input.nextInt();
        System.out.print("Inserisci il giorno: ");
        int giorno = input.nextInt();
        return TimestampGenerator.generaTimestamp(anno,mese,giorno,0,0,0);
    }

    public static Timestamp getOrario() {
        Scanner input = new Scanner(System.in);
        System.out.print("Inserisci l'anno: ");
        int anno = input.nextInt();
        System.out.print("Inserisci il mese: ");
        int mese = input.nextInt();
        System.out.print("Inserisci il giorno: ");
        int giorno = input.nextInt();
        System.out.print("Inserisci l'ora: ");
        int ora = input.nextInt();
        System.out.print("Inserisci il minuto: ");
        int minuto = input.nextInt();
        return TimestampGenerator.generaTimestamp(anno,mese,giorno,ora,minuto,0);
    }

    public static Report getDateReport() {
        Report report = new Report();
        try{
            System.out.print("Inserisci l'orario di inizio: ");
            report.setInizio(AddettoView.getOrario());
            System.out.print("Inserisci l'orario di fine: ");
            report.setFine(AddettoView.getOrario());
        }catch(IllegalArgumentException e){
            System.out.println("Hai inserito un orario con dei valori impossibili, ritenta.");
        }
        return report;
    }

    public static void printReport(Report report) {
        System.out.println("Grazie per aver richiesto il report");
        System.out.println("Orario di inizio: " + report.getInizio());
        System.out.println("Orario di fine: " + report.getFine());
        System.out.println("Numero di utenti previsti: " + report.getUtentiPrevisti());
        System.out.println("Numero di utenti effettivi: " + report.getUtentiEffettivi());
    }

    public static void printUtenti(List<IscrittoCorso> iscritti) {
        for (IscrittoCorso iscritto : iscritti) {
            System.out.println(iscritto);
        }
    }

    public static void printCorsi(List<Corso> corsi) {
        for (Corso corso : corsi) {
            System.out.println(corso);
        }
    }

    public static void printAppuntamenti(List<Appuntamento> lista) {
        for(Appuntamento appuntamento : lista){
            System.out.println(appuntamento);
        }
    }
}

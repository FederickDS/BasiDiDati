package org.example.view;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class UtenteView {

    public static int showMenu() throws IOException {
        System.out.println("*********************************");
        System.out.println("*    TORNELLO PER ACCESSO UTENTE    *");
        System.out.println("*********************************\n");
        System.out.println("*** Bentornato! Cosa posso fare per te? ***\n");
        System.out.println("1) Accesso alla struttura");
        System.out.println("2) Esci");


        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Inserisci la tua scelta quì: ");
            choice = input.nextInt();
            if (choice >= 1 && choice <= 2) {
                break;
            }
            System.out.println("Non hai scelto un'operazione valida. Ritenta");
        }

        return choice;
    }

    public static int getBadge() {
        int badge = 0;
        System.out.print("Inserisci il codice del tuo badge: ");
        try{
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            badge = Integer.parseInt(reader.readLine());
        }catch (IOException e){
            e.printStackTrace();
        }catch (NumberFormatException e){
            System.out.println("Errore: Il codice del badge deve essere un numero");
        }
        return badge;
    }

    public static void showMessage(String msg) {
        System.out.println(msg);
    }
}

package org.example.view;

import org.example.model.domain.Credentials;
import org.example.model.domain.Role;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class LoginView {
    public static Credentials authenticate() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Modalità di esecuzione (1-Addetto Segreteria, 2-Tornello): ");
        String mode = reader.readLine();
        Role ruolo = Role.fromInt(Integer.parseInt(mode));
        if (ruolo == Role.UTENTE) {
            return new Credentials(null,null, ruolo);
        }
        System.out.print("username: ");
        String username = reader.readLine();
        System.out.print("password: ");
        String password = reader.readLine();

        return new Credentials(username, password, null);//sarebbe come Role.fromInt(Integer.parseInt(mode))
    }
}

package org.example.controller;

import org.example.model.domain.Credentials;

public class ApplicationController implements Controller {
    Credentials cred;

    @Override
    public void start() {
        LoginController loginController = new LoginController();
        loginController.start();
        cred = loginController.getCred();

        if(cred.getRole() == null) {
            //da LoginCon Role.getInt(role)=null, quindi entra nell'if
            throw new RuntimeException("Credenziali invalide");
        }

        switch(cred.getRole()) {
            case UTENTE -> new UtenteController().start();
            case ADDETTO -> new AddettoController().start();
            default -> throw new RuntimeException("Credenziali invalide");
        }
    }
}

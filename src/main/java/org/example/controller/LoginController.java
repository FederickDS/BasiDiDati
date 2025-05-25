package org.example.controller;

import org.example.exception.DAOException;
import org.example.model.dao.LoginProcedureDAO;
import org.example.model.domain.Credentials;
import org.example.view.LoginView;

import java.io.IOException;

public class LoginController implements Controller {
    Credentials cred = null;

    @Override
    public void start() {
        try {
            cred = LoginView.authenticate();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            // se ruolo è già stato assegnato non serve la verifica credenziali dell'addettp
            if(cred.getRole() == null) {
                cred = new LoginProcedureDAO().execute(cred.getUsername(), cred.getPassword());
            }
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public Credentials getCred() {
        return cred;
    }
}


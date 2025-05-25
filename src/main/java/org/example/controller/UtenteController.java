package org.example.controller;

import org.example.exception.DAOException;
import org.example.model.dao.GenericProcedureDAO;
import org.example.model.dao.BookingListProcedureDAO;
import org.example.model.dao.ConnectionFactory;
import org.example.model.dao.salvaAccessoDAO;
import org.example.model.dao.verificaBadgeValidoDAO;
import org.example.model.domain.BookingList;
import org.example.model.domain.Role;
import org.example.view.UtenteView;

import java.io.IOException;
import java.sql.SQLException;

public class UtenteController implements Controller{

    @Override
    public void start() {
        try {
            ConnectionFactory.changeRole(Role.UTENTE);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        while(true) {
            int choice;
            try {
                choice = UtenteView.showMenu();
            } catch(IOException e) {
                throw new RuntimeException(e);
            }

            switch(choice) {
                case 1 -> salvaAccessoStruttura();
                case 2 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    public void salvaAccessoStruttura() {
        int badge;
        GenericProcedureDAO dao;//puo essere ogni DAO
        try{
            badge = UtenteView.getBadge();
            //per utente associato al badge esiste un appuntamento valido
            dao = new verificaBadgeValidoDAO();
            UtenteView.showMessage(dao.execute(badge).toString());
            //salva l'accesso dell'utente con il badge ricevuto
            dao = new salvaAccessoDAO();
            UtenteView.showMessage(dao.execute(badge).toString());
        }catch(DAOException e){
            UtenteView.showMessage(e.getMessage());
        }catch(SQLException e){
            UtenteView.showMessage("Errore in database: " + e.getMessage());
        }
    }
}

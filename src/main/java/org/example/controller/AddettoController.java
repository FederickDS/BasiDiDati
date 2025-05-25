package org.example.controller;

import jdk.jshell.execution.StreamingExecutionControl;
import org.example.exception.DAOException;
import org.example.model.dao.AggiornaBadgeUtenteDAO;
import org.example.model.dao.ConnectionFactory;
import org.example.model.dao.NuovoContattoUtenteDAO;
import org.example.model.dao.RegistraNuovoUtenteDAO;
import org.example.model.domain.*;
import org.example.view.AddettoView;
import org.example.view.UtenteView;

import java.io.IOException;
import java.sql.SQLException;

public class AddettoController implements Controller {

    @Override
    public void start() {
        try {
            ConnectionFactory.changeRole(Role.ADDETTO);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        while(true) {
            int choice;
            try {
                choice = AddettoView.showMenu();
            } catch(IOException e) {
                throw new RuntimeException(e);
            }

            switch(choice) {
                case 1 -> RegistraNuovoUtente();
                case 2 -> AggiornaBadgeUtente();
                case 3 -> AggiornaContattiUtente();
                case 4 -> NuovaIscrizioneUtente();
                case 5 -> AggiungiCorso();
                case 6 -> ModificaCorso();
                case 7 -> AnnullaCorso();
                case 8 -> AggiungiAppuntamento();
                case 9 -> ModificaAppuntamento();
                case 10 -> RimuoviAppuntamento();
                case 11 -> AggiungiAddetto();
                case 12 -> ModificaAddetto();
                case 13 -> RimuoviAddetto();
                case 14 -> LoginAddetto();
                case 15 -> GeneraReportAccessi();
                case 16 -> VisualizzaUtentiDiUnCorso();
                case 17 -> VisualizzaCorsiDiUnUtente();
                case 18 -> VisualizzaAppuntamentiDiUnCorso();
                case 19 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    void RegistraNuovoUtente() {
        //1) ottieni informazioni sull'utilizzatore
        Utilizzatore utilizzatore = AddettoView.getUtilizzatore();
        utilizzatore.setUtente(new Utente());
        //2) ottieni informazioni sul badge
        Badge badge = AddettoView.getBadge();
        utilizzatore.getUtente().setBadge(badge);
        //3) ottieni informazioni sul corso
        Corso corso = new Corso();
        corso.setCorsoID(AddettoView.getCodiceCorso());
        //4) chiedi contatti
        Cellulare cellulare = AddettoView.GetCellulare();
        utilizzatore.addCellulare(cellulare);
        Telefono telefono = AddettoView.GetTelefono();
        utilizzatore.addTelefono(telefono);
        Email email = AddettoView.GetEmail();
        utilizzatore.addEmail(email);
        //5) salva tramite DAO
        try {
            RegistraNuovoUtenteDAO dao = new RegistraNuovoUtenteDAO();
            System.out.println(dao.execute(utilizzatore, corso).toString());
        }catch (SQLException e){
           System.out.println("Inserimento fallito: errore nel database");
        } catch (DAOException e) {
            System.out.println(e.getMessage());
        }
    }
    void AggiornaBadgeUtente() {
        Utilizzatore utilizzatore = new Utilizzatore();
        utilizzatore.setCF(AddettoView.getCodiceFiscale());
        utilizzatore.setUtente(new Utente());
        utilizzatore.getUtente().setBadge(AddettoView.getBadge());
        //ottenuto il badge, modifichiamo quello esistente.
        AggiornaBadgeUtenteDAO dao = new AggiornaBadgeUtenteDAO();
        try {
            System.out.println(dao.execute(utilizzatore));
        } catch (DAOException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    void AggiornaContattiUtente() {
        Utilizzatore utilizzatore = new Utilizzatore();
        utilizzatore.setCF(AddettoView.getCodiceFiscale());
        utilizzatore.addCellulare(AddettoView.GetCellulare());
        utilizzatore.addTelefono(AddettoView.GetTelefono());
        utilizzatore.addEmail(AddettoView.GetEmail());
        NuovoContattoUtenteDAO dao = new NuovoContattoUtenteDAO();
        try {
            dao.execute(utilizzatore);
        } catch (DAOException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    void NuovaIscrizioneUtente() {}
    void AggiungiCorso() {}
    void AggiungiAppuntamento() {}
    void AggiungiAddetto() {}
    void ModificaCorso() {}
    void AnnullaCorso() {}
    void ModificaAppuntamento() {}
    void RimuoviAppuntamento() {}
    void ModificaAddetto() {}
    void RimuoviAddetto() {}
    void LoginAddetto() {}
    void GeneraReportAccessi() {}
    void VisualizzaUtentiDiUnCorso() {}
    void VisualizzaCorsiDiUnUtente() {}
    void VisualizzaAppuntamentiDiUnCorso() {}

}

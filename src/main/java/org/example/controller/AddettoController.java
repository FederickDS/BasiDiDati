package org.example.controller;

import org.example.exception.DAOException;
import org.example.model.dao.*;
import org.example.model.domain.*;
import org.example.view.AddettoView;

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
            AddettoView.print(dao.execute(utilizzatore, corso).toString());
        }catch (SQLException e){
            AddettoView.print("Inserimento fallito: errore nel database");
        } catch (DAOException e) {
            AddettoView.print(e.getMessage());
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
            AddettoView.print(dao.execute(utilizzatore));
        } catch (DAOException | SQLException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void AggiornaContattiUtente() {
        int choice = 0;
        while(choice != 1 && choice != 2) {
            choice = AddettoView.getSceltaOperazione("( 1 Inserisci contatto - 2 Elimina contatto )");
        }
        Utilizzatore utilizzatore = new Utilizzatore();
        utilizzatore.setCF(AddettoView.getCodiceFiscale());
        utilizzatore.addCellulare(AddettoView.GetCellulare());
        utilizzatore.addTelefono(AddettoView.GetTelefono());
        utilizzatore.addEmail(AddettoView.GetEmail());
        NuovoContattoUtenteDAO dao = new NuovoContattoUtenteDAO();
        try {
            AddettoView.print(dao.execute(utilizzatore,choice).toString());
        } catch (DAOException | SQLException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void NuovaIscrizioneUtente() {
        NuovaIscrizioneUtenteDAO dao = new NuovaIscrizioneUtenteDAO();
        Corso corso = new Corso();
        corso.setCorsoID(AddettoView.getCodiceCorso());
        Utilizzatore utilizzatore = new Utilizzatore();
        utilizzatore.setCF(AddettoView.getCodiceFiscale());
        try {
            AddettoView.print(dao.execute(utilizzatore, corso));
        } catch (DAOException|SQLException e) {
            AddettoView.print("Inserimento fallito: errore nel database" + e.getMessage());
        }
    }
    void AggiungiCorso() {
        //1)ricevi tutte le informazioni del corso
        AddettoView.print("Inserimento informazioni per nuovo corso ");
        Corso corso = AddettoView.getCorso("");
        InserisciCorsoDAO dao = new InserisciCorsoDAO();
        try {
            AddettoView.print(dao.execute(corso).toString());
        } catch (DAOException|SQLException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void AggiungiAppuntamento() {
        Appuntamento appuntamento = AddettoView.getAppuntamentoCode();
        Appuntamento appuntamentoExtra = AddettoView.getAppuntamentoExtra();
        appuntamento.setFine(appuntamentoExtra.getFine());
        appuntamento.setVasca(appuntamentoExtra.getVasca());
        InserisciAppuntamentoDAO dao = new InserisciAppuntamentoDAO();
        try {
            AddettoView.print(dao.execute(appuntamento));
        } catch (SQLException | DAOException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void AggiungiAddetto() {
        //1) mi prendo le informazioni dell'utilizzatore (prende da solo il codice fiscale)
        Utilizzatore utilizzatore = AddettoView.getUtilizzatore();
        //3) mi prendo le informazioni dell'addetto
        utilizzatore.setAddetto(AddettoView.getAddetto());
        InserisciAddettoDAO dao = new InserisciAddettoDAO();
        try {
            AddettoView.print(dao.execute(utilizzatore));
        } catch (SQLException | DAOException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void ModificaCorso() {
        int id = AddettoView.getCodiceCorso();
        Corso corso = AddettoView.changeCorso("( lascia vuoto per non modificare )");
        corso.setCorsoID(id);
        ModificaCorsoDAO dao = new ModificaCorsoDAO();
        try {
            AddettoView.print(dao.execute(corso).toString());
        } catch (DAOException|SQLException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void AnnullaCorso() {
        Corso corso = new Corso();
        corso.setCorsoID(AddettoView.getCodiceCorso());
        //dato il codice del corso, annulla tale corso
        AnnullaCorsoDAO dao = new AnnullaCorsoDAO();
        try{
            AddettoView.print(dao.execute(corso));
        }catch (DAOException|SQLException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void ModificaAppuntamento() {
        Appuntamento appuntamento = AddettoView.getAppuntamentoCode();
        Appuntamento appuntamentoChoice = AddettoView.getAppuntamentoChoice();
        appuntamento.setFine(appuntamentoChoice.getFine());
        appuntamento.setVasca(appuntamentoChoice.getVasca());
        ModificaAppuntamentoDAO dao = new ModificaAppuntamentoDAO();
        try {
            AddettoView.print(dao.execute(appuntamento));
        } catch (SQLException | DAOException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void RimuoviAppuntamento() {
        Appuntamento appuntamento = AddettoView.getAppuntamentoCode();
        RimuoviAppuntamentoDAO dao = new RimuoviAppuntamentoDAO();
        try {
            AddettoView.print(dao.execute(appuntamento));
        } catch (SQLException | DAOException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void ModificaAddetto() {
        String CF = AddettoView.getCodiceFiscale();
        Addetto addetto = AddettoView.choiceAddetto();
        addetto.setCF(CF);
        ModificaAddettoDAO dao = new ModificaAddettoDAO();
        try {
            AddettoView.print(dao.execute(addetto));
        } catch (SQLException | DAOException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void RimuoviAddetto() {
        Addetto addetto = new Addetto();
        addetto.setCF(AddettoView.getCodiceFiscale());
        RimuoviAddettoDAO dao = new RimuoviAddettoDAO();
        try {
            AddettoView.print(dao.execute(addetto));
        } catch (SQLException | DAOException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void LoginAddetto() {
        //potrebbe essere un'operazione INUTILE, RIVEDERE !!!!!!!!!!!!!!!!!
        ApplicationController applicationController = new ApplicationController();
        applicationController.start();
    }
    void GeneraReportAccessi() {
        Report report = AddettoView.getDateReport();
        GeneraReportDAO dao = new GeneraReportDAO();
        try {
            AddettoView.printReport(dao.execute(report));
        } catch (SQLException | DAOException e) {
            AddettoView.print(e.getMessage());
        }
    }
    void VisualizzaUtentiDiUnCorso() {}
    void VisualizzaCorsiDiUnUtente() {}
    void VisualizzaAppuntamentiDiUnCorso() {}

}

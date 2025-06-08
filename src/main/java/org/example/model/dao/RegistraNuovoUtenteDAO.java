package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.*;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

public class RegistraNuovoUtenteDAO implements GenericProcedureDAO {

    @Override
    public Object execute(Object... params) throws DAOException, SQLException {
        if (params.length != 2) {
            throw new DAOException("Inserire informazioni di Utilizzatore e di corso.");
        }

        try {
            // 1) Estrazione degli oggetti
            Utilizzatore util = (Utilizzatore) params[0];
            Corso corso = (Corso) params[1];

            ArrayList<Email> emails   = util.getEmails();
            ArrayList<Telefono> telefoni = util.getTelefoni();
            ArrayList<Cellulare> cellulari = util.getCellulari();

            // 2) Determino tipo dei contatti, posto che capita al più un contatto di tipo email, telefono o cellulare
            Email email = emails.getFirst();
            Telefono telefono = telefoni.getFirst();
            Cellulare cellulare = cellulari.getFirst();

            // 3) Preparazione della chiamata
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{ call registrazioneNuovoUtente(?, ?, ?, ?, ?, ?, ?, ?) }");

            // Parametri IN della procedura
            cs.setString(1, util.getCF());
            cs.setString(2, util.getIndirizzo());
            cs.setString(3, util.getNome());
            cs.setInt   (4, util.getUtente().getBadge().getBadgeID());

            // email
            if (email != null) {
                cs.setString(5, email.getEmail());
            } else {
                cs.setNull(5, Types.VARCHAR);
            }

            // telefono
            if (telefono != null) {
                cs.setString(6, telefono.getTelefono());
            } else {
                cs.setNull(6, Types.CHAR);
            }

            // cellulare
            if (cellulare != null) {
                cs.setString(7, cellulare.getCellulare());
            } else {
                cs.setNull(7, Types.CHAR);
            }

            // iscrizione (codice corso)
            cs.setInt(8, corso.getCorsoID());

            // 4) Esecuzione
            cs.execute();

            return "\nNuovo utente aggiunto con successo!\n";

        } catch (SQLException e) {
            throw new DAOException("Il salvataggio del nuovo utente ha fallito: " + e.getMessage());
        }
    }
}

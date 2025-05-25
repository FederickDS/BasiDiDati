package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Cellulare;
import org.example.model.domain.Email;
import org.example.model.domain.Telefono;
import org.example.model.domain.Utilizzatore;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

public class NuovoContattoUtenteDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException, SQLException {
        Utilizzatore util = (Utilizzatore) params[0];
        int choice = (int) params[1];
        try{
            ArrayList<Email> emails   = util.getEmails();
            ArrayList<Telefono> telefoni = util.getTelefoni();
            ArrayList<Cellulare> cellulari = util.getCellulari();

            // 2) Determino tipo dei contatti, posto che capita al più un contatto di tipo email, telefono o cellulare
            Email email = emails.getFirst();
            Telefono telefono = telefoni.getFirst();
            Cellulare cellulare = cellulari.getFirst();

            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{ call updateContattiUtilizzatore(?, ?, ?, ?, ?) }");

            cs.setString(1,util.getCF());

            // email
            if (email != null) {
                cs.setString(2, email.getEmail());
            } else {
                cs.setNull(2, Types.VARCHAR);
            }

            // telefono
            if (telefono != null) {
                cs.setString(3, telefono.getTelefono());
            } else {
                cs.setNull(3, Types.CHAR);
            }

            // cellulare
            if (cellulare != null) {
                cs.setString(4, cellulare.getCellulare());
            } else {
                cs.setNull(4, Types.CHAR);
            }

            cs.setInt(5, choice);

            cs.execute();
            if(choice==1){
                return "\nNuovi contatti inseriti!\n";
            }else if(choice==2){
                return "\nVecchi contatti eliminati!\n";
            }
        } catch (SQLException e) {
            throw new DAOException("Errore nell'inserimento: " + e.getMessage());
        }
        return "\nErrore: operazione eseguita non chiara, codice " +  choice + "\n";
    }
}

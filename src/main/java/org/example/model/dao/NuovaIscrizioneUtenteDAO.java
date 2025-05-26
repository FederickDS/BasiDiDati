package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Corso;
import org.example.model.domain.Utilizzatore;
import org.example.view.AddettoView;

import java.sql.*;

public class NuovaIscrizioneUtenteDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        Utilizzatore util = (Utilizzatore) params[0];
        Corso corso = (Corso) params[1];
        try{
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call iscriviUtenteACorso(?,?)}");
            cs.setString(1,util.getCF());
            cs.setInt(2,corso.getCorsoID());
            cs.execute();
            return "\nUtente correttamente Iscritto!\n";
        }catch (SQLException e){
            throw new DAOException("Errore nell'inserimento in iscrizione: " + e.getMessage());
        }
    }
}

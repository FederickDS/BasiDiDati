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

    public String showCostoCorso(int corsoID){
        String query = "SELECT costo FROM Corso WHERE CorsoID = ?";
        try{
            Connection conn = ConnectionFactory.getConnection();
            PreparedStatement cs = conn.prepareStatement(query);
            cs.setInt(1,corsoID);
            ResultSet rs = cs.executeQuery();
            if(rs.next()){
                return String.valueOf(rs.getInt("costo"));
            }
        } catch (SQLException e) {
            System.out.print("Errore nella lettura del costo del corso: " + e.getMessage());
        }
        return null;
    }
}

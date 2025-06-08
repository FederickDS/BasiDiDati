package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Corso;
import org.example.model.domain.Utilizzatore;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class AnnullaCorsoDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        Corso corso = (Corso) params[0];
        try{
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call annullaCorso(?)}");
            cs.setInt(1,corso.getCorsoID());
            cs.executeUpdate();
            return "\n Corso annullato!\n";
        }catch (SQLException e){
            throw new DAOException("Errore nell'annullamento del corso: " + e.getMessage());
        }
    }
}

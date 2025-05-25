package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Utilizzatore;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class AggiornaBadgeUtenteDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        Utilizzatore utils = (Utilizzatore) params[0];
        try{
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call updateBadgeUtente(?,?)}");
            cs.setString(1,utils.getCF());
            cs.setInt(2,utils.getUtente().getBadge().getBadgeID());
            cs.execute();
            return "\nBadge aggiornato con successo!\n";
        }catch(SQLException e){
            throw new DAOException("Errore: Badge inserito non utilizzabile");
        }
    }
}

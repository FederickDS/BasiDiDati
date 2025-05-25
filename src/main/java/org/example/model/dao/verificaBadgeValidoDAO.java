package org.example.model.dao;

import org.example.exception.DAOException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class verificaBadgeValidoDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException, SQLException {
        try{
            int badge = Integer.parseInt(params[0].toString());
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call checkAppuntamentiPerBadge(?,?)}");
            cs.setInt(1, badge);
            cs.registerOutParameter(2, java.sql.Types.BOOLEAN);
            cs.execute();
            boolean output = cs.getBoolean(2);
            //controlla valore di ritorno, il booleano
            if(!output){
                throw new DAOException("\nNon puoi partecipare a nessun corso di oggi\n");
            }
        }catch (SQLException e){
            throw new DAOException("\nInserimento badge fallito: " + e.getMessage() + "\n");
        }
        return "\nCi sono dei corsi che ti aspettano!\n";
    }
}

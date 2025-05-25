package org.example.model.dao;

import org.example.exception.DAOException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class salvaAccessoDAO implements GenericProcedureDAO{
        @Override
        public Object execute(Object... params) throws DAOException, SQLException {
            try{
                int badge = Integer.parseInt(params[0].toString());
                Connection conn = ConnectionFactory.getConnection();
                //seconda query, per scrivere effettivamente
                CallableStatement cs = conn.prepareCall("{call insertNuovoAccesso(?)}");
                cs.setInt(1, badge);
                cs.execute();
            }catch (SQLException e){
                throw new DAOException("\nIl salvataggio dell'accesso ha fallito, ritenta\n");
            }
            return "\nUtente verificato, puoi accedere!\n";
        }
    }

package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Addetto;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class ModificaAddettoDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per InserisciCorso. Attesi: 1");
        }
        Addetto addetto = (Addetto) params[0];
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL ModificaAddetto(?,?,?)}");

            cs.setString(1, addetto.getCF());
            if(addetto.getUsername() != null){
                cs.setString(2, addetto.getUsername());
            }else{
                cs.setNull(2, Types.VARCHAR);
            }
            if(addetto.getPassword() != null){
                cs.setString(3, addetto.getPassword());
            }else{
                cs.setNull(3, Types.VARCHAR);
            }

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Annullamento dell'addetto fallito: " + e.getMessage());
        }

        return "\nAddetto modificato con successo!\n";
    }

}

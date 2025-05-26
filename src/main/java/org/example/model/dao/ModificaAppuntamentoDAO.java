package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Appuntamento;
import org.example.model.domain.Corso;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class ModificaAppuntamentoDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per InserisciCorso. Attesi: 1");
        }
        Appuntamento appuntamento = (Appuntamento) params[0];
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL ModificaAppuntamento(?,?,?,?,?,?)}");

            cs.setInt(1, appuntamento.getCorso());
            cs.setTimestamp(2, appuntamento.getInizio());
            cs.setInt(3, appuntamento.getCorso());
            if(appuntamento.getVasca() != null){
                cs.setString(4, appuntamento.getVasca());
            }else{
                cs.setNull(4, Types.VARCHAR);
            }
            cs.setTimestamp(5, appuntamento.getInizio());
            if(appuntamento.getFine() != null){
                cs.setTimestamp(6, appuntamento.getFine());
            }else{
                cs.setNull(6, Types.TIMESTAMP);
            }

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Inserimento del corso fallito: " + e.getMessage());
        }

        return "\nAppuntamento inserito con successo!\n";
    }

}

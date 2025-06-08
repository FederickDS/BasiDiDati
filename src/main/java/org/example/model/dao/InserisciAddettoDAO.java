package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Appuntamento;
import org.example.model.domain.Corso;
import org.example.model.domain.Utilizzatore;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class InserisciAddettoDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per InserisciCorso. Attesi: 1");
        }
        Utilizzatore util = (Utilizzatore) params[0];
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL aggiuntaAddettoSegreteria(?,?,?,?,?)}");

            cs.setString(1, util.getCF());
            cs.setString(2, util.getIndirizzo());
            cs.setString(3, util.getNome());
            cs.setString(4,util.getAddetto().getUsername());
            cs.setString(5,util.getAddetto().getPassword());

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Inserimento del corso fallito: " + e.getMessage());
        }

        return "\nAddetto inserito con successo!\n";
    }

}

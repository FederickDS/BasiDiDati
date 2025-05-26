package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Addetto;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class RimuoviAddettoDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per InserisciCorso. Attesi: 1");
        }
        Addetto addetto = (Addetto) params[0];
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL RimuoviAddetto(?)}");

            cs.setString(1, addetto.getCF());

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Rimozione dell'addetto fallita: " + e.getMessage());
        }

        return "\nAddetto rimosso con successo!\n";
    }

}

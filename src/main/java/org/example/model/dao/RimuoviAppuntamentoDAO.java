package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Appuntamento;
import org.example.model.domain.Corso;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class RimuoviAppuntamentoDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per InserisciCorso. Attesi: 1");
        }
        Appuntamento appuntamento = (Appuntamento) params[0];
        Timestamp original = appuntamento.getInizio();
        LocalDateTime truncated = original.toLocalDateTime()
                .withSecond(0)
                .withNano(0);
        appuntamento.setInizio(Timestamp.valueOf(truncated));
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL eliminaAppuntamento(?,?)}");

            cs.setInt(1, appuntamento.getCorso());
            cs.setTimestamp(2, appuntamento.getInizio());

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Rimozione dell'appuntamento fallita: " + e.getMessage());
        }

        return "\nAppuntamento rimosso con successo!\n";
    }

}

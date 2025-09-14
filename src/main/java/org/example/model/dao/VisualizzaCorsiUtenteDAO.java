package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Corso;
import org.example.model.domain.IscrittoCorso;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VisualizzaCorsiUtenteDAO implements GenericProcedureDAO<List<Corso>> {

    @Override
    public List<Corso> execute(Object... params) throws DAOException {
        if (params.length != 1 || !(params[0] instanceof String)) {
            throw new DAOException("Parametro errato per VisualizzaIscrittiCorso. Atteso: 1 intero (CorsoID).");
        }
        String CF = (String) params[0];
        List<Corso> corsi = new ArrayList<>();

        try (Connection conn = ConnectionFactory.getConnection();
             CallableStatement cs = conn.prepareCall("{CALL visualizzaCorsiUtente(?)}")) {

            cs.setString(1, CF);

            boolean hasResult = cs.execute();
            if (hasResult) {
                try (ResultSet rs = cs.getResultSet()) {
                    while (rs.next()) {
                        Corso corso = new Corso();
                        corso.setCorsoID(rs.getInt("CorsoID"));
                        corso.setNome(rs.getString("NomeCorso"));
                        corsi.add(corso);
                    }
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Errore in nel recupero dei corsi dell'utente: " + e.getMessage(), e);
        }

        return corsi;
    }
}

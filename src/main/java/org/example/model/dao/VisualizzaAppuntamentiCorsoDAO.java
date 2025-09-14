package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Appuntamento;
import org.example.model.domain.Corso;
import org.example.model.domain.IscrittoCorso;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VisualizzaAppuntamentiCorsoDAO implements GenericProcedureDAO<List<Appuntamento>> {

    @Override
    public List<Appuntamento> execute(Object... params) throws DAOException {
        if (params.length != 1 || !(params[0] instanceof Integer)) {
            throw new DAOException("Parametro errato per VisualizzaIscrittiCorso. Atteso: 1 intero (CorsoID).");
        }
        int corsoID = (Integer) params[0];
        List<Appuntamento> appuntamenti = new ArrayList<>();

        try (Connection conn = ConnectionFactory.getConnection();
             CallableStatement cs = conn.prepareCall("{CALL visualizzaAppuntamentiCorso(?)}")) {

            cs.setInt(1, corsoID);

            int hasResult = cs.executeUpdate();
            if (hasResult>0) {
                try (ResultSet rs = cs.getResultSet()) {
                    while (rs.next()) {
                        Appuntamento appuntamento = new Appuntamento();
                        appuntamento.setCorso(corsoID);
                        appuntamento.setInizio(rs.getTimestamp("Inizio"));
                        appuntamento.setFine(rs.getTimestamp("Fine"));
                        appuntamento.setVasca(rs.getString("Vasca"));
                        appuntamenti.add(appuntamento);
                    }
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Errore in recupero informazioni appuntamenti: " + e.getMessage(), e);
        }

        return appuntamenti;
    }
}

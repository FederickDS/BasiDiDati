package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.IscrittoCorso;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VisualizzaIscrittiCorsoDAO implements GenericProcedureDAO<List<IscrittoCorso>> {

    @Override
    public List<IscrittoCorso> execute(Object... params) throws DAOException {
        if (params.length != 1 || !(params[0] instanceof Integer)) {
            throw new DAOException("Parametro errato per VisualizzaIscrittiCorso. Atteso: 1 intero (CorsoID).");
        }
        int corsoId = (Integer) params[0];
        List<IscrittoCorso> iscritti = new ArrayList<>();

        String call = "{CALL visualizzaUtentiIscrittiACorso(?)}";
        try (Connection conn = ConnectionFactory.getConnection();
             CallableStatement cs = conn.prepareCall(call)) {

            cs.setInt(1, corsoId);

            int hasResult = cs.executeUpdate();
            if (hasResult>0) {
                try (ResultSet rs = cs.getResultSet()) {
                    while (rs.next()) {
                        String cf   = rs.getString("CF");
                        String nome = rs.getString("Nome");
                        iscritti.add(new IscrittoCorso(cf, nome));
                    }
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Errore nel recupero degli iscritti ad un corso: " + e.getMessage(), e);
        }

        return iscritti;
    }
}

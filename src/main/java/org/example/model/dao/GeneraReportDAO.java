package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Report;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class GeneraReportDAO implements GenericProcedureDAO<Report> {

    @Override
    public Report execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per Generazione report. Attesi: 1");
        }
        Report report =  (Report) params[0];
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL GeneraReport(?,?,?,?)}");

            cs.setTimestamp(1, report.getInizio());
            cs.setTimestamp(2, report.getFine());
            cs.registerOutParameter(3, report.getUtentiPrevisti());
            cs.registerOutParameter(4, report.getUtentiEffettivi());

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Generazione del report fallita: " + e.getMessage());
        }

        return report;
    }
}

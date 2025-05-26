package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Report;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class GeneraReportDAO implements GenericProcedureDAO<Report> {

    @Override
    public Report execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per Generazione report. Attesi: 1");
        }
        Report report =  (Report) params[0];
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL ReportAccessi(?,?,?,?)}");

            cs.setTimestamp(1, report.getInizio());
            cs.setTimestamp(2, report.getFine());
            cs.registerOutParameter(3, java.sql.Types.INTEGER);
            cs.registerOutParameter(4, java.sql.Types.INTEGER);

            cs.execute();

            //dopo l'esecuzione prendi i valori calcolati
            report.setUtentiPrevisti(cs.getInt(3));
            report.setUtentiEffettivi(cs.getInt(4));
        } catch (SQLException e) {
            throw new DAOException("Generazione del report fallita: " + e.getMessage());
        }

        return report;
    }
}

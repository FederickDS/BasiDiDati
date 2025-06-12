package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Appuntamento;
import org.example.model.domain.Corso;

import java.sql.*;
import java.time.LocalDateTime;

public class ModificaAppuntamentoDAO implements GenericProcedureDAO<String>{
    @Override
    public String execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per InserisciCorso. Attesi: 1");
        }
        Appuntamento appuntamento = (Appuntamento) params[0];
        System.out.println("==== DEBUG: Parametri per modificaAppuntamento ====");
        System.out.println("CorsoID_old: " + appuntamento.getCorso());
        System.out.println("Inizio_old: " + appuntamento.getInizio());
        System.out.println("CorsoID_new: " + appuntamento.getCorso());
        System.out.println("Vasca_new: " + (appuntamento.getVasca() != null ? appuntamento.getVasca() : "NULL"));
        System.out.println("Inizio_new: " + appuntamento.getInizioNew());
        System.out.println("Fine_new: " + (appuntamento.getFine() != null ? appuntamento.getFine() : "NULL"));
        System.out.println("====================================================");
        Timestamp original;
        LocalDateTime truncated;
        if(appuntamento.getInizio()!=null){
            original = appuntamento.getInizio();
            truncated = original.toLocalDateTime()
                    .withSecond(0)
                    .withNano(0);
            appuntamento.setInizio(Timestamp.valueOf(truncated));
        }
        if(appuntamento.getFine()!=null){
            original = appuntamento.getFine();
            truncated = original.toLocalDateTime()
                    .withSecond(0)
                    .withNano(0);
            appuntamento.setFine(Timestamp.valueOf(truncated));
        }
        if(appuntamento.getInizioNew()!=null){
            original = appuntamento.getInizioNew();
            truncated = original.toLocalDateTime()
                    .withSecond(0)
                    .withNano(0);
            appuntamento.setInizioNew(Timestamp.valueOf(truncated));
        }
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL modificaAppuntamento(?,?,?,?,?,?)}");

            cs.setInt(1, appuntamento.getCorso());
            cs.setTimestamp(2, appuntamento.getInizio());
            cs.setInt(3, appuntamento.getCorso());
            if(appuntamento.getVasca() != null){
                cs.setString(4, appuntamento.getVasca());
            }else{
                cs.setNull(4, Types.VARCHAR);
            }
            if(appuntamento.getInizioNew() != null){
                cs.setTimestamp(5, appuntamento.getInizioNew());
            }else{
                cs.setTimestamp(5, appuntamento.getInizio());
            }
            if(appuntamento.getFine() != null){
                cs.setTimestamp(6, appuntamento.getFine());
            }else{
                cs.setNull(6, Types.TIMESTAMP);
            }

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Inserimento dell'appuntamento fallito: " + e.getMessage());
        }

        return "\nAppuntamento modificato con successo!\n";
    }

}

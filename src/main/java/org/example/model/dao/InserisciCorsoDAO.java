package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Corso;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class InserisciCorsoDAO implements GenericProcedureDAO {

    @Override
    public Object execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per InserisciCorso. Attesi: 1");
        }
        Corso corso = (Corso) params[0];
        try (Connection conn = ConnectionFactory.getConnection()) {
            CallableStatement cs = conn.prepareCall("{CALL aggiuntaCorso(?, ?, ?, ?, ?, ?, ?)}");

            cs.setInt(1, corso.getMinimo());            // p_minimo
            cs.setString(2, String.valueOf(corso.getStato()));          // p_stato (ENUM: 'C', 'P', 'A')
            cs.setString(3, corso.getNome());           // p_nome
            cs.setInt(4, corso.getCosto());             // p_costo
            cs.setTimestamp(5, corso.getDataInizio());  // p_data_inizio
            cs.setTimestamp(6, corso.getDataFine());    // p_data_fine
            cs.setInt(7, corso.getCapienza());          // p_capienza

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Inserimento del corso fallito: " + e.getMessage());
        }

        return "\nCorso inserito con successo!\n";
    }
}

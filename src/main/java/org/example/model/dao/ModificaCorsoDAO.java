package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Corso;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class ModificaCorsoDAO implements GenericProcedureDAO {

    @Override
    public Object execute(Object... params) throws DAOException, SQLException {
        if (params.length != 1) {
            throw new DAOException("Numero parametri errato per ModificaCorso. Attesi: 1");
        }
        Corso corso = (Corso) params[0];

        System.out.printf(
                "ID: %d, Minimo: %s, Stato: %s, Nome: %s, Costo: %s, Inizio: %s, Fine: %s, Capienza: %s\n",
                corso.getCorsoID(),
                corso.getMinimo(),
                corso.getStato(),
                corso.getNome(),
                corso.getCosto(),
                corso.getDataInizio(),
                corso.getDataFine(),
                corso.getCapienza()
        );

        try (Connection conn = ConnectionFactory.getConnection();
             CallableStatement cs = conn.prepareCall("{CALL modificaCorso(?, ?, ?, ?, ?, ?, ?, ?)}")) {

            cs.setInt(1, corso.getCorsoID());

            // Se il valore è null, setObject con il tipo JDBC; altrimenti setObject col valore
            if (corso.getMinimo() != null)
                cs.setInt(2, corso.getMinimo());
            else
                cs.setNull(2, Types.INTEGER);

            cs.setString(3, String.valueOf(corso.getStato()));

            if (corso.getNome() != null)      cs.setString(4, corso.getNome());
            else                               cs.setNull(  4, Types.VARCHAR);

            if (corso.getCosto() != null)
                cs.setInt(5, corso.getCosto());
            else
                cs.setNull(5, Types.INTEGER);

            if (corso.getDataInizio() != null)cs.setTimestamp(6, corso.getDataInizio());
            else                               cs.setNull(  6, Types.TIMESTAMP);

            if (corso.getDataFine() != null)  cs.setTimestamp(7, corso.getDataFine());
            else                               cs.setNull(  7, Types.TIMESTAMP);

            if (corso.getCapienza() != null)
                cs.setInt(8, corso.getCapienza());
            else
                cs.setNull(  8, Types.INTEGER);

            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("Modifica del corso fallita: " + e.getMessage(), e);
        }

        return "Corso modificato con successo!";
    }
}

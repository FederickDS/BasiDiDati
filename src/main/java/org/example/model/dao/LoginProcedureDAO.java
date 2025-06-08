package org.example.model.dao;

import org.example.exception.DAOException;
import org.example.model.domain.Credentials;
import org.example.model.domain.Role;

import java.sql.*;

public class LoginProcedureDAO implements GenericProcedureDAO<Credentials> {

    @Override
    public Credentials execute(Object... params) throws DAOException {
        String username = (String) params[0];
        String password = (String) params[1];
        int role;

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call login(?,?,?)}");
            cs.setString(1, username);
            cs.setString(2, password);
            cs.registerOutParameter(3, Types.NUMERIC);
            cs.executeQuery();
            role = cs.getInt(3);
        } catch(SQLException e) {
            throw new DAOException("Login error: " + e.getMessage());
        }
        System.out.println("ruolo: " + Role.fromInt(role));
        return new Credentials(username, password, Role.fromInt(role));
    }
}

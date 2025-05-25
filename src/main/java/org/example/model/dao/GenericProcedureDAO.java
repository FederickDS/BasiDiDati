package org.example.model.dao;

import org.example.exception.DAOException;

import java.sql.SQLException;

public interface GenericProcedureDAO<P> {

    P execute(Object... params) throws DAOException, SQLException;

}

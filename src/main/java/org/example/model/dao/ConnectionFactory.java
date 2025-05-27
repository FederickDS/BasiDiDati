package org.example.model.dao;

import org.example.model.domain.Role;

import java.io.*;
import java.sql.*;
import java.util.Properties;

public class ConnectionFactory {
    private static Connection connection;

    private ConnectionFactory() {}

    static {
        // Does not work if generating a jar file
        try (InputStream input = new FileInputStream("resources/db.properties")) {
            Properties properties = new Properties();
            properties.load(input);

            String connection_url = properties.getProperty("CONNECTION_URL");
            String user = properties.getProperty("LOGIN_USER");
            String pass = properties.getProperty("LOGIN_PASS");
            System.out.println(user + ":" + pass);
            connection = DriverManager.getConnection(connection_url, user, pass);
        } catch (IOException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            if (connection == null || connection.isClosed()) {
                reconnectAsDefault();
            }
        } catch (SQLException e) {
            throw new SQLException("Errore durante il controllo della connessione: " + e.getMessage());
        }
        return connection;
    }

    private static void reconnectAsDefault() throws SQLException {
        try (InputStream input = new FileInputStream("resources/db.properties")) {
            Properties properties = new Properties();
            properties.load(input);

            String connection_url = properties.getProperty("CONNECTION_URL");
            String user = properties.getProperty("LOGIN_USER");
            String pass = properties.getProperty("LOGIN_PASS");

            connection = DriverManager.getConnection(connection_url, user, pass);
        } catch (IOException e) {
            e.printStackTrace();
            throw new SQLException("Errore durante la lettura del file di configurazione");
        }
    }


    public static void changeRole(Role role) throws SQLException {
        connection.close();

        try (InputStream input = new FileInputStream("resources/db.properties")) {
            Properties properties = new Properties();
            properties.load(input);

            String connection_url = properties.getProperty("CONNECTION_URL");
            String user = properties.getProperty(role.name() + "_USER");
            String pass = properties.getProperty(role.name() + "_PASS");

            connection = DriverManager.getConnection(connection_url, user, pass);
        } catch (IOException | SQLException e) {
            e.printStackTrace();
        }
    }
}

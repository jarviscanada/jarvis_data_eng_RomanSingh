package ca.jrvs.apps.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnectManager {
    private final String url;
    private final Properties properties;

    public DatabaseConnectManager(String host, String databaseName, String username, String password){
        this.url = "jdbc:postgresql://"+host+"/"+databaseName;
        this.properties = new Properties();
        this.properties.setProperty("user", username);
        this.properties.setProperty("password", password);
    }

    /** create connection to our database */
    public Connection getConnection() throws SQLException{
        return DriverManager.getConnection(this.url, this.properties);
    }
}

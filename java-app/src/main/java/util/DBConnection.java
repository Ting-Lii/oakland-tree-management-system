package util;// ting li, April 4, 2025
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // ensure MySQL driver loads
            // set up the connection before you run!
            String url = ""; //please use your own
            String user = ""; //please use your own
            String password = ""; //please use your own
            return DriverManager.getConnection(url, user, password);

        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection Failed.");
            e.printStackTrace();
        }
        return null;
    }
}

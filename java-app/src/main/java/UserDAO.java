// ting li, April 4, 2025
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
// for standard and safety, we should use DAO here for database operations.
public class UserDAO {
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (firstName, lastName, email, password, zipCode, role, neighborhood) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword());// should we encrypt?
            stmt.setString(5, user.getZipCode());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getNeighborhood());


            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

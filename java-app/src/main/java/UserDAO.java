// ting li
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
// for standard and safety, we should use DAO here for database operations.
// we create CURD operations here.
public class UserDAO {
    public boolean isRegisterUser(User user) {
        String sql = "INSERT INTO users (firstName, lastName, email, password, zipCode, role, neighborhood) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword());
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

    public int getUserIdByEmail(String email) {
        String sql = "SELECT uid FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email); // plug in email (first place holder)
                var resRow = stmt.executeQuery();
                if (resRow.next()) {
                    return resRow.getInt("uid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean isValidLogin(String email, String password){
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            var resRow = stmt.executeQuery();
            return resRow.next(); // if there is a result, login is valid
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isAdmin(String email) {
        String sql = "SELECT role FROM users WHERE email = ? AND role = 'admin'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            var resRow = stmt.executeQuery();
            return resRow.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

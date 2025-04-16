import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class VolunteerDAO {
    public boolean applyVolunteer(int vid, String applicationStatus) {
        String sql = "INSERT INTO volunteers (vid, applicationStatus, isAvailable) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vid);
            stmt.setString(2, applicationStatus);
            stmt.setBoolean(3, true);  // assume new volunteers are available by default

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}


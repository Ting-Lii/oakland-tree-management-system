import java.sql.*;

// Name: Ting Li
public class PermitDAO {
    // Insert a new permit into the database
    public boolean canUploadPermit(String permitID, int rid, String status, Date issueDate) {
        String sql = "INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, permitID);
            stmt.setInt(2, rid);
            stmt.setString(3, status.toLowerCase()); // must be 'submitted', 'approved', or 'rejected'
            stmt.setDate(4, issueDate);
            int inserted = stmt.executeUpdate();
            return inserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // check if the resident has an approved permit
    public boolean isPermitApproved(int rid){
        String sql = "SELECT 1 FROM permits WHERE rid = ? AND permitStatus = 'approved' LIMIT 1";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, rid);
            ResultSet res = stmt.executeQuery();
            return res.next();

        } catch (SQLException e) {
            System.out.println("Error checking permit approval.");
            e.printStackTrace();
            return false;
        }
    }
}

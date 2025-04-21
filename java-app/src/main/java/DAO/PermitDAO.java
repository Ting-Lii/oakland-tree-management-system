package DAO;

import Model.Permit;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PermitDAO {

    // check if user has an approved permit
    public boolean hasApprovedPermit(int rid) {
        String sql = "SELECT * FROM permits WHERE rid = ? AND permitStatus = 'approved'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, rid);
            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            System.out.println("Error checking approved permit:");
            e.printStackTrace();
            return false;
        }
    }

    // upload a new permit (default uploaded permit by resident)
    public boolean uploadPermit(Permit permit) {
        String sql = "INSERT INTO permits (permitID, rid, permitStatus, issueDate) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, permit.getPermitID());
            stmt.setInt(2, permit.getRid());
            stmt.setString(3, permit.getPermitStatus());
            stmt.setDate(4, permit.getIssueDate());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.out.println("Error uploading permit:");
            e.printStackTrace();
            return false;
        }
    }
}

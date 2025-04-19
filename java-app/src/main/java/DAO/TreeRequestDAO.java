package DAO;

import Model.TreeRequest;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreeRequestDAO {

    // submit a tree request (default 'submitted')
    public boolean canSubmitTreeRequest(int rid, TreeRequest treeRequest) {
        String sql = "INSERT INTO treeRequests (rid, streetAddress, dateSubmitted, phone, amountOfPayment, relationshipToProperty, reqZipCode, requestStatus, neighborhood) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, rid);
            stmt.setString(2, treeRequest.getStreetAddress());
            stmt.setDate(3, treeRequest.getDateSubmitted());
            stmt.setString(4, treeRequest.getPhone());
            stmt.setFloat(5, treeRequest.getAmountOfPayment());
            stmt.setString(6, treeRequest.getRelationshipToProperty());
            stmt.setString(7, treeRequest.getReqZipCode());
            stmt.setString(8, "submitted");
            stmt.setString(9, treeRequest.getNeighborhood());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.out.println("Error while submitting tree request:");
            e.printStackTrace();
            return false;
        }
    }

    // see all submitted's tree request (admin view)
    public List<TreeRequest> getAllSubmittedTreeRequests() {
        List<TreeRequest> requests = new ArrayList<>();
        String sql = "SELECT requestID, streetAddress, reqZipCode, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, phone, neighborhood " +
                "FROM treeRequests WHERE requestStatus = 'submitted'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                TreeRequest tr = new TreeRequest(
                        rs.getInt("requestID"),
                        rs.getString("streetAddress"),
                        rs.getString("reqZipCode"),
                        rs.getFloat("amountOfPayment"),
                        rs.getString("relationshipToProperty"),
                        rs.getDate("dateSubmitted"),
                        rs.getString("requestStatus"),
                        rs.getString("phone"),
                        rs.getString("neighborhood")
                );
                requests.add(tr);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching submitted tree requests:");
            e.printStackTrace();
        }
        return requests;
    }


    public boolean updateTreeRequestStatus(int requestID, String status) {
        String update = "UPDATE treeRequests SET requestStatus = ? WHERE requestID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(update)) {

            stmt.setString(1, status);
            stmt.setInt(2, requestID);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error updating tree request status:");
            e.printStackTrace();
            return false;
        }
    }

}

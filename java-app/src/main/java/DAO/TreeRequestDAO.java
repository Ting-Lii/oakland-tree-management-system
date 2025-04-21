package DAO;

import Model.TreeRequest;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreeRequestDAO {

    /**
     * Retrieve all uncompleted tree requests, showing requestID, siteVisitStatus, and days since submitted.
     * Uncompleted = requestStatus = 'approved' AND photoAfter is NULL.
     */
    public void getAllUncompletedTreeRequestsAndDaysSinceSubmitted() {
        String sql = "SELECT tr.requestID, sv.visitStatus, " +
                "DATEDIFF(CURDATE(), tr.dateSubmitted) AS daysSinceSubmitted " +
                "FROM treeRequests tr " +
                "INNER JOIN siteVisits sv ON tr.requestID = sv.requestID " +
                "LEFT JOIN treePlantings tp ON tr.requestID = tp.requestID " +
                "WHERE tr.requestStatus = 'approved' " +
                "AND (tp.photoAfter IS NULL OR tp.photoAfter = '')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("===== Uncompleted Tree Requests (Including Days Since Submitted) =====");
            while (rs.next()) {
                int requestID = rs.getInt("requestID");
                String visitStatus = rs.getString("visitStatus");
                int daysSinceSubmitted = rs.getInt("daysSinceSubmitted");

                System.out.println("Request ID: " + requestID +
                        " | Visit Status: " + visitStatus +
                        " | Days Since Submitted: " + daysSinceSubmitted + " days");
            }
            System.out.println("======================================================================");

        } catch (SQLException e) {
            System.out.println("Error retrieving uncompleted tree requests and days since submitted:");
            e.printStackTrace();
        }
    }

    /**
     * Retrieve trees planted based on neighborhood name or zip code.
     * Join treeRequests, treePlantings, and treeSpecies.
     */
    public void seeTreesPlantedByNeighborhoodOrZipCode(String input, boolean isZipCode) {
        String sql;

        if (isZipCode) {
            sql = "SELECT tr.requestID, tr.streetAddress, tr.reqZipCode, ts.commonName, tp.plantDate " +
                    "FROM treeRequests tr " +
                    "INNER JOIN treePlantings tp ON tr.requestID = tp.requestID " +
                    "INNER JOIN treeSpecies ts ON tp.treePlanted = ts.treeID " +
                    "WHERE tr.reqZipCode = ?";
        } else {
            sql = "SELECT tr.requestID, tr.streetAddress, tr.neighborhood, ts.commonName, tp.plantDate " +
                    "FROM treeRequests tr " +
                    "INNER JOIN treePlantings tp ON tr.requestID = tp.requestID " +
                    "INNER JOIN treeSpecies ts ON tp.treePlanted = ts.treeID " +
                    "WHERE tr.neighborhood = ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, input);
            ResultSet rs = stmt.executeQuery();

            System.out.println("===== Trees Planted in Selected Area =====");
            boolean found = false;
            while (rs.next()) {
                found = true;
                int requestID = rs.getInt("requestID");
                String streetAddress = rs.getString("streetAddress");
                String commonName = rs.getString("commonName");
                java.sql.Date plantDate = rs.getDate("plantDate");

                System.out.println("Request ID: " + requestID +
                        " | Address: " + streetAddress +
                        " | Tree Species: " + commonName +
                        " | Plant Date: " + plantDate);
            }
            if (!found) {
                System.out.println("No trees planted found for your input.");
            }
            System.out.println("==========================================");

        } catch (SQLException e) {
            System.out.println("Error retrieving trees planted by area:");
            e.printStackTrace();
        }
    }

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

    // Fetch all approved tree requests (for admin update after site visit)
    public List<TreeRequest> getAllApprovedTreeRequests() {
        List<TreeRequest> requests = new ArrayList<>();
        String sql = "SELECT requestID, streetAddress, reqZipCode, amountOfPayment, relationshipToProperty, dateSubmitted, requestStatus, phone, neighborhood " +
                "FROM treeRequests WHERE requestStatus = 'approved'";

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
            System.out.println("Error fetching approved tree requests:");
            e.printStackTrace();
        }
        return requests;
    }

    // Fetch all tree requests (for admin to review or delete)
    public List<TreeRequest> getAllTreeRequests() {
        List<TreeRequest> requests = new ArrayList<>();
        String sql = "SELECT requestID, streetAddress, reqZipCode, amountOfPayment, " +
                "relationshipToProperty, dateSubmitted, requestStatus, phone, neighborhood " +
                "FROM treeRequests";

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
            System.out.println("Error fetching approved tree requests:");
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

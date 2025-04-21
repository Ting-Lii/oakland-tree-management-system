package DAO;

import util.DBConnection;

import java.sql.*;
import java.util.Arrays;
import java.util.List;

public class VolunteerDAO {

    // volunteer login check
    public boolean canVolunteerLogin(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND role = 'volunteer'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet res = stmt.executeQuery();
            return res.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // check if volunteer is assigned to the request
    public boolean canFillTreePlanting(int requestID) {
        String sql = "SELECT * FROM volunteerPlants WHERE requestID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestID);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // volunteer update photoAfter attribute in treePlantings table
    public boolean canUpdatePhotoAfter(int requestID, String photoAfter) {
        String sql = "UPDATE treePlantings SET photoAfter = ? WHERE requestID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, photoAfter);
            stmt.setInt(2, requestID);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error updating photoAfter in treePlantings:");
            e.printStackTrace();
            return false;
        }
    }


    // volunteer fill in planting info
    public boolean canUpdateVolunteerPlant(int requestID, float workHour, String workloadFeedback) {
        List<String> validFeedbacks = Arrays.asList("light", "moderate", "heavy", "overload");
        if (!validFeedbacks.contains(workloadFeedback.toLowerCase())) {
            System.out.println("Invalid workload feedback. Must be one of: " + validFeedbacks);
            return false;
        }

        String sql = "UPDATE volunteerPlants SET workHour = ?, workloadFeedback = ? WHERE requestID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setFloat(1, workHour);
            stmt.setString(2, workloadFeedback.toLowerCase());
            stmt.setInt(3, requestID);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error updating volunteer planting info:");
            e.printStackTrace();
            return false;
        }
    }

    // get treeID from requestID
    public int getTreeIDByRequestID(int requestID) {
        String sql = "SELECT treePlanted FROM treePlantings WHERE requestID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("treePlanted");
            }
            return -1; // not found
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    // apply as volunteer
    public boolean canApplyVolunteer(int vid) {
        String sql = "INSERT INTO volunteers (vid, applicationStatus, isAvailable) VALUES (?, 'submitted', TRUE)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vid);
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.out.println("Error applying as volunteer:");
            e.printStackTrace();
            return false;
        }
    }

    // ========= unused  method after refactor========
    // see assigned tree tasks
    public void seeTreeRequestAndTreePlantingAndTreeSpecies(int vid) {
        String sql = "SELECT tr.streetAddress, tr.phone, tp.plantDate, ts.commonName, vp.requestID " +
                "FROM volunteerPlants vp " +
                "LEFT JOIN treePlantings tp ON tp.requestID = vp.requestID " +
                "INNER JOIN treeRequests tr ON tr.requestID = tp.requestID " +
                "INNER JOIN siteVisits sv ON sv.requestID = tr.requestID " +
                "INNER JOIN recommendedTrees rt ON rt.requestID = sv.requestID " +
                "INNER JOIN treeSpecies ts ON ts.treeID = rt.treeID " +
                "WHERE vp.vid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vid);
            ResultSet rs = stmt.executeQuery();

            System.out.println("===== Your Assigned Tree Tasks =====");
            while (rs.next()) {
                String address = rs.getString("streetAddress");
                String phone = rs.getString("phone");
                Date plantDate = rs.getDate("plantDate");
                String commonName = rs.getString("commonName");

                System.out.println("Address: " + address);
                System.out.println("Contact Phone: " + phone);
                System.out.println("Plant Date: " + plantDate);
                System.out.println("Tree Species: " + commonName);
                System.out.println("==================================");
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving tree request and planting info.");
            e.printStackTrace();
        }
    }

    // volunteer update availability
    public boolean updateVolunteerAvailability(int vid, boolean isAvailable) {
        String sql = "UPDATE volunteers SET isAvailable = ? WHERE vid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isAvailable);
            stmt.setInt(2, vid);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

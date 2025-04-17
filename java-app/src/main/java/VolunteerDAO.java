// VolunteerDAO.java

import java.sql.*;
import java.util.ArrayList;
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


    // get all assigned tree requests and plantings infor for the volunteer
    // suppose the volunteer should see the address, phone number, plant date, and tree common name
    public void seeTreeRequestAndTreePlantingAndTreeSpecies(int vid) {

        String sql = "SELECT tr.address, tr.phone, tp.plantDate, ts.commonName, vp.requestID " +
                "FROM volunteerPlants vp " +
                "JOIN treePlantings tp ON tp.plantID = vp.plantID " +
                "JOIN treeRequests tr ON tr.requestID = tp.requestID " +
                "JOIN siteVisits sv ON sv.requestNum = tr.requestID " +
                "JOIN recommendedTrees rt ON rt.visitID = sv.siteVisitID " +
                "JOIN treeSpecies ts ON ts.treeID = rt.treeID " +
                "WHERE vp.vid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, vid);
            ResultSet rs = stmt.executeQuery();

            System.out.println("===== Your Assigned Tree Tasks =====");
            while (rs.next()) {
                String address = rs.getString("address");
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

    // volunteer fill in planting info, the accroding tree species.inventory -= 1,
    // volunteerPlants vp Inner join treePlantings ON vp.requestID = tp.requestID INNER JOIN treeSpecies ts ON ts.treeID = tp.treeID, update ts.inventory -= 1
    // notice workload feedback: four options only: heavy, light, moderate, overload
    public boolean updateVolunteerPlant(int requestID, int vid, float workHour, String workloadFeedback) {
        List<String> validFeedbacks = Arrays.asList("light", "moderate", "heavy", "overload");
        if (!validFeedbacks.contains(workloadFeedback.toLowerCase())) {
            System.out.println("Invalid workload feedback. Must be one of: " + validFeedbacks);
            return false;
        }

        String sql = "INSERT INTO volunteerPlants (requestID, vid, workHour, workloadFeedback) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestID);
            stmt.setInt(2, vid);
            stmt.setFloat(3, workHour);
            stmt.setString(4, workloadFeedback.toLowerCase());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error inserting into volunteerPlants:");
            e.printStackTrace();
            return false;
        }
    }



    // volunteer update their availability
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


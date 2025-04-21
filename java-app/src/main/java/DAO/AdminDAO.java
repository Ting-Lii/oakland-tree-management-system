package DAO;

import util.DBConnection;

import java.sql.*;
import java.util.Scanner;

public class AdminDAO {

    /**
     * verify admin login by checking if user exists and has admin privilege.
     */
    public boolean isValidAdminLogin(String email, String password) {
        UserDAO userDAO = new UserDAO();
        return userDAO.isValidLogin(email, password) && userDAO.isAdmin(email);
    }

    /**
     * Review volunteer applications (submitted status).
     * Admin can approve or reject.
     */
    public void reviewVolunteerApplications(Scanner scanner) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = getPendingVolunteersStatement(conn);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int vid = rs.getInt("vid");
                String name = rs.getString("firstName") + " " + rs.getString("lastName");
                String email = rs.getString("email");

                System.out.println("Reviewing Volunteer: " + vid + " - " + name + " (" + email + ")");
                System.out.println("Enter 'a' to Approve, 'r' to Reject:");
                String decision = scanner.nextLine().trim().toLowerCase();

                if (decision.equals("a") || decision.equals("r")) {
                    String status = decision.equals("a") ? "approved" : "rejected";
                    updateVolunteerStatus(conn, vid, status);
                    System.out.println("Volunteer " + vid + " has been " + status + ".");
                } else {
                    System.out.println("Skipped Volunteer " + vid + ".");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Review submitted tree requests.
     * Admin can approve or reject.
     */
    public void reviewTreeRequests(Scanner scanner) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = getSubmittedTreeRequestsStatement(conn);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int requestID = rs.getInt("unassignedTreeRequestID");
                String resident = rs.getString("firstName") + " " + rs.getString("lastName");
                String address = rs.getString("streetAddress");
                String neighborhood = rs.getString("neighborhood");

                System.out.println("Tree Request ID: " + requestID);
                System.out.println("Resident: " + resident + " | Address: " + address + " | Neighborhood: " + neighborhood);
                System.out.println("Approve (a), Reject (r), or Skip (s)?");
                String decision = scanner.nextLine().trim().toLowerCase();

                if (decision.equals("a") || decision.equals("r")) {
                    String status = decision.equals("a") ? "approved" : "rejected";
                    updateTreeRequestStatus(conn, requestID, status);
                    System.out.println("Tree Request " + requestID + " updated to: " + status);
                } else {
                    System.out.println("Skipped Tree Request " + requestID + ".");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Schedule a site visit by updating date and status.
     */
    public void scheduleSiteVisit(int requestID, int adminID) {
        // Ask for site visit date
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter site visit date (YYYY-MM-DD):");
        String dateStr = scanner.nextLine();
        Date siteVisitDate = Date.valueOf(dateStr);

        // Update database
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE siteVisits SET aid = ?, siteVisitDate = ?, visitStatus = 'scheduled' WHERE requestID = ?")) {

            stmt.setInt(1, adminID);
            stmt.setDate(2, siteVisitDate);
            stmt.setInt(3, requestID);
            stmt.executeUpdate();
            System.out.println("Site visit scheduled successfully for Request ID: " + requestID);
        } catch (SQLException e) {
            System.out.println("Error scheduling site visit:");
            e.printStackTrace();
        }
    }


    // Complete basic site visit information
    public void completeSiteVisitInfo(Scanner scanner, int requestID, int adminID) {
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("Enter actual site visit date (YYYY-MM-DD):");
            Date siteVisitDate = Date.valueOf(scanner.nextLine());

            System.out.println("Is it under a powerline? (true/false):");
            boolean isUnderPowerLine = Boolean.parseBoolean(scanner.nextLine());

            System.out.println("Enter minimum bed width (in inches):");
            int minBedWidth = Integer.parseInt(scanner.nextLine());

            System.out.println("Enter the photo link:");
            String photoBefore = scanner.nextLine();

            String sql = "UPDATE siteVisits SET siteVisitDate = ?, aid = ?, visitStatus = 'completed', " +
                    "isUnderPowerLine = ?, minBedWidth = ?, photoBefore = ? WHERE requestID = ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setDate(1, siteVisitDate);
                stmt.setInt(2, adminID);
                stmt.setBoolean(3, isUnderPowerLine);
                stmt.setInt(4, minBedWidth);
                stmt.setString(5, photoBefore);
                stmt.setInt(6, requestID);
                stmt.executeUpdate();
            }
            System.out.println("Site visit info completed for Request ID: " + requestID);
        } catch (SQLException e) {
            System.out.println("Error completing site visit info:");
            e.printStackTrace();
        }
    }

    // recommend one tree species
    public void recommendOneTree(Scanner scanner, int requestID) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO recommendedTrees (requestID, treeID) VALUES (?, ?)");) {

            System.out.println("Enter tree species ID to recommend:");
            int treeID = Integer.parseInt(scanner.nextLine());

            stmt.setInt(1, requestID);
            stmt.setInt(2, treeID);
            stmt.executeUpdate();
            System.out.println("Recommended tree ID " + treeID + " added.");

        } catch (SQLException e) {
            System.out.println("Error recommending tree:");
            e.printStackTrace();
        }
    }

    /**
     * Create a tree planting record after site visit completion.
     */
    public void createTreePlanting(Scanner scanner, int requestID, int adminID) {
        try (Connection conn = DBConnection.getConnection()) {

            System.out.println("Enter tree species ID to plant (or 'q' to quit):");
            String input = scanner.nextLine().trim();
            if (input.equalsIgnoreCase("q")) {
                System.out.println("Canceled creating tree planting for Request ID: " + requestID);
                return;
            }

            int treeID;
            try {
                treeID = Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Invalid tree ID format. Cancel planting operation.");
                return;
            }

            System.out.println("Enter planned planting date (YYYY-MM-DD):");
            String plantDateStr = scanner.nextLine();
            Date plantDate = Date.valueOf(plantDateStr);

            String insertSQL = "INSERT INTO treePlantings (requestID, plantDate, aid, treePlanted) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertSQL)) {
                stmt.setInt(1, requestID);
                stmt.setDate(2, plantDate);
                stmt.setInt(3, adminID);
                stmt.setInt(4, treeID);
                stmt.executeUpdate();
            }

            System.out.println("Tree planting record created successfully for Request ID: " + requestID);

        } catch (SQLException e) {
            System.out.println("Error creating tree planting record:");
            e.printStackTrace();
        }
    }


    // Assign volunteer to planting
    public void assignVolunteer(Scanner scanner, int requestID) {
        try (Connection conn = DBConnection.getConnection()) {

            System.out.println("Now enter volunteer ID to assign:");
            int volunteerID = Integer.parseInt(scanner.nextLine());

            // Insert volunteer assignment
            String insertSQL = "INSERT INTO volunteerPlants (requestID, vid, workHour, workloadFeedback) VALUES (?, ?, NULL, NULL)";
            try (PreparedStatement stmt = conn.prepareStatement(insertSQL)) {
                stmt.setInt(1, requestID);
                stmt.setInt(2, volunteerID);
                stmt.executeUpdate();
            }

            // Update volunteer availability
            String updateSQL = "UPDATE volunteers SET isAvailable = FALSE WHERE vid = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateSQL)) {
                stmt.setInt(1, volunteerID);
                stmt.executeUpdate();
            }

            System.out.println("Volunteer " + volunteerID + " assigned to Request ID: " + requestID);

        } catch (SQLException e) {
            System.out.println("Error assigning volunteer:");
            e.printStackTrace();
        }
    }

    public void deleteTreeRequest(int requestID) {
        try (Connection conn = DBConnection.getConnection()){
            CallableStatement stmt = conn.prepareCall("{ call delete_a_treeRequest(?, ?) }");

            // set the input
            stmt.setInt(1, requestID);
            // register the output parameter
            stmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            // execute the stored procedure
            stmt.execute();
            // get the return status message
            String status = stmt.getString(2);
            System.out.println("Status: " + status);

            stmt.close();

        } catch (SQLException e) {
            System.out.println("Error deleting tree request:");
            e.printStackTrace();
        }
    }

    // --- Helper Methods Below ---

    private PreparedStatement getPendingVolunteersStatement(Connection conn) throws SQLException {
        return conn.prepareStatement("SELECT v.vid, u.firstName, u.lastName, u.email FROM volunteers v INNER JOIN users u ON v.vid = u.uid WHERE v.applicationStatus = 'submitted'");
    }

    private PreparedStatement getSubmittedTreeRequestsStatement(Connection conn) throws SQLException {
        return conn.prepareStatement("SELECT tr.requestID AS unassignedTreeRequestID, u.firstName, u.lastName, tr.streetAddress, tr.neighborhood, tr.requestStatus FROM treeRequests tr INNER JOIN users u ON tr.rid = u.uid WHERE tr.requestStatus = 'submitted'");
    }

    private void updateVolunteerStatus(Connection conn, int vid, String newStatus) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement("UPDATE volunteers SET applicationStatus = ? WHERE vid = ?")) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, vid);
            stmt.executeUpdate();
        }
    }

    private void updateTreeRequestStatus(Connection conn, int requestID, String status) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement("UPDATE treeRequests SET requestStatus = ? WHERE requestID = ?")) {
            stmt.setString(1, status);
            stmt.setInt(2, requestID);
            stmt.executeUpdate();
        }
    }
}

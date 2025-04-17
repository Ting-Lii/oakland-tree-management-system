// Ting
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * AdminDAO handles all admin-specific tasks including reviewing volunteers, tree requests,
 * and assigning volunteers for site visits.
 */
public class AdminDAO {
    public boolean isValidAdminLogin(String email, String password) {
        UserDAO userDAO = new UserDAO();
        return userDAO.isValidLogin(email, password) && userDAO.isAdmin(email);
    }

    // show all submitted volunteer applications, and ask admin to approve or reject, 'q' to quit.
    public void reviewVolunteerApplications(Scanner scanner) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = getPendingVolunteersStatement(conn);
            ResultSet res = stmt.executeQuery();
            // for simplicity, we assume the admin will review all applications in one go
            while (res.next()) {
                int vid = res.getInt("vid");
                String vName = res.getString("firstName") + " " + res.getString("lastName");
                String vEmail = res.getString("email");

                System.out.println("Reviewing: " + vid + " - " + vName + " (" + vEmail + ")");
                // add skip option
                System.out.println("Enter Decision Approve (a) or Reject (r)?");
                String decision = scanner.nextLine();

                String newStatus = decision.equalsIgnoreCase("a") ? "approved" : "rejected";
                updateVolunteerStatus(conn, vid, newStatus);

                System.out.println("Application for " + vName + " has been " + newStatus + ".");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void reviewTreeRequests(Scanner scanner) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = getSubmittedTreeRequestsStatement(conn);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int reqID = rs.getInt("unassignedTreeRequestID"); //alias
                String name = rs.getString("firstName") + " " + rs.getString("lastName");
                String addr = rs.getString("streetAddress");
                String status = rs.getString("requestStatus");
                String nhood = rs.getString("neighborhood");

                System.out.println("Tree Request ID: " + reqID);
                System.out.println("Resident: " + name + " | Address: " + addr + " | Neighborhood: " + nhood);
                System.out.println("Current Status: " + status);
                System.out.println("Approve (a), Reject (r), or Skip (s)?");
                String input = scanner.nextLine();

                if (input.equalsIgnoreCase("a") || input.equalsIgnoreCase("r")) {
                    String newStatus = input.equalsIgnoreCase("a") ? "approved" : "rejected";
                    updateTreeRequestStatus(conn, reqID, newStatus);
                    System.out.println("Tree request " + reqID + " updated to: " + newStatus);
                    System.out.println();
                } else {
                    System.out.println("Skipped tree request " + reqID + ".");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // update sitevisits table. for the entered requestID, update aid (adminID which no need to enter), siteVisiteDate, visitStatus change to
// completed, isUnderPowerline, minBedWidth, photoBefore.
    public boolean updateSiteVisit(Scanner scanner, int adminID) {
        // subCmd1. schedule a site visit, which only update the chosen requestID's siteVisitDate and visitStatus to be 'scheduled'.
        // subCmd2. update the site visit information, which update the chosen requestID's siteVisitDate, visitStatus to be 'completed', isUnderPowerline, minBedWidth, photoBefore.
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("Enter the request ID you want to update site visit for:");
            int requestID = Integer.parseInt(scanner.nextLine());

            System.out.println("Enter '1' to schedule site visit, '2' to complete site visit:");
            String subCmd = scanner.nextLine().trim();

            if (subCmd.equals("1")) {
                // Only schedule: update siteVisitDate + set visitStatus to 'scheduled'
                System.out.println("Enter site visit date (YYYY-MM-DD) to schedule:");
                String visitDateStr = scanner.nextLine();
                Date visitDate = Date.valueOf(visitDateStr);

                String updateSQL = "UPDATE siteVisits SET aid = ?, siteVisitDate = ?, visitStatus = 'scheduled' WHERE requestID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateSQL)) {
                    stmt.setInt(1, adminID);
                    stmt.setDate(2, visitDate);
                    stmt.setInt(3, requestID);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        System.out.println("Site visit scheduled successfully for Request ID: " + requestID);
                        return true;
                    } else {
                        System.out.println("No matching tree request found for Request ID: " + requestID);
                        return false;
                    }
                }

            } else if (subCmd.equals("2")) {
                // Complete visit: update siteVisitDate + visitStatus + other info
                System.out.println("Enter actual site visit date (YYYY-MM-DD):");
                String visitDateStr = scanner.nextLine();
                Date visitDate = Date.valueOf(visitDateStr);

                System.out.println("Is it under a powerline? (true/false):");
                boolean isUnderPowerLine = Boolean.parseBoolean(scanner.nextLine());

                System.out.println("Enter minimum bed width (in inches):");
                int minBedWidth = Integer.parseInt(scanner.nextLine());

                System.out.println("Enter the photo link of onsite (e.g., https://picsum.photos/seed/oaklandstreet/600/400):");
                String photoBefore = scanner.nextLine();

                String updateSQL = "UPDATE siteVisits " +
                        "SET aid = ?, siteVisitDate = ?, visitStatus = 'completed', " +
                        "isUnderPowerLine = ?, minBedWidth = ?, photoBefore = ? " +
                        "WHERE requestID = ?";

                try (PreparedStatement stmt = conn.prepareStatement(updateSQL)) {
                    stmt.setInt(1, adminID);
                    stmt.setDate(2, visitDate);
                    stmt.setBoolean(3, isUnderPowerLine);
                    stmt.setInt(4, minBedWidth);
                    stmt.setString(5, photoBefore);
                    stmt.setInt(6, requestID);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        System.out.println("Site visit information completed successfully for Request ID: " + requestID);
                        return true;
                    } else {
                        System.out.println("No matching tree request found for Request ID: " + requestID);
                        return false;
                    }
                }
            } else {
                System.out.println("Invalid input. Must be '1' (schedule) or '2' (complete).");
                return false;
            }

        } catch (SQLException e) {
            System.out.println("Error updating site visit:");
            e.printStackTrace();
            return false;
        }
    }



    // Assign an available volunteer to a specific tree request
// This method assumes the admin has already completed the site visit.
    public void assignVolunteerToRequest(Scanner scanner) {
        try (Connection conn = DBConnection.getConnection()) {
            // Step 1: Show all available volunteers
            List<Integer> availableVolunteers = getAvailableVolunteerIDs(conn);
            if (availableVolunteers.isEmpty()) {
                System.out.println("No available volunteers at the moment.");
                return;
            }

            System.out.println("Available Volunteers:");
            for (int volID : availableVolunteers) {
                System.out.println("- Volunteer ID: " + volID);
            }

            // Step 2: Admin selects a volunteer
            System.out.println("Enter the Volunteer ID you want to assign:");
            int volunteerID = Integer.parseInt(scanner.nextLine());

            if (!availableVolunteers.contains(volunteerID)) {
                System.out.println("Invalid Volunteer ID selection.");
                return;
            }

            // Step 3: Admin selects a tree request
            System.out.println("Enter the Tree Request ID you want to assign this volunteer to:");
            int requestID = Integer.parseInt(scanner.nextLine());

            // Step 4: Insert into volunteerPlants (with NULL workHour and workloadFeedback)
            String insert = "INSERT INTO volunteerPlants (requestID, vid, workHour, workloadFeedback) VALUES (?, ?, NULL, NULL)";
            try (PreparedStatement stmt = conn.prepareStatement(insert)) {
                stmt.setInt(1, requestID);
                stmt.setInt(2, volunteerID);
                stmt.executeUpdate();
                System.out.println("Volunteer " + volunteerID + " assigned to tree request " + requestID + ".");
            }

            // Step 5: Set the volunteer to unavailable
            String updateVol = "UPDATE volunteers SET isAvailable = FALSE WHERE vid = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateVol)) {
                stmt.setInt(1, volunteerID);
                stmt.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("Error assigning volunteer to tree request:");
            e.printStackTrace();
        }
    }




    // ======== Helper methods for above methods=========
    // helper for reviewVolunteerApplications
    private PreparedStatement getPendingVolunteersStatement(Connection conn) throws SQLException {
        String query = "SELECT v.vid, u.firstName, u.lastName, u.email " +
                "FROM volunteers v INNER JOIN users u ON v.vid = u.uid " +
                "WHERE v.applicationStatus = 'submitted'";
        return conn.prepareStatement(query);
    }

    private void updateVolunteerStatus(Connection conn, int vid, String newStatus) throws SQLException {
        String update = "UPDATE volunteers SET applicationStatus = ? WHERE vid = ?";
        try (PreparedStatement stmt = conn.prepareStatement(update)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, vid);
            stmt.executeUpdate();
        }
    }
    // helper for reviewTreeRequests
    private PreparedStatement getSubmittedTreeRequestsStatement(Connection conn) throws SQLException {
        String query = "SELECT tr.requestID AS unassignedTreeRequestID, u.firstName, u.lastName, tr.streetAddress, tr.dateSubmitted, tr.neighborhood, tr.requestStatus " +
                "FROM treeRequests tr INNER JOIN users u ON tr.rid = u.uid " +
                "WHERE tr.requestStatus = 'submitted'";
        return conn.prepareStatement(query);
    }

    private void updateTreeRequestStatus(Connection conn, int requestID, String status) throws SQLException {
        String update = "UPDATE treeRequests SET requestStatus = ? WHERE requestID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(update)) {
            stmt.setString(1, status);
            stmt.setInt(2, requestID);
            stmt.executeUpdate();
        }
    }

    // Helper method: Get a list of all available volunteer IDs
    private List<Integer> getAvailableVolunteerIDs(Connection conn) throws SQLException {
        List<Integer> volunteerIDs = new ArrayList<>();
        String sql = "SELECT vid FROM volunteers WHERE isAvailable = TRUE";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                volunteerIDs.add(rs.getInt("vid"));
            }
        }
        return volunteerIDs;
    }

//     helper for assignVolunteerToRequest
//     update volunteerPlants table.
//      workloadFeedback is set to NULL for volunteer to update later
    private void assignVolunteer(Connection conn, int requestID, int volunteerID) throws SQLException {
        String insert = "INSERT INTO volunteerPlants (requestID, vid, workHour, workloadFeedback) VALUES (?, ?, ?, NULL)";
        try (PreparedStatement stmt = conn.prepareStatement(insert)) {
            stmt.setInt(1, requestID);
            stmt.setInt(2, volunteerID);
            stmt.setFloat(3, 0.0f);  // default set 0.0
            stmt.executeUpdate();
        }
    }



    private void markVolunteerUnavailable(Connection conn, int volunteerID) throws SQLException {
        String update = "UPDATE volunteers SET isAvailable = FALSE WHERE vid = ?";
        try (PreparedStatement stmt = conn.prepareStatement(update)) {
            stmt.setInt(1, volunteerID);
            stmt.executeUpdate();
        }
    }
}

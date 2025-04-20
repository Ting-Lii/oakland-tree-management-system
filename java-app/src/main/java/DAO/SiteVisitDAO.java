package DAO;

import Model.SiteVisit;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SiteVisitDAO {

    // Insert or update a scheduled SiteVisit (set to 'scheduled')
    public boolean scheduleSiteVisit(int requestID, int adminID, Date siteVisitDate) {
        String sql = "UPDATE siteVisits SET aid = ?, siteVisitDate = ?, visitStatus = 'scheduled' WHERE requestID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, adminID);
            stmt.setDate(2, siteVisitDate);
            stmt.setInt(3, requestID);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error while scheduling site visit:");
            e.printStackTrace();
            return false;
        }
    }

    // Insert an initial site visit record after tree request approved
    public boolean insertInitialSiteVisit(int requestID, int adminID) {
        String sql = "INSERT INTO siteVisits (requestID, aid, siteVisitDate, visitStatus) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestID);
            stmt.setInt(2, adminID);
            stmt.setDate(3, new java.sql.Date(System.currentTimeMillis())); // 默认今天
            stmt.setString(4, "submitted"); //initilize status

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.out.println("Error inserting initial site visit:");
            e.printStackTrace();
            return false;
        }
    }

    // show all site visits for a specific admin
    public void getAllAdminSiteVisits(int adminID) {
        String sql = "SELECT requestID, siteVisitDate, visitStatus FROM siteVisits WHERE aid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, adminID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int requestID = rs.getInt("requestID");
                    Date siteVisitDate = rs.getDate("siteVisitDate");
                    String visitStatus = rs.getString("visitStatus");

                    System.out.println("Request ID: " + requestID +
                            " | Visit Status: " + visitStatus +
                            " | Visit Date: " + siteVisitDate);
                }
            }

        } catch (SQLException e) {
            System.out.println("Error fetching admin's site visits:");
            e.printStackTrace();
        }
    }


}

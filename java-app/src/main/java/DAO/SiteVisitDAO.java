package DAO;

import Model.SiteVisit;
import util.DBConnection;

import java.sql.*;

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

    // Complete a SiteVisit (after real visit)
    public boolean completeSiteVisit(SiteVisit siteVisit) {
        String sql = "UPDATE siteVisits SET aid = ?, siteVisitDate = ?, visitStatus = ?, isUnderPowerLine = ?, minBedWidth = ?, photoBefore = ? WHERE requestID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, siteVisit.getAid());
            stmt.setDate(2, siteVisit.getSiteVisitDate());
            stmt.setString(3, siteVisit.getVisitStatus());
            stmt.setBoolean(4, siteVisit.isUnderPowerLine());
            stmt.setInt(5, siteVisit.getMinBedWidth());
            stmt.setString(6, siteVisit.getPhotoBefore());
            stmt.setInt(7, siteVisit.getRequestID());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error while completing site visit:");
            e.printStackTrace();
            return false;
        }
    }
}

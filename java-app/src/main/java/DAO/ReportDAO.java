package DAO;

import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReportDAO {

    /**
     * report 1: Highest total work hour district, for neighborhoods with >1 trees planted.
     */
    public void getVolunteerWorkloadReportByDistrict() {
        String sql = "SELECT tr.neighborhood,\n" +
                "       ROUND(AVG(vp.workHour), 2) AS AverageWorkingHour,\n" +
                "       COUNT(DISTINCT tp.requestID) AS treePlantedCount,\n" +
                "       SUM(CASE WHEN vp.workloadFeedback = 'overload' THEN 1 ELSE 0 END) AS OverloadCount,\n" +
                "       ROUND(SUM(CASE WHEN vp.workloadFeedback = 'overload' THEN 1 ELSE 0 END) / COUNT(*), 2) AS OverloadRate\n" +
                "FROM volunteerPlants vp \n" +
                "INNER JOIN treePlantings tp ON vp.requestID = tp.requestID\n" +
                "INNER JOIN treeRequests tr ON tr.requestID = tp.requestID\n" +
                "INNER JOIN neighborhoods n ON tr.neighborhood = n.name\n" +
                "WHERE n.district = (\n" +
                "    SELECT n2.district\n" +
                "    FROM neighborhoods n2\n" +
                "    INNER JOIN treeRequests tr2 ON tr2.neighborhood = n2.name\n" +
                "    INNER JOIN treePlantings tp2 ON tr2.requestID = tp2.requestID\n" +
                "    INNER JOIN volunteerPlants vp2 ON vp2.requestID = tp2.requestID\n" +
                "    GROUP BY n2.district\n" +
                "    ORDER BY SUM(vp2.workHour) DESC\n" +
                "    LIMIT 1\n" +
                ")\n" +
                "GROUP BY tr.neighborhood\n" +
                "HAVING COUNT(DISTINCT tp.requestID) > 1;";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("===== Volunteer Workload Report =====");
            while (rs.next()) {
                String neighborhood = rs.getString("neighborhood");
                double avgHour = rs.getDouble("AverageWorkingHour");
                int treeCount = rs.getInt("treePlantedCount");
                int overloadCount = rs.getInt("OverloadCount");
                double overloadRate = rs.getDouble("OverloadRate");

                System.out.println("Neighborhood: " + neighborhood);
                System.out.println("Avg Work Hour: " + avgHour);
                System.out.println("Trees Planted: " + treeCount);
                System.out.println("Overload Volunteers: " + overloadCount);
                System.out.println("Overload Rate: " + overloadRate);
                System.out.println("---------------------------------------");
            }

        } catch (SQLException e) {
            System.out.println("Error generating Volunteer Workload Report:");
            e.printStackTrace();
        }
    }

    /**
     * Report 2: Find the most recommended tree species per neighborhood.
     */
    public void getMostRecommendedTreePerNeighborhood() {
        String sql = "SELECT n.name AS neighborhood, t2.commonName AS mostRecommendedTree\n" +
                "FROM recommendedTrees rt2\n" +
                "INNER JOIN treeSpecies t2 ON rt2.treeID = t2.treeID\n" +
                "INNER JOIN siteVisits sv2 ON rt2.requestID = sv2.requestID\n" +
                "INNER JOIN treeRequests tr2 ON tr2.requestID = sv2.requestID\n" +
                "INNER JOIN neighborhoods n ON n.name = tr2.neighborhood\n" +
                "GROUP BY n.name, t2.commonName\n" +
                "HAVING COUNT(*) = (\n" +
                "    SELECT MAX(tree_count)\n" +
                "    FROM (\n" +
                "        SELECT rt3.treeID, COUNT(*) AS tree_count\n" +
                "        FROM recommendedTrees rt3\n" +
                "        INNER JOIN siteVisits sv3 ON rt3.requestID = sv3.requestID\n" +
                "        INNER JOIN treeRequests tr3 ON tr3.requestID = sv3.requestID\n" +
                "        INNER JOIN neighborhoods n2 ON tr3.neighborhood = n2.name\n" +
                "        WHERE n2.name = n.name\n" +
                "        GROUP BY rt3.treeID\n" +
                "    ) AS subquery\n" +
                ")\n" +
                "ORDER BY n.name;";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("===== Most Recommended Trees by Neighborhood =====");
            while (rs.next()) {
                String neighborhood = rs.getString("neighborhood");
                String treeName = rs.getString("mostRecommendedTree");

                System.out.println("Neighborhood: " + neighborhood + " | Most Recommended Tree: " + treeName);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving Most Recommended Trees:");
            e.printStackTrace();
        }
    }


    /**
     * Report 3: Find drought-tolerant trees never requested in tree planted happened neighborhoods.
     */
    /**
     * Find drought-tolerant trees (suitable for harsh sites) that were recommended but never planted
     * in any neighborhood between the specified start year and end year.
     *
     * @param startYear Starting year (inclusive)
     * @param endYear Ending year (inclusive)
     */
    public void getDroughtTolerantTreesNotPlantedInNeighborhood(int startYear, int endYear) {
        String sql = "SELECT ts.commonName AS treeCommonName, n.name AS neighborhood " +
                "FROM treeSpecies ts " +
                "INNER JOIN treeToPlantingZones ttpz ON ts.treeID = ttpz.treeID " +
                "INNER JOIN plantingZoneFactors pzf ON ttpz.plantingZoneFactor = pzf.factor " +
                "INNER JOIN recommendedTrees rt ON rt.treeID = ts.treeID " +
                "INNER JOIN siteVisits sv ON sv.requestID = rt.requestID " +
                "INNER JOIN treeRequests tr ON tr.requestID = sv.requestID " +
                "INNER JOIN neighborhoods n ON tr.neighborhood = n.name " +
                "WHERE pzf.factor = 'Under harsh sites: windy, dry or salty' " +
                "AND NOT EXISTS ( " +
                "    SELECT 1 " +
                "    FROM treePlantings tp " +
                "    INNER JOIN treeRequests tr2 ON tp.requestID = tr2.requestID " +
                "    WHERE tp.treePlanted = ts.treeID " +
                "      AND tr2.neighborhood = n.name " +
                "      AND YEAR(tp.plantDate) BETWEEN ? AND ? " +
                ") " +
                "GROUP BY ts.commonName, n.name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the year parameters
            stmt.setInt(1, startYear);
            stmt.setInt(2, endYear);

            ResultSet rs = stmt.executeQuery();

            System.out.println("===== Drought-Tolerant Trees Not Planted Between " + startYear + " and " + endYear + " =====");
            while (rs.next()) {
                String treeName = rs.getString("treeCommonName");
                String neighborhood = rs.getString("neighborhood");

                System.out.println("Tree: " + treeName + " | Neighborhood: " + neighborhood);
            }
            System.out.println("==========================================================================");

        } catch (SQLException e) {
            System.out.println("Error retrieving drought-tolerant trees not planted:");
            e.printStackTrace();
        }
    }
}

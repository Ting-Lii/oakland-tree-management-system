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
     * Report 2: Find the most recommended tree species per neighborhood within a selected district.
     */
    public void getMostRecommendedTreePerNeighborhoodByDistrict(String districtName) {
        String sql = "SELECT n.name AS neighborhood, t2.commonName AS mostRecommendedTree\n" +
                "FROM recommendedTrees rt2\n" +
                "INNER JOIN treeSpecies t2 ON rt2.treeID = t2.treeID\n" +
                "INNER JOIN siteVisits sv2 ON rt2.requestID = sv2.requestID\n" +
                "INNER JOIN treeRequests tr2 ON tr2.requestID = sv2.requestID\n" +
                "INNER JOIN neighborhoods n ON n.name = tr2.neighborhood\n" +
                "WHERE n.district = ?\n" +
                "GROUP BY n.name, t2.commonName\n" +
                "HAVING COUNT(*) = (\n" +
                "    SELECT MAX(tree_count)\n" +
                "    FROM (\n" +
                "        SELECT n2.name AS neighborhood, rt3.treeID, COUNT(*) AS tree_count\n" +
                "        FROM recommendedTrees rt3\n" +
                "        INNER JOIN siteVisits sv3 ON rt3.requestID = sv3.requestID\n" +
                "        INNER JOIN treeRequests tr3 ON tr3.requestID = sv3.requestID\n" +
                "        INNER JOIN neighborhoods n2 ON tr3.neighborhood = n2.name\n" +
                "        GROUP BY n2.name, rt3.treeID\n" +
                "    ) AS subquery\n" +
                "    WHERE subquery.neighborhood = n.name\n" +
                ")\n" +
                "ORDER BY n.name;";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, districtName);

            ResultSet rs = stmt.executeQuery();

            System.out.println("===== Most Recommended Trees in District: " + districtName + " =====");
            boolean found = false;
            while (rs.next()) {
                String neighborhood = rs.getString("neighborhood");
                String treeName = rs.getString("mostRecommendedTree");

                System.out.println("Neighborhood: " + neighborhood + " | Most Recommended Tree: " + treeName);
                found = true;
            }
            if (!found) {
                System.out.println("No recommended trees found for this district.");
            }
            System.out.println("============================================================");

        } catch (SQLException e) {
            System.out.println("Error retrieving Most Recommended Trees by district:");
            e.printStackTrace();
        }
    }

    /**
     * Report 3: Distinct tree species planted and volunteer involvement in active neighborhoods for a given year.
     */
    public void getSpeciesAndVolunteerStatsByNeighborhood(int year) {
        String sql = "SELECT n.name AS neighborhood, " +
                "COUNT(DISTINCT ts.commonName) AS species_count, " +
                "COUNT(DISTINCT vp.vid) AS total_volunteers " +
                "FROM treePlantings tp " +
                "INNER JOIN treeRequests tr ON tp.requestID = tr.requestID " +
                "INNER JOIN neighborhoods n ON tr.neighborhood = n.name " +
                "INNER JOIN treeSpecies ts ON tp.treePlanted = ts.treeID " +
                "LEFT JOIN volunteerPlants vp ON vp.requestID = tp.requestID " +
                "WHERE YEAR(tp.plantDate) = ? " +
                "AND tr.neighborhood IN ( " +
                "    SELECT tr2.neighborhood " +
                "    FROM treePlantings tp2 " +
                "    INNER JOIN treeRequests tr2 ON tp2.requestID = tr2.requestID " +
                "    WHERE YEAR(tp2.plantDate) = ? " +
                "    GROUP BY tr2.neighborhood " +
                "    HAVING COUNT(tp2.treePlanted) >= 2 " +
                ") " +
                "GROUP BY n.name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, year);
            stmt.setInt(2, year);

            ResultSet rs = stmt.executeQuery();

            System.out.println("===== Tree Species and Volunteer Stats by Neighborhood (" + year + ") ======");
            while (rs.next()) {
                String neighborhood = rs.getString("neighborhood");
                int speciesCount = rs.getInt("species_count");
                int volunteerCount = rs.getInt("total_volunteers");

                System.out.println("Neighborhood: " + neighborhood);
                System.out.println("Distinct Tree Species Planted: " + speciesCount);
                System.out.println("Total Volunteers: " + volunteerCount);
                System.out.println("--------------------------------------------");
            }

        } catch (SQLException e) {
            System.out.println("Error generating Species and Volunteer Report:");
            e.printStackTrace();
        }
    }



    /**
     * Report 4: Find drought-tolerant trees never requested in tree planted happened neighborhoods.
     */
    /**
     * Find drought-tolerant trees (suitable for harsh sites) that were recommended but never planted
     * in any neighborhood between the specified start year and end year.
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

    /**
     * Report 5: Tree diversity and planting zone factors by neighborhood and year range.
     */
    public void getNeighborhoodTreeDiversity(String neighborhoodName, int startYear, int endYear, String plantingZoneFactor) {
        String sql = "SELECT tr.neighborhood, " +
                "COUNT(DISTINCT ts.treeID) AS species_count, " +
                "MIN(ts.commonName) AS min_species, " +
                "MAX(ts.commonName) AS max_species, " +
                "MIN(tp.plantDate) AS firstPlantDate, " +
                "MAX(tp.plantDate) AS lastPlantDate, " +
                "GROUP_CONCAT(DISTINCT tpz.plantingZoneFactor) AS planting_zone_factors, " +
                "(SELECT COUNT(*) FROM treePlantings tp_sub WHERE YEAR(tp_sub.plantDate) BETWEEN ? AND ?) AS total_plantings_all_neighborhoods, " +
                "(SELECT COUNT(DISTINCT tp_sub.treePlanted) FROM treePlantings tp_sub WHERE YEAR(tp_sub.plantDate) BETWEEN ? AND ?) AS total_species_all_neighborhoods " +
                "FROM treeRequests tr " +
                "JOIN treePlantings tp ON tr.requestID = tp.requestID " +
                "JOIN treeSpecies ts ON tp.treePlanted = ts.treeID " +
                "LEFT JOIN treeToPlantingZones tpz ON ts.treeID = tpz.treeID " +
                "WHERE tr.neighborhood = ? " +
                "AND tr.neighborhood IN ( " +
                "SELECT tr2.neighborhood " +
                "FROM treeRequests tr2 " +
                "JOIN treePlantings tp2 ON tr2.requestID = tp2.requestID " +
                "WHERE YEAR(tp2.plantDate) BETWEEN ? AND ? " +
                "GROUP BY tr2.neighborhood " +
                "HAVING COUNT(DISTINCT tp2.treePlanted) >= 2 " +
                ") " +
                "AND YEAR(tp.plantDate) BETWEEN ? AND ? " +
                "GROUP BY tr.neighborhood " +
                "UNION " +
                "SELECT tr.neighborhood, " +
                "COUNT(DISTINCT ts.treeID) AS species_count, " +
                "MIN(ts.commonName) AS min_species, " +
                "MAX(ts.commonName) AS max_species, " +
                "MIN(tp.plantDate) AS firstPlantDate, " +
                "MAX(tp.plantDate) AS lastPlantDate, " +
                "GROUP_CONCAT(DISTINCT tpz.plantingZoneFactor) AS planting_zone_factors, " +
                "NULL AS total_plantings_all_neighborhoods, " +
                "NULL AS total_species_all_neighborhoods " +
                "FROM treeRequests tr " +
                "JOIN treePlantings tp ON tr.requestID = tp.requestID " +
                "JOIN treeSpecies ts ON tp.treePlanted = ts.treeID " +
                "LEFT JOIN treeToPlantingZones tpz ON ts.treeID = tpz.treeID " +
                "WHERE tr.neighborhood = ? " +
                "AND tpz.plantingZoneFactor = ? " +
                "AND YEAR(tp.plantDate) BETWEEN ? AND ? " +
                "GROUP BY tr.neighborhood";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, startYear);
            stmt.setInt(2, endYear);
            stmt.setInt(3, startYear);
            stmt.setInt(4, endYear);
            stmt.setString(5, neighborhoodName);
            stmt.setInt(6, startYear);
            stmt.setInt(7, endYear);
            stmt.setInt(8, startYear);
            stmt.setInt(9, endYear);
            stmt.setString(10, neighborhoodName);
            stmt.setString(11, plantingZoneFactor);
            stmt.setInt(12, startYear);
            stmt.setInt(13, endYear);

            ResultSet rs = stmt.executeQuery();

            System.out.println("===== Tree Diversity Report for Neighborhood: " + neighborhoodName + " (" + startYear + "-" + endYear + ") =====");
            while (rs.next()) {
                System.out.println("Neighborhood: " + rs.getString("neighborhood"));
                System.out.println("Species Count: " + rs.getInt("species_count"));
                System.out.println("Least Planted Species: " + rs.getString("min_species"));
                System.out.println("Most Planted Species: " + rs.getString("max_species"));
                System.out.println("First Planting Date: " + rs.getDate("firstPlantDate"));
                System.out.println("Last Planting Date: " + rs.getDate("lastPlantDate"));
                System.out.println("Planting Zone Factors: " + rs.getString("planting_zone_factors"));
                System.out.println("Total Plantings (All Neighborhoods): " + rs.getString("total_plantings_all_neighborhoods"));
                System.out.println("Total Species (All Neighborhoods): " + rs.getString("total_species_all_neighborhoods"));
                System.out.println("----------------------------------------");
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving Neighborhood Tree Diversity:");
            e.printStackTrace();
        }
    }

}

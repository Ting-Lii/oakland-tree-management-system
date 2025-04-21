package DAO;

import util.DBConnection;

import java.sql.*;
import java.util.Scanner;

public class TreeSpeciesDAO {

    public void decrementInventory(int treeID, int num) {
        String sql = "UPDATE treeSpecies SET inventory = inventory - ? WHERE treeID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, num);
            stmt.setInt(2, treeID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error decrementing tree inventory:");
            e.printStackTrace();
        }
    }

    public void incrementInventory(int treeID, int num) {
        String sql = "UPDATE treeSpecies SET inventory = inventory + ? WHERE treeID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, num);
            stmt.setInt(2, treeID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error incrementing tree inventory:");
            e.printStackTrace();
        }
    }

    // admin add a new tree species into treeSpecies table
    public void addTreeSpecies() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Adding a new tree species. Please enter the following information:");

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // 事务开始

            String sql = "INSERT INTO treeSpecies (commonName, scientificName, minHeight, maxHeight, minWidth, maxWidth, minPlantingBedWidth, " +
                    "isPlantableUnderPowerLines, isCaNative, droughtTolerance, growthRate, foliageType, debris, rootDamagePotential, nurseryAvailability, visualAttraction, inventory) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                System.out.println("Common Name:");
                stmt.setString(1, scanner.nextLine().trim());

                System.out.println("Scientific Name:");
                stmt.setString(2, scanner.nextLine().trim());

                System.out.println("Minimum Height (inch):");
                stmt.setInt(3, Integer.parseInt(scanner.nextLine().trim()));

                System.out.println("Maximum Height (inch):");
                stmt.setInt(4, Integer.parseInt(scanner.nextLine().trim()));

                System.out.println("Minimum Width (inch):");
                stmt.setInt(5, Integer.parseInt(scanner.nextLine().trim()));

                System.out.println("Maximum Width (inch):");
                stmt.setInt(6, Integer.parseInt(scanner.nextLine().trim()));

                System.out.println("Minimum Planting Bed Width (inches):");
                int bedWidth = Integer.parseInt(scanner.nextLine().trim());
                stmt.setInt(7, bedWidth);

                System.out.println("Is Plantable Under Power Lines? (true/false):");
                stmt.setBoolean(8, Boolean.parseBoolean(scanner.nextLine().trim()));

                System.out.println("Is California Native? (true/false):");
                stmt.setBoolean(9, Boolean.parseBoolean(scanner.nextLine().trim()));

                System.out.println("Drought Tolerance (must be one of Moderate/High/Very High):");
                stmt.setString(10, scanner.nextLine().trim());

                System.out.println("Growth Rate (must be one of Slow/Moderate/Fast/Very Fast):");
                stmt.setString(11, scanner.nextLine().trim());

                System.out.println("Foliage Type (must be one of Evergreen/Deciduous/Drought Deciduous/Late Deciduous/ Semi-evergreen): ");
                stmt.setString(12, scanner.nextLine().trim());

                System.out.println("Debris (e.g. low/Moderate acorn potential): ");
                stmt.setString(13, scanner.nextLine().trim());

                System.out.println("Root Damage Potential (must be one of Low/Moderate/High):");
                stmt.setString(14, scanner.nextLine().trim());

                System.out.println("Nursery Availability (must be one of Low/Moderate/High):");
                stmt.setString(15, scanner.nextLine().trim());

                System.out.println("Visual Attraction: (e.g. Structure, Fall Color): ");
                stmt.setString(16, scanner.nextLine().trim());

                System.out.println("Initial Inventory (number of trees available):");
                stmt.setInt(17, Integer.parseInt(scanner.nextLine().trim()));

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("New tree species basic info added successfully.");

                    //  SK treeID
                    ResultSet generatedKeys = stmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int treeID = generatedKeys.getInt(1);
                        System.out.println("New treeID is: " + treeID);

                        insertPlantingZones(scanner, conn, treeID);

                        conn.commit();
                        System.out.println("Tree species and associated planting zones inserted successfully.");
                    } else {
                        System.out.println("Failed to retrieve generated treeID.");
                        conn.rollback();
                    }
                } else {
                    System.out.println("Failed to add new tree species.");
                    conn.rollback();
                }
            }
        } catch (SQLException e) {
            System.out.println("Error inserting new tree species:");
            e.printStackTrace();
        }
    }


    /**
     * Insert planting zones for the new tree species.
     * using numeric input: 0 (no factor), 1–4 (choose factors)
     */
    private void insertPlantingZones(Scanner scanner, Connection conn, int treeID) throws SQLException {
        System.out.println("Select planting zone factors for this tree:");
        System.out.println("0 - No planting zone factors");
        System.out.println("1 - Under harsh sites: windy, dry or salty");
        System.out.println("2 - Near bay locations");
        System.out.println("3 - Highly urbanized zones");
        System.out.println("4 - Residential adjacent to natural areas");

        System.out.println("Enter the numbers separated by spaces (e.g., '1 3 4'), or just '0' if none:");

        String[] inputs = scanner.nextLine().trim().split("\\s+");

        if (inputs.length == 1 && inputs[0].equals("0")) {
            System.out.println("No planting zone factors selected.");
            return;
        }

        // map numbers to actual plantingZoneFactor string
        String[] factorOptions = {
                "", // index 0 (no use)
                "Under harsh sites: windy, dry or salty",
                "Near bay locations",
                "Highly urbanized zones",
                "Residential adjacent to natural areas"
        };

        String insertZoneSQL = "INSERT INTO treeToPlantingZones (plantingZoneFactor, treeID) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(insertZoneSQL)) {
            for (String numStr : inputs) {
                try {
                    int option = Integer.parseInt(numStr);
                    if (option >= 1 && option <= 4) {
                        stmt.setString(1, factorOptions[option]);
                        stmt.setInt(2, treeID);
                        stmt.executeUpdate();
                        System.out.println("Linked planting zone: " + factorOptions[option]);
                    } else {
                        System.out.println("Invalid option ignored: " + numStr);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input ignored: " + numStr);
                }
            }
        }
    }



    // Admin delete a tree species from treeSpecies table
    public void deleteTreeSpecies() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Deleting a tree species.");

        System.out.println("Please enter the tree species ID (treeID) you want to delete:");
        int treeID = Integer.parseInt(scanner.nextLine().trim());

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "DELETE FROM treeSpecies WHERE treeID = ?")) {

            stmt.setInt(1, treeID);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Tree species with ID " + treeID + " deleted successfully.");
            } else {
                System.out.println("No tree species found with ID " + treeID + ".");
            }

        } catch (SQLException e) {
            System.out.println("Error deleting tree species:");
            e.printStackTrace();
        }
    }

    //============for task J=============
    /**
     * Get tree planting statistics for a given tree species.
     */
    public void getTreeStatistics(int treeID) {
        int totalPlanted = getTotalTreesPlanted(treeID);
        int yearsSinceFirst = getYearsSinceFirstPlanting(treeID);
        int yearsSinceLast = getYearsSinceMostRecentPlanting(treeID);
        int[] mostPlantedYearAndCount = getMostPlantedYearAndCount(treeID);

        System.out.println("========== Tree Species Planting Statistics ==========");
        System.out.println("Tree Species ID: " + treeID);
        System.out.println("Total Trees Planted: " + totalPlanted);
        System.out.println("Years Since First Planting: " + (yearsSinceFirst == -1 ? "N/A" : yearsSinceFirst + " years"));
        System.out.println("Years Since Most Recent Planting: " + (yearsSinceLast == -1 ? "N/A" : yearsSinceLast + " years"));
        if (mostPlantedYearAndCount[0] == -1) {
            System.out.println("No planting record available.");
        } else {
            System.out.println("Year With Most Trees Planted: " + mostPlantedYearAndCount[0]);
            System.out.println("Number of Trees Planted in That Year: " + mostPlantedYearAndCount[1]);
        }
        System.out.println("=======================================================");
    }

    /**
     * -> total number of trees planted for the given tree species.
     */
    private int getTotalTreesPlanted(int treeID) {
        String sql = "SELECT COUNT(*) AS total FROM treePlantings WHERE treePlanted = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, treeID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error getting total trees planted:");
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * -> number of years since first planting.
     */
    private int getYearsSinceFirstPlanting(int treeID) {
        String sql = "SELECT MIN(plantDate) AS firstDate FROM treePlantings WHERE treePlanted = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, treeID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && rs.getDate("firstDate") != null) {
                Date firstDate = rs.getDate("firstDate");
                return calculateYearsSince(firstDate);
            }
        } catch (SQLException e) {
            System.out.println("Error getting first planting date:");
            e.printStackTrace();
        }
        return -1; // if no planting
    }

    /**
     * -> number of years since most recent planting.
     */
    private int getYearsSinceMostRecentPlanting(int treeID) {
        String sql = "SELECT MAX(plantDate) AS lastDate FROM treePlantings WHERE treePlanted = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, treeID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && rs.getDate("lastDate") != null) {
                Date lastDate = rs.getDate("lastDate");
                return calculateYearsSince(lastDate);
            }
        } catch (SQLException e) {
            System.out.println("Error getting last planting date:");
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * find the year with the most trees planted and the count.
     * return: int[0] = year, int[1] = number of trees
     */
    private int[] getMostPlantedYearAndCount(int treeID) {
        String sql = "SELECT YEAR(plantDate) AS year, COUNT(*) AS total " +
                "FROM treePlantings " +
                "WHERE treePlanted = ? " +
                "GROUP BY year " +
                "ORDER BY total DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, treeID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new int[]{rs.getInt("year"), rs.getInt("total")};
            }
        } catch (SQLException e) {
            System.out.println("Error getting most planted year:");
            e.printStackTrace();
        }
        return new int[]{-1, -1};
    }

    /**
     * Utility: Calculate years from a given Date to today.
     */
    private int calculateYearsSince(Date date) {
        java.time.LocalDate plantedDate = date.toLocalDate();
        java.time.LocalDate today = java.time.LocalDate.now();
        return java.time.Period.between(plantedDate, today).getYears();
    }
}

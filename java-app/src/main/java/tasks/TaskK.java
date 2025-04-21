package tasks;

import DAO.ReportDAO;
import java.util.Scanner;

/**
 * Task K: five complex reports.
 */
public class TaskK {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ReportDAO reportDAO = new ReportDAO();

        System.out.println("Welcome! This is Task K - Complex Reports.");
        System.out.println("Enter '1' for Volunteer Workload Report,");
        System.out.println("'2' to get the most recommended tree species per neighborhood within a specified district, ");
        System.out.println("'3' to get the number of tree species and volunteers number for each active neighborhood in a specified year,");
        System.out.println("'4' for get unused Drought-Tolerant Trees species with a specified year range in tree planted neighborhood," );
        System.out.println("'5' for tree species diversity and planting zone factors for a specified neighborhood and year range");
        System.out.println("or 'q' to quit:");
        while (true) {
            String input = scanner.nextLine().trim();
            if (input.equalsIgnoreCase("q")) {
                System.out.println("Exiting Task K...");
                break;
            }

            switch (input) {
                case "1":
                    // Report 1: Volunteer workload report for highest total work-hour district
                    reportDAO.getVolunteerWorkloadReportByDistrict();
                    break;
                case "2":
                    // Report 2: Most recommended tree species per neighborhood
                    System.out.println("Enter the district name to get the most recommended trees (e.g. West Oakland):");
                    String district = scanner.nextLine().trim();
                    reportDAO.getMostRecommendedTreePerNeighborhoodByDistrict(district);
                    break;
                case "3":
                    // Report 3: Tree species and volunteer stats for active neighborhoods
                    System.out.println("Enter the year you want to check (e.g., 2025):");
                    int reportYear = Integer.parseInt(scanner.nextLine().trim());
                    reportDAO.getSpeciesAndVolunteerStatsByNeighborhood(reportYear);
                    break;

                case "4":
                    // Report 4: get unused Drought-Tolerant Trees species with a specified year range in tree planted neighborhood
                    System.out.println("Enter start year (e.g., 2022):");
                    int startYear = Integer.parseInt(scanner.nextLine().trim());
                    System.out.println("Enter end year (e.g., 2025):");
                    int endYear = Integer.parseInt(scanner.nextLine().trim());
                    reportDAO.getDroughtTolerantTreesNotPlantedInNeighborhood(startYear, endYear);
                    break;
                case "5":
                    // report 5: Tree Diversity and Planting Zone Factors
                    System.out.println("Enter the neighborhood name:");
                    String neighborhoodName = scanner.nextLine().trim();
                    System.out.println("Enter the start year (e.g., 2023):");
                    int startYear5 = Integer.parseInt(scanner.nextLine().trim());
                    System.out.println("Enter the end year (e.g., 2025):");
                    int endYear5 = Integer.parseInt(scanner.nextLine().trim());
                    System.out.println("Enter the planting zone factor (e.g., Highly urbanized zones):");
                    String plantingZoneFactor = scanner.nextLine().trim();
                    reportDAO.getNeighborhoodTreeDiversity(neighborhoodName, startYear5, endYear5, plantingZoneFactor);
                    break;
                default:
                    System.out.println("Invalid input. Please enter '1', '2', '3', or 'q' to quit.");
            }

            System.out.println("Please enter next option ('1', '2', '3', '4', '5' or 'q'):");
        }
    }
}

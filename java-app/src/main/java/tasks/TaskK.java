package tasks;

import DAO.ReportDAO;
import java.util.Scanner;

/**
 * Task K: three administrative reports
 */
public class TaskK {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ReportDAO reportDAO = new ReportDAO();

        System.out.println("Welcome Admin! This is Task K - Administrative Reports.");
        System.out.println("Enter '1' for Volunteer Workload Report, '2' for Most Recommended Trees per Neighborhood, '3' for Unused Drought-Tolerant Trees, or 'q' to quit:");

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
                    reportDAO.getMostRecommendedTreePerNeighborhood();
                    break;
                case "3":
                    // Report 3: Unused drought-tolerant tree species in harsh planting zones
                    System.out.println("Enter start year (e.g., 2022):");
                    int startYear = Integer.parseInt(scanner.nextLine().trim());
                    System.out.println("Enter end year (e.g., 2025):");
                    int endYear = Integer.parseInt(scanner.nextLine().trim());
                    reportDAO.getDroughtTolerantTreesNotPlantedInNeighborhood(startYear, endYear);
                    break;
                default:
                    System.out.println("Invalid input. Please enter '1', '2', '3', or 'q' to quit.");
            }

            System.out.println("Please enter next option ('1', '2', '3', or 'q'):");
        }
    }
}

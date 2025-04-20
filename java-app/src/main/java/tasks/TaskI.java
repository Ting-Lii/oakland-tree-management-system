package tasks;

import DAO.TreeRequestDAO;
import java.util.Scanner;

/**
 * Task I: Find all trees planted within a selection of Oakland neighborhoods
 * or zip codes specified by a user in the app.
 */
public class TaskI {
    public static void main(String[] args) {
        TreeRequestDAO treeRequestDAO = new TreeRequestDAO();
        Scanner scanner = new Scanner(System.in);

        System.out.println("Welcome to Task I: Find all trees planted within a selection of Oakland neighborhoods or zip codes specified by a user in the app.");
        // for simplicity, we skip user login
        System.out.println("Please enter the neighborhood name or zip code you want to search for:");
        String input = scanner.nextLine().trim();

        boolean isZipCode;
        try {
            Integer.parseInt(input);
            isZipCode = true;
        } catch (NumberFormatException e) {
            isZipCode = false;
        }

        treeRequestDAO.seeTreesPlantedByNeighborhoodOrZipCode(input, isZipCode);
    }
}

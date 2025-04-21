package tasks;

import DAO.TreeSpeciesDAO;
import java.util.Scanner;

/**
 * Task J: For every species of trees, find the number of trees planted and some basic statistics on when trees were planted:
 * 1. the number of years since the first tree of the species (this treeID) was planted,
 * 2. the number of years since the most recent tree of the species(this treeID) was planted.
 * 3. In addition, include the year that had the most trees of the species(this treeID) planted and the number of trees planted.
 */
public class TaskJ {
    public static void main(String[] args) {
        TreeSpeciesDAO treeSpeciesDAO = new TreeSpeciesDAO();
        Scanner scanner = new Scanner(System.in);

        System.out.println("Welcome to Task J! You can see some relevant statistics of tree species planted in Oakland.");

        while (true) {
            System.out.println("Please enter the tree species ID you want to search for (or 'q' to quit):");
            String input = scanner.nextLine().trim();

            if (input.equalsIgnoreCase("q")) {
                System.out.println("Exiting Task J...");
                return;
            }

            try {
                int treeID = Integer.parseInt(input);
                treeSpeciesDAO.getTreeStatistics(treeID);
                return;
            } catch (NumberFormatException e) {
                System.out.println("Invalid input. Please enter a valid tree species ID (integer) or 'q' to quit.");
            }
        }
    }
}

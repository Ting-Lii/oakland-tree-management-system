package tasks;

import DAO.TreeSpeciesDAO;
import java.util.Scanner;

/**
 * Task G. Update the collection of tree species available for planting: removal or addition of species.
 */
public class TaskG {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        TreeSpeciesDAO treeSpeciesDAO = new TreeSpeciesDAO();

        System.out.println("Welcome Admin! This is Task G - Update Tree Species Collection!");

        while (true) {
            System.out.println("Choose an action:");
            System.out.println("1. Add a new tree species");
            System.out.println("2. Delete an existing tree species");
            System.out.println("q. Quit Task G");
            String input = scanner.nextLine().trim();

            if (input.equalsIgnoreCase("q")) {
                System.out.println("Exiting Task G...");
                break;
            }

            switch (input) {
                case "1":
                    treeSpeciesDAO.addTreeSpecies();
                    break;
                case "2":
                    treeSpeciesDAO.deleteTreeSpecies();
                    break;
                default:
                    System.out.println("Invalid input. Please enter 1, 2, or q.");
            }
        }
    }
}

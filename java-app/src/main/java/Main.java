/**
 * This is group 6's main class for the oakland tree planting project.
 * It serves as the entry point for the program and allows users to select which task they want to run.
 * Besides, you can run the task by directly running the task class.
 */

import java.util.Scanner;
import tasks.*;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Welcome! Please select which task you want to run:");
        System.out.println("Enter 'A' for Task A: Resident registration and Volunteer registration (if the resident is registered)");
        System.out.println("Enter 'B' for Task B: Resident request for a tree.");
        System.out.println("Enter 'C' for Task C: Admin schedules a visit to a site requesting a tree.");
        System.out.println("Enter 'DE' for Task DE: Admin complete site visit and update relevant information, and assign a volunteer");
        System.out.println("Enter 'F' for Task F: Volunteer completes a site visit and updates relevant information.");
        System.out.println("Enter 'G' for Task G: Admin can add or delete a tree species.");
        System.out.println("Enter 'H' for Task H: Admin can retrieve all uncompleted tree requests and their days since submitted");
        System.out.println("Enter 'I' for Task I: User can find all trees planted within a specified neighborhood or zip code.");
        System.out.println("Enter 'J' for Task J: User can find the number of trees planted and some basic statistics on when trees were planted For every species of trees, ");
        System.out.println("Enter 'K' for Task K: Implementation for our reports.sql file.");
        System.out.println("Enter 'L' for Task L: Admin can delete a tree request using requestID");
        System.out.println("Enter 'q' to quit");

        while (true) {
            System.out.print("\nYour choice: ");
            String choice = scanner.nextLine().trim().toUpperCase();

            switch (choice) {
                case "A":
                    TaskA.main(new String[]{});
                    break;
                case "B":
                    TaskB.main(new String[]{});
                    break;
                case "C":
                    TaskC.main(new String[]{});
                    break;
                case "DE":
                    TaskDE.main(new String[]{});
                    break;
                case "F":
                    TaskF.main(new String[]{});
                    break;
                case "G":
                    TaskG.main(new String[]{});
                    break;
                case "H":
                    TaskH.main(new String[]{});
                    break;
                case "I":
                    TaskI.main(new String[]{});
                    break;
                case "J":
                    TaskJ.main(new String[]{});
                    break;
                case "K":
                    TaskK.main(new String[]{});
                    break;
                case "L":
                    TaskL_stored_procedure.main(new String[]{});
                    break;
                case "Q":
                    System.out.println("Exiting the program. Goodbye!");
                    return;
                default:
                    System.out.println("Invalid input. Please enter a valid option (A, B, C, DE, F, G, H, I, J, K, L, q).");
            }
        }
    }
}

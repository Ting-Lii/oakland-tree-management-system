/**
 * Task H. For all requests to plant a tree that have not yet completed, show its status,
 * and the number of days that has transpired since it was first submitted.
 * PS: we define not yet complteed as the tree request has been approved, but the tree planting has not been completed.
 */
package tasks;

import DAO.TreeRequestDAO;
import java.util.Scanner;

public class TaskH {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        TreeRequestDAO treeRequestDAO = new TreeRequestDAO();

        // skip admin login for simplicity
        System.out.println("Welcome Admin! This is Task H - Tree Request Status Check!");
        System.out.println("Enter '1' to retrieve all uncompleted tree requests and their days since submitted, or 'q' to quit:");

        String input = scanner.nextLine().trim();
        if (input.equalsIgnoreCase("q")) {
            System.out.println("Exiting Task H...");
            return;
        }

        if (input.equals("1")) {
            treeRequestDAO.getAllUncompletedTreeRequestsAndDaysSinceSubmitted();
        } else {
            System.out.println("Invalid input. Please enter '1' or 'q'.");
        }
    }
}


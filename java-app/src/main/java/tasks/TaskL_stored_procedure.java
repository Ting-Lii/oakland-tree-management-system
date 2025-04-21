package tasks;

import DAO.AdminDAO;
import DAO.TreeRequestDAO;
import Model.TreeRequest;

import java.util.List;
import java.util.Scanner;

public class TaskL_stored_procedure {
    public static void main(String[] args) {
        AdminDAO adminDAO = new AdminDAO();
        TreeRequestDAO treeRequestDAO = new TreeRequestDAO();

        System.out.println("Welcome to task L, this is the task that uses the stored procedure " +
                "in the database, which enables admin to delete a tree request using requestID");
        // for simplicity, we skip user login
        // get the list of tree requests
        List<TreeRequest> Requests = treeRequestDAO.getAllTreeRequests();
        if (Requests.isEmpty()) {
            System.out.println("No tree requests to review.");
        }
        else{
            System.out.println("\nHere are all tree requests:");
            for (TreeRequest tr : Requests) {
                System.out.println("Request ID: " + tr.getRequestID() + " | Date Submitted: "
                        + tr.getDateSubmitted() + " | Status: " + tr.getRequestStatus()
                        + " | Neighborhood: " + tr.getNeighborhood());
            }

            Scanner scanner = new Scanner(System.in);

            while (true) {
                System.out.println("Please enter the tree request ID you want to delete (or 'q' to quit):");
                String input = scanner.nextLine().trim();

                if (input.equalsIgnoreCase("q")) {
                    System.out.println("Exiting Task L...");
                    return;
                }
                try {
                    int treeRequestID = Integer.parseInt(input);
                    adminDAO.deleteTreeRequest(treeRequestID);
                    return;
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input. Please enter a valid request ID (integer) or 'q' to quit.");
                }
            }
        }
    }
}

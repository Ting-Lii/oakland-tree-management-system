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

            System.out.println("Please enter the tree request ID you want to delete:");
            Scanner scanner = new Scanner(System.in);
            int treeRequestID = Integer.parseInt(scanner.nextLine().trim());
            adminDAO.deleteTreeRequest(treeRequestID);
        }
    }
}

package tasks;

import DAO.SiteVisitDAO;
import DAO.TreeRequestDAO;
import DAO.UserDAO;
import Model.TreeRequest;
import util.DBConnection;

import java.sql.Date;
import java.util.List;
import java.util.Scanner;

/**
 * Task c. Admin schedules a visit to a site requesting a tree.
 */
public class TaskC {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        UserDAO userDAO = new UserDAO();
        TreeRequestDAO treeRequestDAO = new TreeRequestDAO();
        SiteVisitDAO siteVisitDAO = new SiteVisitDAO();

        System.out.println("Welcome Admin! This is Task C - Site Visit Scheduling!");
        System.out.println("Please login as admin first.");
        System.out.println("Enter your email:");
        String email = scanner.nextLine();
        System.out.println("Enter your password:");
        String password = scanner.nextLine();

        if (!userDAO.isValidLogin(email, password) || !userDAO.isAdmin(email)) {
            System.out.println("Login failed. Not an admin or wrong credentials.");
            return;
        }

        System.out.println("Admin login successful.");
        int adminID = userDAO.getUserIdByEmail(email);

        // 1. Admin查看所有submitted的tree request
        while (true) {
            List<TreeRequest> submittedRequests = treeRequestDAO.getAllSubmittedTreeRequests();
            if (submittedRequests.isEmpty()) {
                System.out.println("No submitted tree requests to review.");
                break;
            }

            System.out.println("\nHere are all submitted tree requests:");
            for (TreeRequest tr : submittedRequests) {
                System.out.println("Request ID: " + tr.getRequestID() + " | Address: " + tr.getStreetAddress() + " | Phone: " + tr.getPhone());
            }

            System.out.println("\nEnter the Request ID you want to review (or 'q' to quit):");
            String input = scanner.nextLine().trim();
            if (input.equalsIgnoreCase("q")) break;

            int requestID;
            try {
                requestID = Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Invalid input. Please enter a valid Request ID or 'q'.");
                continue;
            }

            System.out.println("Approve (a) or Reject (r) this tree request?");
            String decision = scanner.nextLine().trim().toLowerCase();

            if (decision.equals("a")) {
                boolean updated = treeRequestDAO.updateTreeRequestStatus(requestID, "approved");
                if (updated) {
                    System.out.println("✅ Tree request " + requestID + " approved.");

                    // after approved, create an initial site visit record!
                    boolean inserted = siteVisitDAO.insertInitialSiteVisit(requestID, adminID);
                    if (inserted) {
                        System.out.println("✅ Initial site visit record created for request ID: " + requestID);

                        // ask if the admin wants to schedule the site visit now
                        System.out.println("Do you want to schedule the site visit for this request now? (y/n)");
                        String answer = scanner.nextLine().trim().toLowerCase();
                        if (answer.equals("y")) {
                            System.out.println("Enter the site visit date (YYYY-MM-DD):");
                            String siteVisitDateStr = scanner.nextLine();
                            Date siteVisitDate = Date.valueOf(siteVisitDateStr);

                            boolean scheduled = siteVisitDAO.scheduleSiteVisit(requestID, adminID, siteVisitDate);
                            if (scheduled) {
                                System.out.println("✅ Site visit scheduled successfully for Request ID: " + requestID);
                            } else {
                                System.out.println("❌ Failed to schedule site visit immediately.");
                            }
                        } else {
                            System.out.println("You chose not to schedule the site visit now. You can schedule it later.");
                        }

                    } else {
                        System.out.println("❌ Failed to create initial site visit record for request ID: " + requestID);
                    }

                } else {
                    System.out.println("❌ Failed to update tree request status.");
                }

            } else if (decision.equals("r")) {
                boolean updated = treeRequestDAO.updateTreeRequestStatus(requestID, "rejected");
                System.out.println(updated ? "Tree request rejected." : "Failed to reject tree request.");
            } else {
                System.out.println("Invalid input. Skipping...");
            }
        }


        System.out.println("Exiting Task C.");
    }
}



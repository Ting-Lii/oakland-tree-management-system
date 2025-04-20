/**
 * This file is for task D and E: On or after a site visit, record the information gathered by the team including references to photos for the team to review later.
 * Schedule the planting of a tree, includes booking the team of volunteers who will do the planting
 */
package tasks;

import DAO.AdminDAO;
import DAO.SiteVisitDAO;
import DAO.UserDAO;

import java.util.Scanner;

public class TaskDE {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        AdminDAO adminDAO = new AdminDAO();
        SiteVisitDAO siteVisitDAO = new SiteVisitDAO();
        UserDAO userDAO = new UserDAO();

        System.out.println("Welcome to Task D and E: Site Visit and Planting for Admin!");

        // Admin login
        System.out.println("Enter your admin email:");
        String email = scanner.nextLine();
        System.out.println("Enter your password:");
        String password = scanner.nextLine();

        if (!adminDAO.isValidAdminLogin(email, password)) {
            System.out.println("Login failed. Incorrect admin credentials.");
            return;
        }
        System.out.println("Admin login successful.");

        int adminID = userDAO.getUserIdByEmail(email);
        if (adminID == -1) {
            System.out.println("Error: Cannot find admin ID.");
            return;
        }

        while (true) {
            System.out.println("\nHere are all your assigned site visits:");
            siteVisitDAO.getAllAdminSiteVisits(adminID);
            System.out.println("-----------------------------------------");

            System.out.println("Enter the Request ID to update site visit information (or 'q' to quit):");
            String input = scanner.nextLine().trim();
            if (input.equalsIgnoreCase("q")) {
                System.out.println("Exiting Task D and E...");
                break;
            }

            int requestID;
            try {
                requestID = Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Invalid Request ID. Please enter a number.");
                continue;
            }

            System.out.println("Enter '1' to schedule site visit, '2' to complete site visit:");
            String action = scanner.nextLine().trim();

            if (action.equals("1")) {
                adminDAO.scheduleSiteVisit(requestID, adminID);
            } else if (action.equals("2")) {
                // Step 1: Update site visit info (complete)
                adminDAO.completeSiteVisitInfo(scanner, requestID, adminID);

                // Step 2: Recommend one tree
                adminDAO.recommendOneTree(scanner, requestID);

                // Step 3: Create tree planting record
                adminDAO.createTreePlanting(scanner, requestID, adminID);

                // Step 4: assign volunteer
                adminDAO.assignVolunteer(scanner, requestID);

                System.out.println("Site visit, tree recommendation, planting, and volunteer assignment all completed for Request ID: " + requestID);
            } else {
                System.out.println("Invalid action. Please enter '1' or '2'.");
            }
        }
    }
}


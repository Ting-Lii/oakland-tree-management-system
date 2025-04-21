package tasks;

import DAO.PermitDAO;
import DAO.TreeRequestDAO;
import DAO.UserDAO;
import Model.Permit;
import Model.TreeRequest;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Scanner;

/**
 * Task B: Accept a request for a tree, registering as a new user if necessary.
 * When requesting a tree, users will need to specify their address as the tree will be planted on the portion of the street facing their property.
 */
public class TaskB {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        UserDAO userDAO = new UserDAO();
        PermitDAO permitDAO = new PermitDAO();
        TreeRequestDAO treeRequestDAO = new TreeRequestDAO();

        System.out.println("Welcome Resident! This is Task B!");
        System.out.println("Please login first.");
        System.out.println("Enter your email:");
        String email = scanner.nextLine();
        System.out.println("Enter your password:");
        String password = scanner.nextLine();

        if (!userDAO.isValidLogin(email, password)) {
            System.out.println("Login failed. Incorrect email or password.");
            return;
        }

        int rid = userDAO.getUserIdByEmail(email);

        if (rid == -1) {
            System.out.println("Error: Cannot find user ID for this email.");
            return;
        }

        System.out.println("Login successful!");
        System.out.println("Let's request a tree! BUT please upload your approved permit first.");

        if (!permitDAO.hasApprovedPermit(rid)) {
            System.out.println("⚡ You must upload an approved permit before requesting a tree.");

            System.out.println("Enter your Permit ID:");
            String permitID = scanner.nextLine();
            System.out.println("Enter your Permit Status (only 'approved' is accepted for requesting trees):");
            String permitStatus = scanner.nextLine().trim().toLowerCase();

            if (!permitStatus.equals("approved")) {
                System.out.println("Only permits with status 'approved' can be used for tree requests.");
                return;
            }

            System.out.println("Enter the Permit Issue Date (YYYY-MM-DD):");
            String issueDateStr = scanner.nextLine();
            Date issueDate = Date.valueOf(issueDateStr);

            Permit permit = new Permit(permitID, rid, permitStatus, issueDate);
            boolean uploaded = permitDAO.uploadPermit(permit);
            System.out.println(uploaded ? "Permit uploaded successfully." : "Failed to upload permit.");

            if (!uploaded) return;
        }

        // now ask input for treeRequest information
        System.out.println("Let's request a tree now!");
        System.out.println("Enter the street address where the tree will be planted:");
        String address = scanner.nextLine();

        System.out.println("Enter the zip code:");
        String zipCode = scanner.nextLine();

        System.out.println("Enter your budget for the tree:");
        float budget = Float.parseFloat(scanner.nextLine());

        System.out.println("Enter your relationship to the property (e.g., Owner / Tenant):");
        String relationship = scanner.nextLine();

        LocalDate today = LocalDate.now();
        Date dateSubmitted = Date.valueOf(today);

        System.out.println("Enter your contact phone number (e.g., 510-555-1234):");
        String phone = scanner.nextLine();

        System.out.println("Enter your neighborhood name:");
        String neighborhood = scanner.nextLine();

        TreeRequest treeRequest = new TreeRequest(
                0,   // auto increment in ddl
                address,
                zipCode,
                budget,
                relationship,
                dateSubmitted,
                "submitted",
                phone,
                neighborhood
        );

        boolean success = treeRequestDAO.canSubmitTreeRequest(rid, treeRequest);
        System.out.println(success ? "Tree request submitted successfully!" : "Failed to submit tree request.");
    }
}


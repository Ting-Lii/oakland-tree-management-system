// ting li
// ps: could generate more helpful prompts if time permitted for users like: please check your email format, pelase
// check your neigborhood name, etc.
import java.sql.*;
import java.time.LocalDate;
import java.util.Scanner;

import java.time.LocalDate;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        UserDAO userDAO = new UserDAO();
        VolunteerDAO volunteerDAO = new VolunteerDAO();
        PermitDAO permitDAO = new PermitDAO();
        TreeRequestDAO treeRequestDAO = new TreeRequestDAO();
        AdminDAO adminDAO = new AdminDAO();

        // remember to update the cmd here for the new features.
        System.out.println("Welcome to Oakland Tree Organization!");
        System.out.println("If you want to register, please enter \"r\"");
        System.out.println("If you have already registered, please enter \"r login\" to request a tree or apply to be our volunteer.");
        System.out.println("If you want to login as volunteer, enter \"v login\" to login.");
        System.out.println("If you are Admin, please enter \"a login\" to login.");

        String command = scanner.nextLine().trim().toLowerCase();
        // LANDING PAGE
        // task a1: register a new resident
        if (command.equals("r")) {
            System.out.println("Enter Your First Name:");
            String firstName = scanner.nextLine();
            System.out.println("Enter Your Last Name:");
            String lastName = scanner.nextLine();
            System.out.println("Enter Your Email:");
            String email = scanner.nextLine();
            System.out.println("Enter Your Password:");
            String password = scanner.nextLine();
            System.out.println("Enter Your zip Code:");
            String zipCode = scanner.nextLine();
            System.out.println("Enter Your Neighborhood Name:");
            String neighborhood = scanner.nextLine();
            // automatically set the role to resident from constructor
            User newUser = new User(firstName, lastName, email, password, zipCode, neighborhood);
            boolean success = userDAO.isRegisterUser(newUser);
            System.out.println(success ? "User registered successfully!" : "Failed to register user.");
        }
        // RESIDENT PAGE
        // task a2 + task b: existing resident can apply volunteer or request tree
        else if (command.equals("r login")) {
            System.out.println("Enter your email:");
            String email = scanner.nextLine();
            System.out.println("Enter your password:");
            String password = scanner.nextLine();

            if (!userDAO.isValidLogin(email, password)) {
                System.out.println("Login failed. Please check your credentials.");
                return;
            }

            int rid = userDAO.getUserIdByEmail(email);
            System.out.println("Welcome back! Enter 'apply volunteer' or 'request tree':");
            String subCmd = scanner.nextLine().trim().toLowerCase();

            // apply volunteer
            if (subCmd.equals("apply volunteer")) {
                boolean applied = volunteerDAO.canApplyVolunteer(rid);
                System.out.println(applied ? "Volunteer application submitted." : "Application failed.");
            }


            // request tree
            else if (subCmd.equals("request tree")) {
                System.out.println("Enter 'p' to upload your permit information.");
                System.out.println("Enter 'r' to request a tree.\nEnter 'q' to quit.");
                String treeCmd = scanner.nextLine().trim().toLowerCase();

                if (treeCmd.equals("p")) {
                    System.out.println("Enter your permit ID:");
                    String permitID = scanner.nextLine();
                    System.out.println("Enter your permit status (submitted/approved/rejected):");
                    String permitStatus = scanner.nextLine().toLowerCase();
                    System.out.println("Enter the permit issue date (YYYY-MM-DD):");
                    String issueDateStr = scanner.nextLine();
                    boolean uploaded = permitDAO.canUploadPermit(permitID, rid, permitStatus, java.sql.Date.valueOf(issueDateStr));
                    System.out.println(uploaded ? "Permit uploaded successfully." : "Upload failed.");
                } else if (treeCmd.equals("r")) {
                    // first check if the user has an approved permit
                    if (!permitDAO.isPermitApproved(rid)) {
                        System.out.println("You must HAVE an approved permit to request a tree.");
                        return;
                    }
                    System.out.println("Enter the tree request address:");
                    String address = scanner.nextLine();
                    LocalDate dateSubmitted = LocalDate.now();
                    System.out.println("Enter the phone number:");
                    String phone = scanner.nextLine();
                    System.out.println("Enter your budget:");
                    float budget = Float.parseFloat(scanner.nextLine());
                    System.out.println("Enter your role (e.g. tenant/owner/...):");
                    String role = scanner.nextLine();
                    System.out.println("Enter the zip code for planting tree:");
                    String zipCode = scanner.nextLine();
                    System.out.println("Enter the neighborhood e.g. Golden Gate:");
                    String neighborhood = scanner.nextLine();

                    boolean submitted = treeRequestDAO.canSubmitTreeRequest(
                            rid, address, dateSubmitted, phone, budget, role, zipCode, neighborhood);
                    System.out.println(submitted ? "Tree request submitted!" : "Submission failed.");
                }
            }
        }
        // VOLUNTEER PAGE
        else if (command.equals("v login")) {
            System.out.println("Welcome Volunteer! Please enter your email:");
            String email = scanner.nextLine();
            System.out.println("Please enter your password:");
            String password = scanner.nextLine();

            if (!volunteerDAO.canVolunteerLogin(email, password)) {
                System.out.println("Login failed. Please check your email, password, or ensure your role is 'volunteer'.");
                return;
            }

            int vid = userDAO.getUserIdByEmail(email);
            System.out.println("Login successful!");

            System.out.println("Enter 'see task' to view your assigned tree requests and planting info.");
            System.out.println("Enter 'fill planting' to report a planting activity.");
            System.out.println("Enter 'update availability' to change your availability status.");
            System.out.println("Enter 'q' to logout.");

            String volCmd = scanner.nextLine().trim().toLowerCase();

            if (volCmd.equals("see task")) {
                volunteerDAO.seeTreeRequestAndTreePlantingAndTreeSpecies(vid);

            } else if (volCmd.equals("fill planting")) {
                System.out.println("Enter the request ID you planted for:");
                int requestID = Integer.parseInt(scanner.nextLine());

                System.out.println("Enter your work hours:");
                float workHour = Float.parseFloat(scanner.nextLine());

                System.out.println("Enter your workload feedback (light/moderate/heavy/overload):");
                String feedback = scanner.nextLine();

                boolean planted = volunteerDAO.updateVolunteerPlant(requestID, vid, workHour, feedback);
                System.out.println(planted ? "Planting info recorded successfully!" : "Failed to record planting info.");
            }
            else if (volCmd.equals("update availability")) {
                System.out.println("Are you currently available? Enter 'yes' or 'no':");
                String answer = scanner.nextLine().toLowerCase();
                boolean isAvailable = answer.equals("yes");

                boolean updated = volunteerDAO.updateVolunteerAvailability(vid, isAvailable);
                System.out.println(updated ? "Availability updated." : "Update failed.");

            } else if (volCmd.equals("q")) {
                System.out.println("Logged out. Thank you!");
            } else {
                System.out.println("Invalid volunteer command.");
            }
        }

        // ADMIN PAGE
// admin review
        else if (command.equals("a login")) {
            System.out.println("Enter your admin email:");
            String email = scanner.nextLine();
            System.out.println("Enter your password:");
            String password = scanner.nextLine();

            if (!adminDAO.isValidAdminLogin(email, password)) {
                System.out.println("Login failed. Not an admin or wrong credentials.");
                return;
            }

            System.out.println("Admin login successful.");
            // save it to use later
            int adminID = userDAO.getUserIdByEmail(email);

            while (true) {
                System.out.println("\nPlease enter a command:");
                System.out.println("Enter 'rva' to review volunteer applicants.");
                System.out.println("Enter 'rt' to review tree requests.");
                System.out.println("Enter 'sv' to update site visit information (schedule or complete a visit).");
                System.out.println("⚡ Note: You must complete a site visit (sv) before assigning a volunteer!");
                System.out.println("Enter 'av' to assign a volunteer to a tree request after site visit is completed.");
                System.out.println("Enter 'q' to logout.");

                String adminCmd = scanner.nextLine().trim().toLowerCase();

                if (adminCmd.equals("rva")) {
                    adminDAO.reviewVolunteerApplications(scanner);
                } else if (adminCmd.equals("rt")) {
                    adminDAO.reviewTreeRequests(scanner);
                } else if (adminCmd.equals("sv")) {
                    adminDAO.updateSiteVisit(scanner, adminID);
                } else if (adminCmd.equals("av")) {
                    adminDAO.assignVolunteerToRequest(scanner);
                } else if (adminCmd.equals("q")) {
                    System.out.println("Admin logged out.");
                    break;
                } else {
                    System.out.println("Unknown command. Please try again.");
                }
            }
        }
        else {
            System.out.println("Invalid command. Exiting.");
        }

        scanner.close();
    }
}


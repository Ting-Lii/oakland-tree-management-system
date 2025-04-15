// ting li
// ps: could generate more helpful prompts if time permitted for users like: please check your email format, pelase
// check your neigborhood name, etc.
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Welcome to Oakland Tree Organization!");
        System.out.println("Please enter 'r' to register or 'q' to quit.");
        System.out.println("If you are an existing resident and want to apply for being our volunteer, please enter 'register volunteer' to apply for a volunteer role.");
        System.out.println("If you are an admin, please enter 'admin review' to review volunteer applications.");
        System.out.println("Please enter your command:");

        String command = scanner.nextLine().trim().toLowerCase(); // to avoid case sensitive issues
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

            User newUser = new User(firstName, lastName, email, password, zipCode, neighborhood);
            // save to DB
            UserDAO dao = new UserDAO();
            if (newUser.isValid()) {
                boolean success = dao.registerUser(newUser);
                System.out.println(success ? "User registered successfully!" : "Failed to register user.");
            } else {
                System.out.println("Invalid input. Please fill all required fields.");
            }
        } else if (command.equals("q")) {
            System.out.println("Sucessfully quit.");
        } else if (command.equals("register volunteer")) { // task a2. existing resident apply for being volunteer role,we let resident specify the admin.
            System.out.println("Enter your email:");
            String email = scanner.nextLine();

            System.out.println("Enter the admin ID you want to assign your application to:");
            int adminID = Integer.parseInt(scanner.nextLine());

            UserDAO userDAO = new UserDAO();
            int userID = userDAO.getUserIdByEmail(email); // get user ID by email in real world setting.

            if (userID != -1) {
                VolunteerDAO volunteerDAO = new VolunteerDAO();
                boolean success = volunteerDAO.applyVolunteer(userID, "pending");
                System.out.println(success ? "Volunteer application submitted!" : "Application failed.");
            } else {
                System.out.println("User not found.");
            }

        } else if (command.equals("admin review")) {
            System.out.println("Welcome Admin! Please review the volunteer applications.");
            try (Connection conn = DBConnection.getConnection()) {
                String query = "SELECT v.vid, u.firstName, u.lastName, u.email " +
                                "FROM volunteers v JOIN users u ON v.vid = u.uid " +
                                "WHERE v.applicationStatus = 'pending'";
                PreparedStatement stmt = conn.prepareStatement(query);

                ResultSet res = stmt.executeQuery();
                // loop through the result set
                while (res.next()) {
                    int vid = res.getInt("vid");
                    String vName = res.getString("firstName") + " " + res.getString("lastName");
                    String vEmail = res.getString("Email");
                    System.out.println("Reviewing: " + vid + " - " + vName + " (" + vEmail + ")");
                    System.out.println("Enter Decision Approve (a) or Reject (r)?");
                    String decision = scanner.nextLine();

                    String newStatus = decision.equalsIgnoreCase("a") ? "approved" : "rejected";

                    PreparedStatement updateStmt = conn.prepareStatement("UPDATE volunteers SET applicationStatus = ? WHERE vid = ?");
                    updateStmt.setString(1, newStatus);
                    updateStmt.setInt(2, vid);
                    // execute updated based on the decision
                    updateStmt.executeUpdate();
                    System.out.println("Application for " + vName + " has been " + newStatus + ".");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("Invalid Input. Please Check and Try Again.");
        }
    }
}




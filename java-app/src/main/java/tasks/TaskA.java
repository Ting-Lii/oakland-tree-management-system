package tasks;
import DAO.UserDAO;
import DAO.VolunteerDAO;
import java.util.Scanner;
import Model.User;

/**
 * Task A: Resident registration and Volunteer registration (if the resident is registered)
 */
public class TaskA {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        UserDAO userDAO = new UserDAO();
        VolunteerDAO volunteerDAO = new VolunteerDAO();

        System.out.println("Welcome to Oakland Tree Organization Registration!");
        System.out.println("This is for task A: Resident registration and Volunteer registration.");
        System.out.println("Please enter 'r' to register as a resident, or 'v' to apply as a volunteer:");
        String command = scanner.nextLine().trim().toLowerCase();

        if (command.equals("r")) {
            System.out.println("Enter Your First Name:");
            String firstName = scanner.nextLine();
            System.out.println("Enter Your Last Name:");
            String lastName = scanner.nextLine();
            System.out.println("Enter Your Email:");
            String email = scanner.nextLine();
            System.out.println("Enter Your Password:");
            String password = scanner.nextLine();
            System.out.println("Enter Your Zip Code:");
            String zipCode = scanner.nextLine();
            System.out.println("Enter Your Neighborhood Name:");
            String neighborhood = scanner.nextLine();

            User newUser = new User(firstName, lastName, email, password, zipCode, neighborhood);

            boolean success = userDAO.isRegisterUser(newUser);
            System.out.println(success ? "User registered successfully!" : "Failed to register user.");
        }
        else if (command.equals("v")) {
            System.out.println("Enter your registered email:");
            String email = scanner.nextLine();

            int userID = userDAO.getUserIdByEmail(email);
            if (userID != -1) {
                boolean applied = volunteerDAO.canApplyVolunteer(userID);
                System.out.println(applied ? "Volunteer application submitted successfully!" : "Failed to submit volunteer application.");
            } else {
                System.out.println("Resident email not found. Please register first.");
            }
        }
        else {
            System.out.println("Invalid command. Please restart and try again.");
        }
    }
}

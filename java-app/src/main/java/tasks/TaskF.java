/**
 * This file is for task F: After a tree is planted, record volunteers who participated, observations of the tree planting,
 * and references to before/after photos of the site.
 */
package tasks;

import DAO.TreeSpeciesDAO;
import DAO.UserDAO;
import DAO.VolunteerDAO;
import java.util.Scanner;

public class TaskF {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        UserDAO userDAO = new UserDAO();
        VolunteerDAO volunteerDAO = new VolunteerDAO();
        TreeSpeciesDAO treeSpeciesDAO = new TreeSpeciesDAO();

        System.out.println("Welcome Volunteer! This is Task F!");
        System.out.println("Please enter your email:");
        String email = scanner.nextLine();
        System.out.println("Please enter your password:");
        String password = scanner.nextLine();

        // step 1: volunteer login
        if (!volunteerDAO.canVolunteerLogin(email, password)) {
            System.out.println("Login failed. Not a volunteer or wrong credentials.");
            return;
        }
        System.out.println("Volunteer login successful.");

        System.out.println("Please enter the tree request ID you participated in and update:");
        int requestID = scanner.nextInt();
        scanner.nextLine();

        // step 2: volunteer fill their tree planting attribute: photoAfter
        if (!volunteerDAO.canFillTreePlanting(requestID)) {
            System.out.println("You are not assigned to this tree request.");
            return;
        }
        System.out.println("Please enter the photo link after planting:");
        String photoAfter = scanner.nextLine().trim();

        if (!volunteerDAO.canUpdatePhotoAfter(requestID, photoAfter)) {
            System.out.println("Failed to update the photo after planting.");
            return;
        }

        System.out.println("Thanks for your help. Let's fill your feedback for this tree planting!");

        // step 3: volunteer fill volunteer plants attributes: workHour, workloadFeedback
        System.out.println("Please enter your work hour:");
        float workHour = scanner.nextFloat();
        scanner.nextLine();

        System.out.println("Please enter your workload feedback using one of the following light/moderate/heavy/overload: ");
        String workloadFeedback = scanner.nextLine().trim();

        // Fix: missing updateVolunteerPlant
        boolean updated = volunteerDAO.canUpdateVolunteerPlant(requestID, workHour, workloadFeedback);
        if (!updated) {
            System.out.println("Failed to update your tree planting record.");
            return;
        }

        // Fix: need the treeID before decrementing inventory
        int treeID = volunteerDAO.getTreeIDByRequestID(requestID);
        if (treeID == -1) {
            System.out.println("Error finding tree species associated with the request.");
            return;
        }

        // treeID's treeSpecies.inventory -= 1
        treeSpeciesDAO.decrementInventory(treeID, 1);

        System.out.println("Thank you for updating your tree planting info!");
    }
}

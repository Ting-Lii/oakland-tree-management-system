package tasks;

import DAO.TreeSpeciesDAO;

import java.util.Scanner;

/**
 * Task J: For every species of trees, find the number of trees planted and some basic statistics on when trees were planted:
 * 1. the number of years since the first tree of the species (this treeID) was planted,
 * 2. the number of years since the most recent tree of the species(this treeID) was planted.
 * 3. In addition, include the year that had the most trees of the species(this treeID) planted and the number of trees planted.
 */
public class TaskJ {
    public static void main(String[] args) {
        TreeSpeciesDAO treeSpeciesDAO = new TreeSpeciesDAO();

        System.out.println("Welcome to task J, you can see some relevant statistics of trees species planted in Oakland.");
        // for simplicity, we skip user login
        System.out.println("Please enter the tree species ID you want to search for:");
        Scanner scanner = new Scanner(System.in);
        int treeID = Integer.parseInt(scanner.nextLine().trim());
        treeSpeciesDAO.getTreeStatistics(treeID);

    }
}

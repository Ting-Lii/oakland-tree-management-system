// ting li, April 4, 2025
public class Main {
    public static void main(String[] args) {
        // only for test now, should let user input
        User newUser = new User("Ashley", "Lee", "ashleyLee@example.com", "badpassword", "94608", "resident", "Gaskill");
        UserDAO dao = new UserDAO();

        boolean success = dao.registerUser(newUser);
        if (success) {
            System.out.println("User registered successfully!");
        } else {
            System.out.println("Failed to register user! Please ensure your all input is valid!"); // might have
        }
    }
}

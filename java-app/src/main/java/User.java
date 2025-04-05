// ting li, April 4, 2025
public class User {
    private int uid;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String zipCode;
    private String role;
    private String neighborhood;

    // Constructor
    public User(String firstName, String lastName, String email, String password, String zipCode,String role, String neighborhood) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.zipCode = zipCode;
        this.role = role;
        this.neighborhood = neighborhood;
    }

    // Getters and Setters
    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getZipCode() {
        return zipCode;
    }
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public String getNeighborhood() {
        return neighborhood;
    }
    public void setNeighborhood(String neighborhood) {
        this.neighborhood = neighborhood;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid=" + uid +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", zipCode='" + zipCode + '\'' +
                ", role='" + role + '\'' +
                ", neighborhood='" + neighborhood + '\'' +
                '}';
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;

        User user = (User) o;

        if (uid != user.uid) return false;
        if (!firstName.equals(user.firstName)) return false;
        if (!lastName.equals(user.lastName)) return false;
        if (!email.equals(user.email)) return false;
        if (!password.equals(user.password)) return false;
        if (!zipCode.equals(user.zipCode)) return false;
        if (!role.equals(user.role)) return false;
        return neighborhood.equals(user.neighborhood);
    }
    @Override
    public int hashCode() {
        int result = uid;
        result = 31 * result + firstName.hashCode();
        result = 31 * result + lastName.hashCode();
        result = 31 * result + email.hashCode();
        result = 31 * result + password.hashCode();
        result = 31 * result + zipCode.hashCode();
        result = 31 * result + role.hashCode();
        result = 31 * result + neighborhood.hashCode();
        return result;
    }
    // validate user input
    public boolean isValid() {
        return firstName != null && !firstName.isEmpty() &&
               lastName != null && !lastName.isEmpty() &&
               email != null && !email.isEmpty() &&
               password != null && !password.isEmpty() &&
                zipCode != null && !zipCode.isEmpty() &&
               role != null && !role.isEmpty() &&
               neighborhood != null && !neighborhood.isEmpty();
    }
    public boolean isValidForLogin() {
        return email != null && !email.isEmpty() &&
               password != null && !password.isEmpty();
    }

}

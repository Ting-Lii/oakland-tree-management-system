package Model;

public class Volunteer extends User {
    private String applicationStatus;
    private Boolean isAvailable;

    public Volunteer(String firstName, String lastName, String email, String password, String zipCode, String role,
                     String applicationStatus, Boolean isAvailable) {
        super(firstName, lastName, email, password, zipCode, role); // inherit from User class
        this.applicationStatus = applicationStatus;
        this.isAvailable = isAvailable;
    }

    public String getApplicationStatus() {
        return applicationStatus;
    }

    public void setApplicationStatus(String applicationStatus) {
        this.applicationStatus = applicationStatus;
    }

    public Boolean getIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(Boolean isAvailable) {
        this.isAvailable = isAvailable;
    }
}

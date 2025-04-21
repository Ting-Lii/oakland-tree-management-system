package Model;

public class VolunteerPlant {
    private float workHour;
    private String workLoadFeedback;

    public VolunteerPlant(float workHour, String workLoadFeedback) {
        this.workHour = workHour;
        this.workLoadFeedback = workLoadFeedback;
    }

    public float getWorkHour() {
        return workHour;
    }

    public void setWorkHour(float workHour) {
        this.workHour = workHour;
    }

    public String getWorkLoadFeedback() {
        return workLoadFeedback;
    }

    public void setWorkLoadFeedback(String workLoadFeedback) {
        this.workLoadFeedback = workLoadFeedback;
    }
}

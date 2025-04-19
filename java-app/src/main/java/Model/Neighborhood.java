package Model;

public class Neighborhood {
    private String name;
    private String district;
    private String description;

    public Neighborhood(String name, String district, String description) {
        this.name = name;
        this.district = district;
        this.description = description;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDistrict() {
        return district;
    }
    public void setDistrict(String district) {
        this.district = district;
    }
    public String getDescription() {
        return description;
    }
}

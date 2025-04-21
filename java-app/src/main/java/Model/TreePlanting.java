package Model;

import java.util.Date;

public class TreePlanting {
    private Date plantDate;
    private String photoAfter;

    public TreePlanting(Date plantDate, String photoAfter) {
        this.plantDate = plantDate;
        this.photoAfter = photoAfter;
    }

    public Date getPlantDate() {
        return plantDate;
    }
    public void setPlantDate(Date plantDate) {
        this.plantDate = plantDate;
    }
    public String getPhotoAfter() {
        return photoAfter;
    }
    public void setPhotoAfter(String photoAfter) {
        this.photoAfter = photoAfter;
    }
}

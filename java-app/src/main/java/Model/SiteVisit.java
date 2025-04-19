package Model;

import java.sql.Date;

public class SiteVisit {
    private int aid;
    private Date siteVisitDate;
    private String visitStatus;
    private boolean isUnderPowerLine;
    private int minBedWidth;
    private String photoBefore;
    private int requestID;

    public SiteVisit(int aid, Date siteVisitDate, String visitStatus, boolean isUnderPowerLine,
                     int minBedWidth, String photoBefore, int requestID) {
        this.aid = aid;
        this.siteVisitDate = siteVisitDate;
        this.visitStatus = visitStatus;
        this.isUnderPowerLine = isUnderPowerLine;
        this.minBedWidth = minBedWidth;
        this.photoBefore = photoBefore;
        this.requestID = requestID;
    }

    public int getAid() {
        return aid;
    }

    public Date getSiteVisitDate() {
        return siteVisitDate;
    }

    public String getVisitStatus() {
        return visitStatus;
    }

    public boolean isUnderPowerLine() {
        return isUnderPowerLine;
    }

    public int getMinBedWidth() {
        return minBedWidth;
    }

    public String getPhotoBefore() {
        return photoBefore;
    }

    public int getRequestID() {
        return requestID;
    }
}

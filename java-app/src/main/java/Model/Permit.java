package Model;

import java.sql.Date;

public class Permit {
    private String permitID;
    private int rid;
    private String permitStatus;
    private Date issueDate;

    public Permit(String permitID, int rid, String permitStatus, Date issueDate) {
        this.permitID = permitID;
        this.rid = rid;
        this.permitStatus = permitStatus;
        this.issueDate = issueDate;
    }

    public String getPermitID() {
        return permitID;
    }
    public void setPermitID(String permitID) {
        this.permitID = permitID;
    }
    public int getRid() {
        return rid;
    }
    public void setRid(int rid) {
        this.rid = rid;
    }
    public String getPermitStatus() {
        return permitStatus;
    }
    public void setPermitStatus(String permitStatus) {
        this.permitStatus = permitStatus;
    }
    public Date getIssueDate() {
        return issueDate;
    }
    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

}
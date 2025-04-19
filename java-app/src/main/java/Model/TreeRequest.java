package Model;

import java.sql.Date;

public class TreeRequest {
    private String streetAddress;
    private String reqZipCode;
    private float amountOfPayment;
    private String relationshipToProperty;
    private Date dateSubmitted;
    private String requestStatus;
    private String phone;
    private String neighborhood;
    private int requestID;

    public TreeRequest(int requestID, String streetAddress, String reqZipCode, float amountOfPayment,
                       String relationshipToProperty, Date dateSubmitted, String requestStatus, String phone, String neighborhood) {
        this.requestID = requestID;
        this.streetAddress = streetAddress;
        this.reqZipCode = reqZipCode;
        this.amountOfPayment = amountOfPayment;
        this.relationshipToProperty = relationshipToProperty;
        this.dateSubmitted = dateSubmitted;
        this.requestStatus = requestStatus;
        this.phone = phone;
        this.neighborhood = neighborhood;
    }

    public int getRequestID() {
        return requestID;
    }
    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public String getStreetAddress() {
        return streetAddress;
    }
    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }
    public String getReqZipCode() {
        return reqZipCode;
    }
    public void setReqZipCode(String reqZipCode) {
        this.reqZipCode = reqZipCode;
    }
    public float getAmountOfPayment() {
        return amountOfPayment;
    }
    public void setAmountOfPayment(float amountOfPayment) {
        this.amountOfPayment = amountOfPayment;
    }
    public String getRelationshipToProperty() {
        return relationshipToProperty;
    }
    public void setRelationshipToProperty(String relationshipToProperty) {
        this.relationshipToProperty = relationshipToProperty;
    }
    public Date getDateSubmitted() {
        return dateSubmitted;
    }
    public void setDateSubmitted(Date dateSubmitted) {
        this.dateSubmitted = dateSubmitted;
    }
    public String getRequestStatus() {
        return requestStatus;
    }
    public void setRequestStatus(String requestStatus) {
        this.requestStatus = requestStatus;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getNeighborhood() {
        return neighborhood;
    }
    public void setNeighborhood(String neighborhood) {
        this.neighborhood = neighborhood;
    }
}

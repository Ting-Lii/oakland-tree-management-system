// Ting Li
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

public class TreeRequestDAO {

    public boolean canSubmitTreeRequest(int rid, String address, LocalDate dateSubmitted, String phone, float budget,
                                        String relationship, String zipCode, String neighborhood) {
        // default requestStatus is 'submitted'
        String sql = "INSERT INTO treeRequests (rid, streetAddress, dateSubmitted, phone, amountOfPayment, relationshipToProperty, reqZipCode, requestStatus, neighborhood) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, 'submitted', ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, rid);
            stmt.setString(2, address);
            stmt.setDate(3, java.sql.Date.valueOf(dateSubmitted));
            stmt.setString(4, phone);
            stmt.setFloat(5, budget);
            stmt.setString(6, relationship);
            stmt.setString(7, zipCode);
            stmt.setString(8, neighborhood);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.out.println("Error while submitting tree request:");
            e.printStackTrace();
            return false;
        }
    }


}

package com.example.vacante.Controller;

import com.example.vacante.Entities.Reservation;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

public class ReservationController {
    @FXML
    private Label offerDetailsLabel;

    private double hotelId;
    private double clientId;
    private LocalDate startDate;
    private int noNights;
    private final String url = "jdbc:postgresql://localhost/vacante";
    private final String user = "postgres";
    private final String password = "parola";


    public void initialize() {
        // Initialize with data passed from the special offers window
    }

    public void setData(double hotelId, double clientId, LocalDate startDate, int noNights) {
        this.hotelId = hotelId;
        this.clientId = clientId;
        this.startDate = startDate;
        this.noNights = noNights;
        offerDetailsLabel.setText("Reservation at Hotel ID: " + hotelId + " from " + startDate + " for " + noNights + " nights.");
    }

    @FXML
    protected void handleConfirmReservation() {
        // Logic to insert reservation into the database
        insertReservationIntoDatabase();

        // Show alert confirming the reservation
        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle("Reservation Confirmed");
        alert.setHeaderText(null);
        alert.setContentText("Your reservation has been confirmed!");
        alert.showAndWait();
    }

    private void insertReservationIntoDatabase() {
        String query = "INSERT INTO reservations (reservation_id, client_id, hotel_id, start_date, no_nights) VALUES (?, ?, ?, ?, ?)";
        // Use the next available ID for reservation_id, or use a sequence in PostgreSQL to auto-generate it
        double reservationId = getNextReservationId();

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setDouble(1, reservationId);
            pst.setDouble(2, clientId);
            pst.setDouble(3, hotelId);
            pst.setObject(4, startDate); // Assuming startDate is a java.sql.Date
            pst.setInt(5, noNights);

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
    }

    private double getNextReservationId() {

        return 0;
    }
}
        // Implement logic to retrieve the next reservation ID
        // This could be done by querying the database for the max ID and

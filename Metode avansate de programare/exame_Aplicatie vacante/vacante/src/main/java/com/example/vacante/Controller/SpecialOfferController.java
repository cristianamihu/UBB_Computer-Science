package com.example.vacante.Controller;

import com.example.vacante.Entities.SpecialOffer;
import com.example.vacante.Entities.SpecialOfferExtended;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.Period;
import java.util.Date;
import java.util.List;

public class SpecialOfferController {

    public TableColumn hotelNameColumn;
    public TableColumn locationNameColumn;
    public TableColumn startDateColumn;
    public TableColumn endDateColumn;
    public TableColumn percentColumn;
    @FXML
    private DatePicker startDatePicker;
    @FXML
    private DatePicker endDatePicker;
    @FXML
    private TableView<SpecialOffer> specialOffersTable;

    private final String url = "jdbc:postgresql://localhost/vacante";
    private final String user = "postgres";
    private final String password = "parola";

    private double hotelId; // The hotel ID for which to show special offers

    private double clientId;

    public void setClientId(double clientId) {
        this.clientId = clientId;
        // You can now use this clientId when creating reservations
    }

    @FXML
    private void onShowOffers() {
        LocalDate startDate = startDatePicker.getValue();
        LocalDate endDate = endDatePicker.getValue();
        if (startDate != null && endDate != null) {
            List<SpecialOfferExtended> offers = getSpecialOffers(hotelId, startDate, endDate);
            ObservableList<SpecialOffer> offersObservableList = FXCollections.observableArrayList(offers);
            specialOffersTable.setItems(offersObservableList);
        }
    }

    public void setHotelId(double id) {
        hotelId = id;
    }

    @FXML
    private void onOfferSelected() {
        SpecialOffer selectedOffer = specialOffersTable.getSelectionModel().getSelectedItem();
        if (selectedOffer != null) {
            openReservationConfirmationWindow(selectedOffer);
        }
    }

    private int calculateNumberOfNights(LocalDate start, LocalDate end) {
        return Period.between(start, end).getDays();
    }

    private void openReservationConfirmationWindow(SpecialOffer offer) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/utils/ReservationConfirmation.fxml"));
            Parent root = loader.load();

            ReservationController controller = loader.getController();
            controller.setData(offer.getHotelId(), clientId, offer.getStartDate(), calculateNumberOfNights(offer.getStartDate(), offer.getEndDate()));

            Stage stage = new Stage();
            stage.setTitle("Confirm Reservation");
            stage.setScene(new Scene(root));
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
            // Handle exception
        }
    }

    private ObservableList<SpecialOfferExtended> getSpecialOffers(double hotelId, LocalDate startDate, LocalDate endDate) {
        ObservableList<SpecialOfferExtended> specialOffers = FXCollections.observableArrayList();
        String query = "SELECT so.*, h.hotel_name, l.location_name " +
                "FROM special_offers so " +
                "JOIN hotels h ON so.hotel_id = h.hotel_id " +
                "JOIN locations l ON h.location_id = l.location_id " +
                "WHERE so.hotel_id = ? AND so.start_date <= ? AND so.end_date >= ?";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setDouble(1, hotelId);
            pst.setDate(2, java.sql.Date.valueOf(startDate));
            pst.setDate(3, java.sql.Date.valueOf(endDate));

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    double offerId = rs.getDouble("special_offer_id");
                    double fetchedHotelId = rs.getDouble("hotel_id"); // This should match the hotelId parameter
                    Date fetchedStartDate = rs.getDate("start_date");
                    Date fetchedEndDate = rs.getDate("end_date");
                    int percent = rs.getInt("percent");
                    String hotelName = rs.getString("hotel_name");
                    String locationName = rs.getString("location_name");

                    SpecialOfferExtended offer = new SpecialOfferExtended(
                            offerId,
                            fetchedHotelId,
                            ((java.sql.Date) fetchedStartDate).toLocalDate(),
                            ((java.sql.Date) fetchedEndDate).toLocalDate(),
                            percent,
                            hotelName,
                            locationName
                    );
                    specialOffers.add(offer);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }

        return specialOffers;
    }

    // Initialize and other methods...
}

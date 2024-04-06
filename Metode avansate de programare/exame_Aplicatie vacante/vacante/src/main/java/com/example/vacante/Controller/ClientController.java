package com.example.vacante.Controller;
import com.example.vacante.Controller.SpecialOfferController;
import com.example.vacante.Entities.Client;
import com.example.vacante.Entities.SpecialOffer;
import com.example.vacante.Entities.SpecialOfferExtended;
import com.example.vacante.Entities.Location;
import com.example.vacante.Entities.Hotel;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.VBox;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.List;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class ClientController {

    public TableColumn locationIdColumn;
    public TableColumn hotelIdColumn;
    public TableColumn noRooms;
    public TableColumn pricePerNight;
    public TableColumn type;
    @FXML
    private VBox clientWindow;

    @FXML
    private Label clientIdLabel;

    @FXML
    private Label nameLabel;

    @FXML
    private TableView<SpecialOfferExtended> offersTable;

    @FXML
    private TableColumn<SpecialOffer, String> hotelNameColumn;

    @FXML
    private TableColumn<SpecialOffer, String> locationNameColumn;

    @FXML
    private TableColumn<SpecialOffer, LocalDate> startDateColumn;

    @FXML
    private TableColumn<SpecialOffer, LocalDate> endDateColumn;

    @FXML
    private TableColumn<SpecialOffer, Integer> percentColumn;

    @FXML
    private ComboBox<String> locationComboBox;
    @FXML
    private TableView<Hotel> hotelsTable;
    @FXML
    private TableColumn<Hotel, String> hotelNameColumn2;
    @FXML
    private DatePicker startDatePicker;
    @FXML
    private DatePicker endDatePicker;

    private double clientId;

    public void setClientId(double clientId) {
        this.clientId = clientId;
        // You can now use this clientId when creating reservations
    }

    // Database credentials and URL
    private final String url = "jdbc:postgresql://localhost/vacante";
    private final String user = "postgres";
    private final String password = "parola";

    public void initialize() {

        hotelNameColumn.setCellValueFactory(new PropertyValueFactory<>("name"));
        populateLocations();

        // Set up the columns in the table
        hotelNameColumn.setCellValueFactory(new PropertyValueFactory<>("hotelName"));
        locationNameColumn.setCellValueFactory(new PropertyValueFactory<>("locationName"));
        startDateColumn.setCellValueFactory(new PropertyValueFactory<>("startDate"));
        endDateColumn.setCellValueFactory(new PropertyValueFactory<>("endDate"));
        percentColumn.setCellValueFactory(new PropertyValueFactory<>("percent"));

        // You might want to call a method here to populate the table with data
    }

    // Method to open the client window with the specified ID.
    public void openClientWindow(Long clientId) {
        Client client = retrieveClientFromDatabase(clientId);
        ObservableList<SpecialOfferExtended> specialOffers = retrieveSpecialOffers(clientId);

        // Update UI elements with the retrieved data.
        if (client != null) {
            clientIdLabel.setText("Client ID: " + client.getClientId());
            nameLabel.setText("Name: " + client.getName());
            offersTable.setItems(specialOffers);
            offersTable.refresh();
        } else {
            // Handle the case where the client is not found.
            System.out.println("Client with ID " + clientId + " not found.");
        }
    }

    private Client retrieveClientFromDatabase(Long clientId) {
        Client client = null;

        String query = "SELECT * FROM clients WHERE client_id = ?";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setLong(1, clientId);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    Long id = rs.getLong("client_id");
                    String name = rs.getString("name");
                    int fidelityGrade = rs.getInt("fidelity_grade");
                    int age = rs.getInt("age");
                    String[] hobbiesArray = (String[]) rs.getArray("hobbies").getArray();
                    EnumSet<Client.Hobby> hobbies = EnumSet.noneOf(Client.Hobby.class);
                    for (String hobby : hobbiesArray) {
                        hobbies.add(Client.Hobby.valueOf(hobby));
                    }

                    client = new Client(id, name, fidelityGrade, age, hobbies);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions such as SQLExceptions
        }
        return client;
    }

    private ObservableList<SpecialOfferExtended> retrieveSpecialOffers(Long clientId) {
        ObservableList<SpecialOfferExtended> specialOffers = FXCollections.observableArrayList();

        String query = "SELECT so.*, h.hotel_name, l.location_name " +
                "FROM special_offers so " +
                "JOIN hotels h ON so.hotel_id = h.hotel_id " +
                "JOIN locations l ON h.location_id = l.location_id " +
                "JOIN clients c ON c.client_id = ? " +
                "WHERE so.end_date >= CURRENT_DATE AND c.fidelity_grade > so.percent";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setLong(1, clientId);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    // Assuming SpecialOffer has a constructor that matches these parameters
                    SpecialOfferExtended offer = new SpecialOfferExtended(
                            rs.getDouble("special_offer_id"),
                            rs.getDouble("hotel_id"),
                            rs.getDate("start_date").toLocalDate(),
                            rs.getDate("end_date").toLocalDate(),
                            rs.getInt("percent"),
                            rs.getString("hotel_name"),
                            rs.getString("location_name")
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

    private void populateLocations() {
        ObservableList<Location> locations = FXCollections.observableArrayList(retrieveLocationsFromDatabase());
        ObservableList<String> locationString = FXCollections.observableArrayList();
        for (Location l: locations
             ) {
            locationString.add(l.getLocationName());
        }
        locationComboBox.setItems(locationString);
        // If you want to display a specific property of Location in the ComboBox, use a StringConverter
    }

    @FXML
    private void onLocationSelected() {
        String selectedLocation = locationComboBox.getValue();
        if (selectedLocation != null) {
            Location locc = findLocationByString(selectedLocation);
            populateHotelsTable(locc);
        }
    }

    private Location findLocationByString(String location){
        //ObservableList<Location> locs = FXCollections.observableArrayList();

        String query = "SELECT * FROM locations l WHERE l.location_name = ? ";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setString(1, location);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    // Assuming SpecialOffer has a constructor that matches these parameters
                    Location loc = new Location(
                            rs.getDouble("location_id"),
                            rs.getString("location_name")
                    );
                    return loc;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }
        return null;
    }

    private void populateHotelsTable(Location location) {
        ObservableList<Hotel> hotels = FXCollections.observableArrayList(retrieveHotelsFromDatabase(location));
        hotelsTable.setItems(hotels);
        hotelsTable.refresh();
    }

    private List<Location> retrieveLocationsFromDatabase() {
        List<Location> locations = new ArrayList<>();

        String query = "SELECT * FROM locations";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = conn.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Location location = new Location(
                        rs.getLong("location_id"),
                        rs.getString("location_name")
                );
                locations.add(location);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }

        return locations;
    }

    private List<Hotel> retrieveHotelsFromDatabase(Location location) {
        List<Hotel> hotels = new ArrayList<>();

        String query = "SELECT * FROM hotels h WHERE h.location_id = ?";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setDouble(1, location.getLocationId());

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Hotel hotel = new Hotel(
                            rs.getLong("hotel_id"),
                            rs.getLong("location_id"),
                            rs.getString("hotel_name"),
                            rs.getInt("no_rooms"),
                            rs.getDouble("price_per_night"),
                            rs.getString("type")
                    );
                    hotels.add(hotel);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }

        return hotels;
    }

    @FXML
    private void onHotelSelected() {
        Hotel selectedHotel = hotelsTable.getSelectionModel().getSelectedItem();
        if (selectedHotel != null) {
            openSpecialOffersWindow(selectedHotel.getHotelId(),this.clientId);
        }
    }

    private void openSpecialOffersWindow(double hotelId, double clientId) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/utils/special_offers_window.fxml"));
            Parent root = loader.load();

            SpecialOfferController controller = loader.getController();
            controller.setHotelId(hotelId);
            controller.setClientId(clientId);

            Stage stage = new Stage();
            stage.setTitle("Special Offers");
            stage.setScene(new Scene(root));
            stage.show();
        } catch (IOException e) {
            e.printStackTrace();
            // Handle exception
        }
    }
    public void closeWindow(ActionEvent actionEvent) {

    }
}


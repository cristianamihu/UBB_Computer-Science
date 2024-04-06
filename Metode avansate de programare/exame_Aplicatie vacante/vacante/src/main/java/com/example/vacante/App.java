package com.example.vacante;

import com.example.vacante.Controller.ClientController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.util.List;
import javafx.application.Application;
import javafx.stage.Stage;

public class App extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        // Get command line parameters
        List<String> parameters = getParameters().getRaw();

        // Iterate through each client ID and open a window for each
        for (String clientIdString : parameters) {
            try {
                Long clientId = Long.parseLong(clientIdString);

                // Load the FXML for each client window
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/utils/ClientWindow.fxml"));
                Parent root = loader.load();

                // Set the client ID in the controller
                ClientController controller = loader.getController();
                controller.setClientId(clientId);
                controller.openClientWindow(clientId);

                // Create a new stage (window) for each client
                Stage clientStage = new Stage();
                clientStage.setTitle("Client Details - " + clientId);
                clientStage.setScene(new Scene(root));
                clientStage.show();
            } catch (NumberFormatException e) {
                System.out.println("Invalid client ID: " + clientIdString);
            }
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}


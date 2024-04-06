module com.example.vacante {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;

    opens com.example.vacante.Entities to javafx.base, javafx.fxml;

    opens com.example.vacante to javafx.fxml;
    exports com.example.vacante;
    opens com.example.vacante.Controller to javafx.fxml;
    exports com.example.vacante.Controller;
}
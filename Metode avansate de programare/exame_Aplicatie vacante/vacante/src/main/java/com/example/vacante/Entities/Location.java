package com.example.vacante.Entities;

public class Location {
    private double locationId;
    private String locationName;

    public Location(double locationId, String locationName) {
        this.locationId = locationId;
        this.locationName = locationName;
    }

    public double getLocationId() {
        return locationId;
    }

    public void setLocationId(double locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }
}
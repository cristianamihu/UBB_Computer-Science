package com.example.vacante.Entities;

import java.time.LocalDate;

public class SpecialOfferExtended extends SpecialOffer{
    private String hotelName;
    private String locationName;
    public SpecialOfferExtended(double specialOfferId, double hotelId, LocalDate startDate, LocalDate endDate, int percent) {
        super(specialOfferId, hotelId, startDate, endDate, percent);
    }

    public SpecialOfferExtended(double specialOfferId, double hotelId, LocalDate startDate, LocalDate endDate, int percent, String hotelName, String locationName) {
        super(specialOfferId, hotelId, startDate, endDate, percent);
        this.hotelName = hotelName;
        this.locationName = locationName;
    }

    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }
}

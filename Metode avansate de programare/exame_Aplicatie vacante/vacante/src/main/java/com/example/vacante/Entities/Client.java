package com.example.vacante.Entities;
import java.util.EnumSet;

public class Client {

    public enum Hobby {
        READING, MUSIC, HIKING, WALKING, EXTREME_SPORTS
    }

    private Long clientId;
    private String name;
    private int fidelityGrade;
    private int age;
    private EnumSet<Hobby> hobbies;

    // Constructor, getters, setters, and other methods will be here

    public Client(Long clientId, String name, int fidelityGrade, int age, EnumSet<Hobby> hobbies) {
        this.clientId = clientId;
        this.name = name;
        this.fidelityGrade = checkFidelityGrade(fidelityGrade);
        this.age = age;
        this.hobbies = hobbies;
    }

    private int checkFidelityGrade(int fidelityGrade) {
        if (fidelityGrade < 1 || fidelityGrade > 100) {
            throw new IllegalArgumentException("Fidelity grade must be within the range [1, 100].");
        }
        return fidelityGrade;
    }

    public Long getClientId() {
        return clientId;
    }

    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getFidelityGrade() {
        return fidelityGrade;
    }

    public void setFidelityGrade(int fidelityGrade) {
        this.fidelityGrade = fidelityGrade;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public EnumSet<Hobby> getHobbies() {
        return hobbies;
    }

    public void setHobbies(EnumSet<Hobby> hobbies) {
        this.hobbies = hobbies;
    }
}


package com.paloit.meeting_room_booking.model;

import java.time.LocalDateTime;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public class FormBooking {
    @NotNull(message = "Number of people is required")
    @Positive
    private Integer nbPeople;
    @NotNull(message = "Start date is required")
    private LocalDateTime start;
    @NotNull(message = "End date is required")
    private LocalDateTime end;

    public Boolean isFormValid(){
        return this.getEnd() != null && this.getStart() != null && this.getNbPeople() > 0;
    }

    public Integer getNbPeople() {
        return this.nbPeople;
    }

    public void setNbPeople(Integer nbPeople) {
        this.nbPeople = nbPeople;
    }

    public LocalDateTime getStart() {
        return this.start;
    }

    public void setStart(LocalDateTime start) {
        this.start = start;
    }

    public LocalDateTime getEnd() {
        return this.end;
    }

    public void setEnd(LocalDateTime end) {
        this.end = end;
    }

}
